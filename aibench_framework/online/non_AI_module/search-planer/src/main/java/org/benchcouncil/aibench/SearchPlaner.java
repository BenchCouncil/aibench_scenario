package org.benchcouncil.aibench;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;
import lombok.extern.slf4j.Slf4j;
import org.apache.http.util.EntityUtils;
import org.elasticsearch.action.get.GetResponse;
import org.elasticsearch.action.get.MultiGetItemResponse;
import org.elasticsearch.action.get.MultiGetRequest;
import org.elasticsearch.action.get.MultiGetResponse;
import org.elasticsearch.action.search.SearchRequest;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.client.Request;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.Response;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.index.query.MatchQueryBuilder;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.builder.SearchSourceBuilder;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.http.HttpEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.nio.file.Files;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@RestController
@Slf4j
public class SearchPlaner {

    private final RestHighLevelClient excellentProductSearchClient;
    private final RestHighLevelClient goodProductSearchClient;
    private final RestHighLevelClient badProductSearchClient;
    private final RestHighLevelClient rankerClient;
    private final RestHighLevelClient productClient;
    private final int FETCH_SIZE = 2000;
    private final int PAGE_SIZE = 10;
    private final String FIELD = "title";

    int totalSearch = 0;
    int goodSearch = 0;
    int badSearch = 0;

    private String excellentProductSearchIndex;
    private String goodProductSearchIndex;
    private String badProductSearchIndex;
    private String rankerIndex;
    private String productIndex;
    private String recommenderURL;
    private String rankerURL;

    public SearchPlaner(@Value("${recommender.url}") String recommenderURL,
                        @Value("${excellent_product_search_index}") String excellentProductSearchIndex,
                        @Value("${ranker.url}") String rankerURL,
                        @Value("${good_product_search_index}") String goodProductSearchIndex,
                        @Value("${bad_product_search_index}") String badProductSearchIndex,
                        @Value("${ranker_index}") String rankerIndex,
                        @Value("${product}") String productIndex) {
        ApplicationContext context = new ClassPathXmlApplicationContext("factorybean-spring-ctx.xml");

        this.excellentProductSearchClient = ((SearchClient) context.getBean("excellentProductSearchClient")).getClient();
        this.goodProductSearchClient = ((SearchClient) context.getBean("goodProductSearchClient")).getClient();
        this.badProductSearchClient = ((SearchClient) context.getBean("badProductSearchClient")).getClient();
//        this.badProductSearchClient = null;
        this.rankerClient = ((SearchClient) context.getBean("rankerClient")).getClient();
        this.productClient = ((SearchClient) context.getBean("productClient")).getClient();
        this.recommenderURL = recommenderURL;
        this.rankerURL = rankerURL;
        this.excellentProductSearchIndex = excellentProductSearchIndex;
        this.goodProductSearchIndex = goodProductSearchIndex;
        this.badProductSearchIndex = badProductSearchIndex;
        this.rankerIndex = rankerIndex;
        this.productIndex = productIndex;
    }


    @GetMapping("/")
    String welcome() {
        return "Welcome!";
    }

    @PostMapping("/test")
    String getMyId(@RequestBody QueryInfo queryInfo) {
        log.debug(String.valueOf(queryInfo));
        return String.valueOf(new Random().nextLong());
    }

    @PostMapping("/img")
    List<GetResponse> imgSearch(@RequestParam("image") MultipartFile file) {
        long[] timeStamps = new long[5];
        timeStamps[0] = System.nanoTime();
        List<GetResponse> summaries = null;
        try {
            byte[] bytes = file.getBytes();

            QueryInfo queryInfo = new QueryInfo(0, "1", "177860 13976 14619 25247 13578 177860 13976 14619");

            String TEMP_FILE_PREFIX = "TEMP_FILE_PREFIX";
            String TEMP_FILE_POSTFIX = "TEMP_FILE_POSTFIX";
            File tempFile = File.createTempFile(TEMP_FILE_PREFIX, TEMP_FILE_POSTFIX);
            tempFile.deleteOnExit();
            file.transferTo(tempFile);
            List<Double> weights = analyseImage(tempFile);
            tempFile.delete();

            timeStamps[1] = System.nanoTime();
            List<String> docIds = matchPhase(queryInfo.getQuery());

            timeStamps[2] = System.nanoTime();
            docIds = rankingPhase(docIds, rankerIndex, queryInfo.getQuery(), weights);

            timeStamps[3] = System.nanoTime();
            summaries = fetchPhase(productIndex, docIds);

            timeStamps[4] = System.nanoTime();
            log.info(queryInfo.getQid() + ":" + Arrays.toString(timeStamps));
//            log.info("totalSearch: " + totalSearch + ", goodSearch: " + goodSearch + ", badSearch: " + badSearch);

        } catch (IOException e) {
            e.printStackTrace();
        }
        return summaries;
    }

