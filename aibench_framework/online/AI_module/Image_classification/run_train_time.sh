batch_size=100
data_dir=../../dataset/imagenet2012/
CUDA_VISIBLE_DEVICES=0 python3 main.py  -a resnet50 -b ${batch_size} ${data_dir}

