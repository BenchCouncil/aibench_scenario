from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

import time
# import fasttext
import requests
import logging
from logging.handlers import WatchedFileHandler
from flask import Flask
from flask import Response
from flask import request
# from neo4j import GraphDatabase
import neo4j

import sys
print(sys.path)

import tensorflow as tf
from nltk.tokenize import word_tokenize

from grpc.beta import implementations
from tensorflow_serving.apis import classification_pb2
from tensorflow_serving.apis import prediction_service_pb2

import json
import numpy as np
from keras.preprocessing import image
from keras.applications.resnet50 import preprocess_input
from keras.applications.resnet50 import decode_predictions

import random

app = Flask(__name__)
# category_classifier = fasttext.load_model('category_classifier.ftz')

valid_list = list()
with open('valid.txt') as f:
    for line in f:
        valid_list.append(line)

# logging.basicConfig(filename='./qp.log', level=logging.INFO)

def BuildTextExample(text, ngrams=None, label=None):
    record = tf.train.Example()
    text = [tf.compat.as_bytes(x) for x in text]
    record.features.feature["text"].bytes_list.value.extend(text)
    if label is not None:
        label = tf.compat.as_bytes(label)
        record.features.feature["label"].bytes_list.value.append(label)
    if ngrams is not None:
        ngrams = [tf.compat.as_bytes(x) for x in ngrams]
        record.features.feature["ngrams"].bytes_list.value.extend(ngrams)
    return record

def Request(text, ngrams):
    text = word_tokenize(text.lower())
    ngrams = None
    if ngrams is not None:
        ngrams_list = text_utils.ParseNgramsOpts(ngrams)
        ngrams = text_utils.GenerateNgrams(text, ngrams_list)
    example = BuildTextExample(text, ngrams=ngrams)
    # print(example)
    request = classification_pb2.ClassificationRequest()
    request.model_spec.name = 'fasttext'
    request.model_spec.signature_name = 'proba'
    request.input.example_list.examples.extend([example])
    return request

@app.route("/")
def hello():
    return "Hello World from Flask in a uWSGI Nginx Docker container with \
     Python 3.7 (from the example template)"


@app.route("/query", methods=['POST'])
def analyse_query():
    timestamps = list()
    timestamps.append(int(time.perf_counter() * 1e9))

    data = request.get_json()
    qid = int(data['qid'])
    uid = data['uid']
    query = data['query']

    timestamps.append(int(time.perf_counter() * 1e9))
    connector = neo4j.Connector('http://neo4j:7474')
    response = connector.run("MATCH (user:User {{uid: '{}'}})  RETURN user".format(uid))
    user = response[0]['user']
    # driver = GraphDatabase.driver("bolt://172.18.11.1:7687")
    # with driver.session() as session:
    #     result = session.run("MATCH (user:User {uid: $uid}) RETURN user", uid=uid)
    # driver.close()
    # record = result.single()
    # user = record['user']
    # user = {'sex': 0, 'age': 15, 'power': 5}

    timestamps.append(int(time.perf_counter() * 1e9))

    channel = implementations.insecure_channel('fasttext', 8502)
    stub = prediction_service_pb2.beta_create_PredictionService_stub(channel)
    text_request = Request(random.choice(valid_list), '2,3,4')
    
    timestamps.append(int(time.perf_counter() * 1e9))
    result = stub.Classify(text_request, 10.0)
    
    # timestamps.append(int(time.perf_counter() * 1e9))
    # category = int(category_classifier.predict(query)[0][0][9:])

    timestamps.append(int(time.perf_counter() * 1e9))
    payload = {
        "instances": [
            {
                "category": [1],
                "sex": [user['sex']],
                "age": [user['age']],
                "power": [user['power']]
            }
        ]
    }
    # session = requests.session()
    # session.keep_alive = False
    # logging.info(payload)
    ranking_weights = requests.post('http://ranking:8501/v1/models/ranking:predict', json=payload)
    # ranking_weights = requests.post('http://localhost:8501/v1/models/ranking_weights_model:predict', json=payload)
    # query_feature = [[category], [2], [0], [3]]
    # ranking_weights = ranking_weights_model.predict([[2345], [0], [28], [5]])

    timestamps.append(int(time.perf_counter() * 1e9))
    logging.info(str(qid) + ":" + ",".join(str(timestamp) for timestamp in timestamps))
    # logging.debug(str(qid) + ":" + ",".join(str(timestamp) for timestamp in timestamps))
    # print(ranking_weights.content)
    # return Response('{\n    "predictions": [[1.0, 1.0, 1.0]\n    ]\n}', mimetype="application/json")
    return Response(ranking_weights.content, mimetype="application/json")

