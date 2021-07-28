batch_size=100
data_dir=../../dataset/imagenet2012/
CUDA_VISIBLE_DEVICES=0 python val.py  -e --resume best_model/checkpoint.pth -a resnet50 -b ${batch_size} ${data_dir}


