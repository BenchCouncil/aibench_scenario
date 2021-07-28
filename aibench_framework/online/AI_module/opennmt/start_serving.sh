#docker run --runtime=nvidia --net=host  -v $PWD:/root/models nmtwizard/opennmt-tf --model ende serve --host 0.0.0.0 --port 4000
docker run --net=host  -v $PWD:/root/models nmtwizard/opennmt-tf --model ende serve --host 0.0.0.0 --port 4000
