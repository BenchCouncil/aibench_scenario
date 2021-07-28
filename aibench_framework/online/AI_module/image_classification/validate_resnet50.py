import json
import numpy as np
from keras.preprocessing import image
from keras.applications.resnet50 import preprocess_input
from keras.applications.resnet50 import decode_predictions
import requests
import random
import os

def imagepath_to_tfserving_payload(img_path):
    img = image.img_to_array(image.load_img(img_path, target_size=(224, 224)))
    # img = image.img_to_array(image.load_img(img_path))
    X = np.expand_dims(img, axis=0).astype('float32')
    X = preprocess_input(X)
    payload = dict(instances=X.tolist())
    payload = json.dumps(payload)
    return payload

def tfserving_predict(image_payload, url=None):
    if url is None:
        url = 'http://172.18.13.25:8503/v1/models/resnet:predict'
    r = requests.post(url, data=image_payload)
    pred_json = json.loads(r.content.decode('utf-8'))
    predictions = decode_predictions(np.asarray(pred_json['predictions']), top=1)[0]
    return predictions

if __name__ == '__main__':
    count = 0
    correct = 0
    BASE_DIR = '/home/gwl/cxlan/hpca_one/pytorch/dataset/imagenet2012/validation/'
    for r, d, f in os.walk(BASE_DIR):
        r = r.split('/')[-1] 
        for img in f:
            img_path = '/home/gwl/cxlan/hpca_one/pytorch/dataset/imagenet2012/validation/{}/{}'.format(r, img)
            predict = tfserving_predict(imagepath_to_tfserving_payload(img_path))
            if predict[0][0] == r:
                correct += 1
            count += 1
            print("total: {}, correct: {}".format(count, correct))
    # for i in range(1, 100):
        # img_path = '/home/gwl/cxlan/hpca_one/pytorch/dataset/imagenet2012/validation/{}/{}'.format(dir_name, img_name)
        # img_path = img_path.format(random.randint(1, 14))
        # predict = tfserving_predict(imagepath_to_tfserving_payload('/home/gwl/cxlan/hpca_one/pytorch/dataset/imagenet2012/validation/n10148035/ILSVRC2012_val_00030424.JPEG'))
        # predict = tfserving_predict(imagepath_to_tfserving_payload(img_path))
        # print(predict)
