#!/bin/bash
CUDA_VISIBLE_DEVICES=0 python attention-is-all-you-need-pytorch/train.py -data ../../dataset/WMT-English-German/multi30k.atok.low.pt -save_model trained -save_mode best -proj_share_weight -label_smoothing -batch_size 256 -epoch 200