@app.route("/img", methods=['POST'])
def img_query():
    timestamps = list()
    timestamps.append(int(time.perf_counter() * 1e9))
 
    img = request.files['image']
    qid = int(0)
    uid = '1'
    query = '177860 13976 14619 25247 13578 177860 13976 14619'

    timestamps.append(int(time.perf_counter() * 1e9))
    connector = neo4j.Connector('http://neo4j:7474')
    response = connector.run("MATCH (user:User {{uid: '{}'}})  RETURN user".format(uid))
    user = response[0]['user']
    # driver = GraphDatabase.driver("bolt://172.18.11.1:7687")
    # with driver.session() as session:
    #     result = session.run("MATCH (user:User {uid: $uid}) RETURN user", uid=uid)
    # driver.close()
    # record = result.single()
    # user = record['user']
    # user = {'sex': 0, 'age': 15, 'power': 5}

    timestamps.append(int(time.perf_counter() * 1e9))

    # channel = implementations.insecure_channel('172.18.13.25', 8500)
    # stub = prediction_service_pb2.beta_create_PredictionService_stub(channel)
    # text_request = Request(random.choice(valid_list), '2,3,4')
    # result = stub.Classify(text_request, 10.0)
    
    # timestamps.append(int(time.perf_counter() * 1e9))
    # category = int(category_classifier.predict(query)[0][0][9:])
    image_payload = imagepath_to_tfserving_payload(img)
    timestamps.append(int(time.perf_counter() * 1e9))

    pred_json = tfserving_predict(image_payload)

    predictions = decode_predictions(np.asarray(pred_json['predictions']), top=3)[0]
    # print(image_class)
    timestamps.append(int(time.perf_counter() * 1e9))
    payload = {
        "instances": [
            {
                "category": [1],
                "sex": [user['sex']],
                "age": [user['age']],
                "power": [user['power']]
            }
        ]
    }
    # session = requests.session()
    # session.keep_alive = False
    ranking_weights = requests.post('http://ranking:8501/v1/models/ranking:predict', json=payload)
    # ranking_weights = requests.post('http://localhost:8501/v1/models/ranking_weights_model:predict', json=payload)
    # query_feature = [[category], [2], [0], [3]]
    # ranking_weights = ranking_weights_model.predict([[2345], [0], [28], [5]])

    timestamps.append(int(time.perf_counter() * 1e9))
    logging.info(str(qid) + ":" + ",".join(str(timestamp) for timestamp in timestamps))
    # logging.debug(str(qid) + ":" + ",".join(str(timestamp) for timestamp in timestamps))
    # print(ranking_weights.content)
    # return Response('{\n    "predictions": [[1.0, 1.0, 1.0]\n    ]\n}', mimetype="application/json")
    return Response(ranking_weights.content, mimetype="application/json")

def imagepath_to_tfserving_payload(img_path):
    # img = image.img_to_array(image.load_img(img_path, target_size=(224, 224)))
    image_process_time = []
    image_process_time.append(int(time.perf_counter() * 1e9))
    # img = image.img_to_array(image.load_img(img_path, target_size=(8, 8)))
    img = image.img_to_array(image.load_img(img_path, target_size=(8, 8)))
    image_process_time.append(int(time.perf_counter() * 1e9))
    X = np.expand_dims(img, axis=0).astype('float32')
    image_process_time.append(int(time.perf_counter() * 1e9))
    X = preprocess_input(X)
    image_process_time.append(int(time.perf_counter() * 1e9))
    payload = dict(instances=X.tolist())
    image_process_time.append(int(time.perf_counter() * 1e9))
    payload = json.dumps(payload)
    image_process_time.append(int(time.perf_counter() * 1e9))
    # logging.info("image process: " + ",".join(str(timestamp) for timestamp in image_process_time))
    return payload

def tfserving_predict(image_payload, url=None):
    if url is None:
        # url = 'http://172.18.11.85:8505/v1/models/resnet:predict'
        url = 'http://resnet:8505/v1/models/resnet:predict'
    r = requests.post(url, data=image_payload)
    pred_json = json.loads(r.content.decode('utf-8'))
    return pred_json

# if __name__ != "__main__":
#     gunicorn_logger = logging.getLogger("gunicorn.error")
#     app.logger.handlers = gunicorn_logger.handlers
#     app.logger.setLevel(gunicorn_logger.level)
#     app.logger.debug("this is a DEBUG message")

if __name__ == "__main__":
    # logging.basicConfig(filename='/home/gwl/tangfei/query-planer/qp.log', level=logging.INFO)
    logging.basicConfig(handlers=[WatchedFileHandler("./qp.log")], level=logging.INFO)
    # Only for debugging while developing
    app.run(host='0.0.0.0', debug=False, port=8080)