    @PostMapping("/search")
    List<GetResponse> search(@RequestBody QueryInfo queryInfo) throws IOException {
        long[] timeStamps = new long[5];
        timeStamps[0] = System.nanoTime();
        List<Double> weights = analyseQuery(queryInfo.getQid(), queryInfo.getUid(), queryInfo.getQuery());

        timeStamps[1] = System.nanoTime();
        List<String> docIds = matchPhase(queryInfo.getQuery());

        timeStamps[2] = System.nanoTime();
        docIds = rankingPhase(queryInfo.getQid(), docIds);
//        docIds = rankingPhase(docIds, rankerIndex, queryInfo.getQuery(), weights);

        timeStamps[3] = System.nanoTime();
        List<GetResponse> summaries = fetchPhase(productIndex, docIds);

        timeStamps[4] = System.nanoTime();
        log.info(queryInfo.getQid() + ":" + Arrays.toString(timeStamps));
//        log.info("totalSearch: " + totalSearch + ", goodSearch: " + goodSearch + ", badSearch: " + badSearch);

        return summaries;
    }

    private List<Double> analyseQuery(int qid, String uid, String query) {
        RestTemplate restTemplate = new RestTemplate();
        HttpEntity<QueryInfo> request = new HttpEntity<>(new QueryInfo(qid, uid, query));
        Weights weights = restTemplate.postForObject(recommenderURL + "/query", request, Weights.class);

        return Objects.requireNonNull(weights).getWeights();
    }

    private List<Double> analyseImage(File image) {
        String url = recommenderURL + "/img";
        String charset = "UTF-8";
        String param = "image";
        File textFile = new File("/path/to/file.txt");
        File binaryFile = image;
        String boundary = Long.toHexString(System.currentTimeMillis()); // Just generate some unique random value.
        String CRLF = "\r\n"; // Line separator required by multipart/form-data.

        URLConnection connection = null;
        try {
            connection = new URL(url).openConnection();
        } catch (IOException e) {
            e.printStackTrace();
        }
        connection.setDoOutput(true);
        connection.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + boundary);

        try (
                OutputStream output = connection.getOutputStream();
                PrintWriter writer = new PrintWriter(new OutputStreamWriter(output, charset), true);
        ) {
            // Send normal param.
            writer.append("--" + boundary).append(CRLF);
            writer.append("Content-Disposition: form-data; name=\"image\"").append(CRLF);
            writer.append("Content-Type: text/plain; charset=" + charset).append(CRLF);
            writer.append(CRLF).append(param).append(CRLF).flush();

            // Send text file.
//            writer.append("--" + boundary).append(CRLF);
//            writer.append("Content-Disposition: form-data; name=\"textFile\"; filename=\"" + textFile.getName() + "\"").append(CRLF);
//            writer.append("Content-Type: text/plain; charset=" + charset).append(CRLF); // Text file itself must be saved in this charset!
//            writer.append(CRLF).flush();
//            Files.copy(textFile.toPath(), output);
//            output.flush(); // Important before continuing with writer!
//            writer.append(CRLF).flush(); // CRLF is important! It indicates end of boundary.

            // Send binary file.
            writer.append("--" + boundary).append(CRLF);
            writer.append("Content-Disposition: form-data; name=\"image\"; filename=\"" + binaryFile.getName() + "\"").append(CRLF);
            writer.append("Content-Type: " + URLConnection.guessContentTypeFromName(binaryFile.getName())).append(CRLF);
            writer.append("Content-Transfer-Encoding: binary").append(CRLF);
            writer.append(CRLF).flush();
            Files.copy(binaryFile.toPath(), output);
            output.flush(); // Important before continuing with writer!
            writer.append(CRLF).flush(); // CRLF is important! It indicates end of boundary.

            // End of multipart/form-data.
            writer.append("--" + boundary + "--").append(CRLF).flush();
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }

// Request is lazily fired whenever you need to obtain information about response.
        try {
            int responseCode = ((HttpURLConnection) connection).getResponseCode();
        } catch (IOException e) {
            e.printStackTrace();
        }

