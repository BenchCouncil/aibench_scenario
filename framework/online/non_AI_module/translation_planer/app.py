from flask import Flask
from flask import request

import base64
import requests
import os
import re
import time

app = Flask(__name__)

@app.route('/audio', methods=['post'])
def audio_to_ge():
       audio_start = time.time()
       input_audio = request.files['audio']
       #print(input_audio)
       audio_pre = time.time()
       preprocess_audio_time = audio_pre - audio_start
       print("preprocessing audio:",preprocess_audio_time)
       files={
           'audio':input_audio
       }
       audio_res = requests.post('http://10.118.0.28:5000/model/predict',headers={'Connection':'close'},files=files)   
       print(audio_res.json())
       audio_rec = time.time()
       rec_audio_time = audio_rec - audio_pre
       print("recongize audio:",rec_audio_time)
       text = audio_res.json()['prediction']
       print(text) 
       data_text = "{\"src\":[{\"text\":\"%s\"}]}"%text       
       translation = requests.post('http://10.118.0.30:4000/translate',headers={'Connection':'close'},data = data_text)       
       print(translation.json())
       audio_text = time.time()
       translate_audio_time = audio_text - audio_rec
       print("translate audio:",translate_audio_time)
       total_audio_time = audio_text - audio_start
       print("total audio:",total_audio_time)
       return translation.json()

@app.route('/image', methods=['post'])
def image_to_ge():
       image_start = time.time()
       input_image = request.files['image']
       #print(input_image)
       image_string = base64.b64encode(input_image.read())
       image_string = str(image_string).split("\'")[1]
       image_pre = time.time()
       preprocess_image_time = image_pre - image_start
       print("preprocessing image:",preprocess_image_time)
       headers = {
           'cache-control': 'no-cache',
           'content-type': 'application/json',
           'Connection':'close'
       }
       data = "{\"signature_name\": \"serving_default\",\"inputs\": {\"input\": { \"b64\":\"%s\"}}}"%image_string
       ocr_res = requests.post('http://10.118.0.27:8501/v1/models/ocr:predict',headers=headers,data=data)
       print(ocr_res.json())
       image_ocr = time.time()
       ocr_image_time = image_ocr - image_pre 
       print("ocr image:",ocr_image_time)
       text = ocr_res.json()['outputs']['output'] 
       data_text = "{\"src\":[{\"text\":\"%s\"}]}"%text       
       translation = requests.post('http://10.118.0.30:4000/translate',headers={'Connection':'close'},data = data_text)       
       print(translation.json())
       image_text = time.time()
       translate_image_time = image_text - image_ocr
       print("translate image:",translate_image_time)
       total_image_time = image_text - image_start
       print("total image:",total_image_time)
       #'{"src":[{"text": "Hello world!"}]}'          
       return translation.json()

@app.route('/text', methods=['post'])
def text_to_ge():
       text_start = time.time()
       text = request.get_json()
       text = str(text).replace("\'","\"")
       text_pre = time.time()
       pre_text_time = text_pre - text_start
       print("preprocess text:",pre_text_time)
       data = "{\"src\":[%s]}"%text       
       translation = requests.post('http://10.118.0.30:4000/translate',headers={'Connection':'close'},data = data)       
       print(translation.json())
       text_translation = time.time()
       translate_text_time = text_translation - text_pre
       print("translate text:",translate_text_time)
       total_text_time = text_translation - text_start
       print("total text:",total_text_time)
       return translation.json()

@app.route('/')
def hello_world():
    return 'Hello, World!'
