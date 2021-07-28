rm samples/*.pth
python main.py --dataset lsun \
  --dataroot /root/DC_AIBench_Component/dataset/lsun \
  --cuda \
  --niter 1
