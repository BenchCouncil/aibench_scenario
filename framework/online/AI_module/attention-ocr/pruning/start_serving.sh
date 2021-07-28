#/bin/bash
#docker run -t --runtime=nvidia --rm --net=host -v $(pwd)/exported-model:/models/ocr -e MODEL_NAME=ocr nmtwizard/opennmt-tf
docker run -t --gpus all --rm --net=host -v $(pwd)/exported-model:/models/ocr -e MODEL_NAME=ocr tensorflow/serving 
# docker run -t --runtime=nvidia --rm --net=host -v $(pwd)/exported-model:/models/ocr -e MODEL_NAME=ocr tensorflow/serving:latest-devel-gpu \
# tensorflow_model_server --port=8500 --rest_api_port=8501 --model_name=ocr --model_base_path=/models/ocr
#docker run --net=host -v $PWD:/root/models nmtwizard/opennmt-tf --model ende serve --host 0.0.0.0 --port 4000

