#!/bin/bash

num=1
LSTM=test/cxlan_lstm_ssim_${num}.csv
j=200
echo -n $j',' >> $LSTM
 for i in {01..24..1}; do
  echo epoch:$j images:$i
  echo Encoding test/images/kodim$i.png
  mkdir -p test/codes${num}
  CUDA_VISIBLE_DEVICES=${num} python encoder.py --model best_model/encoder_epoch_00000${j}.pth --input test/images/kodim$i.png --cuda --output test/codes${num}/kodim$i --iterations 2

  echo Decoding test/codes/kodim$i.npz
  mkdir -p test/decoded${num}/kodim$i
  CUDA_VISIBLE_DEVICES=${num} python decoder.py --model best_model/decoder_epoch_00000${j}.pth --input test/codes${num}/kodim$i.npz --cuda --output test/decoded${num}/kodim$i
  echo `python metric.py -m ssim -o test/images/kodim$i.png -c test/decoded${num}/kodim$i/01.png`', '
  echo -n `python metric.py -m ssim -o test/images/kodim$i.png -c test/decoded${num}/kodim$i/01.png`', ' >> $LSTM
 done
echo "" >> $LSTM