        return Arrays.asList(1.0, 1.0, 1.0);
    }

    private List<String> matchPhase(String query) throws IOException {
        totalSearch++;
        SearchRequest request = buildRequest(excellentProductSearchIndex, FIELD, query, FETCH_SIZE);
        List<String> docIds = new ArrayList<>();
        SearchResponse response = excellentProductSearchClient.search(request, RequestOptions.DEFAULT);
        addToDocs(docIds, response);

        if (response.getHits().totalHits < FETCH_SIZE) {
            goodSearch++;
            request = buildRequest(goodProductSearchIndex, FIELD, query, FETCH_SIZE);
            response = goodProductSearchClient.search(request, RequestOptions.DEFAULT);
            docIds.clear();
            addToDocs(docIds, response);

            long fetchedSize = response.getHits().totalHits;
            if (fetchedSize < FETCH_SIZE) {
                badSearch++;
                request = buildRequest(badProductSearchIndex, FIELD, query, (int) (FETCH_SIZE - fetchedSize));
                response = badProductSearchClient.search(request, RequestOptions.DEFAULT);
                addToDocs(docIds, response);
            }
        }

        log.debug("matchPhase: " + docIds.toString());

        return docIds;
    }

    private SearchRequest buildRequest(String index, String field, String query, int fetchSize) {
        SearchRequest request = new SearchRequest(index);
        SearchSourceBuilder builder = new SearchSourceBuilder();
        builder.fetchSource(false);
        builder.query(new MatchQueryBuilder(field, query));
        builder.from(0);
        builder.size(FETCH_SIZE);
        request.source(builder);
        return request;
    }

    private void addToDocs(List<String> docIds, SearchResponse response) {
        for (SearchHit hit : response.getHits().getHits()) {
            docIds.add(hit.getId());
        }
    }

    private List<String> rankingPhase(List<String> docIds, String index, String query, List<Double> weights) throws IOException {

        String queryTemplate = "{\"_source\":false,\"query\":{\"bool\":{\"filter\":{\"terms\":{\"_id\":%s}}}},\"rescore\":{\"window_size\":%d,\"query\":{\"rescore_query\":{\"function_score\":{\"query\":{\"match\":{\"title\":\"%s\"}},\"functions\":[{\"field_value_factor\":{\"field\":\"price\",\"factor\":%s}},{\"field_value_factor\":{\"field\":\"ratesum\",\"factor\":%s}}],\"boost\":%s,\"score_mode\":\"sum\",\"boost_mode\":\"sum\"}}}}}";
        ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
        String idsString = ow.writeValueAsString(docIds);

        String queryJsonString = String.format(
                queryTemplate,
                idsString, FETCH_SIZE, query,
                String.valueOf(weights.get(1)),
                String.valueOf(weights.get(2)),
                String.valueOf(weights.get(0)));
        log.debug(queryJsonString);

        Request request = new Request("GET", "/" + index + "/_search");
        request.setJsonEntity(queryJsonString);
        Response response = rankerClient.getLowLevelClient().performRequest(request);

        String responseJson = EntityUtils.toString(response.getEntity());

        Pattern pattern = Pattern.compile("_id\":\"(.*?)\",");
        Matcher matcher = pattern.matcher(responseJson);

        List<String> rescoreDocIds = new ArrayList<>();
        while (matcher.find()) {
            rescoreDocIds.add(matcher.group(1));
        }

        log.debug("rankingPhase: " + rescoreDocIds.toString());

        return rescoreDocIds.subList(0, Math.min(PAGE_SIZE, rescoreDocIds.size()));
    }

    private List<String> rankingPhase(int uid, List<String> docIds) {
        RestTemplate restTemplate = new RestTemplate();
        List<UserItem> userItems = new ArrayList<>();
        userItems.add(new UserItem(1, 1));
        HttpEntity<DocIds> request = new HttpEntity<>(new DocIds(userItems));
        Ratings ratings = restTemplate.postForObject(rankerURL + "/v1/models/ncf:predict", request, Ratings.class);
        docIds = new ArrayList<>();
        for (Rating prediction : ratings.getPredictions()) {
            docIds.add(String.valueOf(prediction.getItem_id()));
        }
        log.debug("rankingPhase: " + docIds.toString());
        return docIds;
    }

    private List<GetResponse> fetchPhase(String index, List<String> docIds) throws IOException {
        List<GetResponse> responses = new ArrayList<>();
        if (docIds.isEmpty()) {
            return responses;
        }

        MultiGetRequest request = new MultiGetRequest();
        docIds.forEach(id -> request.add(index, "_doc", id));
        MultiGetResponse response = productClient.mget(request, RequestOptions.DEFAULT);

        for (MultiGetItemResponse multiGetItemResponse : response) {
//            log.info(String.valueOf(multiGetItemResponse.getResponse()));
            responses.add(multiGetItemResponse.getResponse());
        }

        return responses;
    }
}
