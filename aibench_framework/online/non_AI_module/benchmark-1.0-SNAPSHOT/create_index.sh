EXCELLENT_HOST="localhost"
GOOD_HOST="localhost"
BAD_HOST="localhost"
RANKING_HOST="localhost"
SUMMARY_HOST="localhost"

curl -XPUT "http://${EXCELLENT_HOST}:9200/excellent_items" -H 'Content-Type: application/json' -d'
{
  "settings": {
    "number_of_shards": 1,
    "number_of_replicas": 0
  },
  "mappings": {
    "_doc": {
      "dynamic": "strict",
      "properties": {
        "title": {
          "type": "text",
          "analyzer": "whitespace"
        },
        "related_items": {
          "type": "keyword"
        }
      }
    }
  }
}'
echo ""

curl -XPUT "http://${GOOD_HOST}:9200/good_items" -H 'Content-Type: application/json' -d'
{
  "settings": {
    "number_of_shards": 1,
    "number_of_replicas": 0
  },
  "mappings": {
    "_doc": {
      "dynamic": "strict",
      "properties": {
        "title": {
          "type": "text",
          "analyzer": "whitespace"
        },
        "related_items": {
          "type": "keyword"
        }
      }
    }
  }
}'
echo ""

curl -XPUT "http://${BAD_HOST}:9200/bad_items" -H 'Content-Type: application/json' -d'
{
  "settings": {
    "number_of_shards": 1,
    "number_of_replicas": 0
  },
  "mappings": {
    "_doc": {
      "dynamic": "strict",
      "properties": {
        "title": {
          "type": "text",
          "analyzer": "whitespace"
        },
        "related_items": {
          "type": "keyword"
        }
      }
    }
  }
}'
echo ""

curl -XPUT "http://${RANKING_HOST}:9200/ranking" -H 'Content-Type: application/json' -d'
{
  "settings": {
    "number_of_shards": 1,
    "number_of_replicas": 0
  },
  "mappings": {
    "_doc": {
      "dynamic": "strict",
      "properties": {
        "title": {
          "type": "text",
          "analyzer": "whitespace"
        },
        "price": {
          "type": "double"
        },
        "ratesum": {
          "type": "integer"
        },
        "category": {
          "type": "keyword"
        }
      }
    }
  }
}'
echo ""

curl -XPUT "http://${SUMMARY_HOST}:9200/summary" -H 'Content-Type: application/json' -d'
{
  "settings": {
    "number_of_shards": 1,
    "number_of_replicas": 0
  },
  "mappings": {
    "_doc": {
      "dynamic": "strict",
      "properties": {
        "title": {
          "type": "keyword",
          "doc_values": false,
          "index": false
        },
        "price": {
          "type": "double",
          "doc_values": false,
          "index": false
        },
        "ratesum": {
          "type": "integer",
          "doc_values": false,
          "index": false
        },
        "category": {
          "type": "keyword",
          "doc_values": false,
          "index": false
        },
        "related_items": {
          "type": "keyword",
          "doc_values": false,
          "index": false
        },
        "a": {
          "type": "keyword",
          "doc_values": false,
          "index": false
        },
        "b": {
          "type": "keyword",
          "doc_values": false,
          "index": false
        },
        "c": {
          "type": "keyword",
          "doc_values": false,
          "index": false
        },
        "d": {
          "type": "keyword",
          "doc_values": false,
          "index": false
        },
        "e": {
          "type": "keyword",
          "doc_values": false,
          "index": false
        },
        "f": {
          "type": "keyword",
          "doc_values": false,
          "index": false
        },
        "g": {
          "type": "keyword",
          "doc_values": false,
          "index": false
        },
        "h": {
          "type": "keyword",
          "doc_values": false,
          "index": false
        },
        "i": {
          "type": "keyword",
          "doc_values": false,
          "index": false
        },
        "j": {
          "type": "keyword",
          "doc_values": false,
          "index": false
        },
        "k": {
          "type": "keyword",
          "doc_values": false,
          "index": false
        },
        "l": {
          "type": "keyword",
          "doc_values": false,
          "index": false
        },
        "m": {
          "type": "keyword",
          "doc_values": false,
          "index": false
        },
        "n": {
          "type": "keyword",
          "doc_values": false,
          "index": false
        },
        "o": {
          "type": "keyword",
          "doc_values": false,
          "index": false
        },
        "p": {
          "type": "keyword",
          "doc_values": false,
          "index": false
        },
        "q": {
          "type": "keyword",
          "doc_values": false,
          "index": false
        },
        "r": {
          "type": "keyword",
          "doc_values": false,
          "index": false
        },
        "s": {
          "type": "keyword",
          "doc_values": false,
          "index": false
        },
        "t": {
          "type": "keyword",
          "doc_values": false,
          "index": false
        },
        "u": {
          "type": "keyword",
          "doc_values": false,
          "index": false
        },
        "v": {
          "type": "keyword",
          "doc_values": false,
          "index": false
        },
        "w": {
          "type": "keyword",
          "doc_values": false,
          "index": false
        },
        "x": {
          "type": "keyword",
          "doc_values": false,
          "index": false
        },
        "y": {
          "type": "keyword",
          "doc_values": false,
          "index": false
        },
        "z": {
          "type": "keyword",
          "doc_values": false,
          "index": false
        }
      }
    }
  }
}'
echo ""
