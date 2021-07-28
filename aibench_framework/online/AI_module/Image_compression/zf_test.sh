#!/bin/bash

for i in {10..10..1}; do
  echo Encoding test/images/kodim$i.png
  mkdir -p test/codes
CUDA_VISIBLE_DEVICES=1  python zf_encoder.py --model checkpoint/encoder_epoch_00000004.pth --input test/images/kodim$i.png --cuda --output test/codes/kodim$i --iterations 10

  #echo Decoding test/codes/kodim$i.npz
  #mkdir -p test/decoded/kodim$i
  #python decoder.py --model checkpoint/decoder_epoch_00000004.pth --input test/codes/kodim$i.npz --cuda --output test/decoded/kodim$i
done

