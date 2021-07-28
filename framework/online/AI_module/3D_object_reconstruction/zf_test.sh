env=AE_AtlasNet
nb_primitives=25
model=./best_model/network.pth
CUDA_VISIBLE_DEVICES=1 python ./training/zf_train_AE_AtlasNet.py --env $env --nb_primitives $nb_primitives --model $model

