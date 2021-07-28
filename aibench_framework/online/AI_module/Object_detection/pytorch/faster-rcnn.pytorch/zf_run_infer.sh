CUDA_VISIBLE_DEVICES=1 python test_net.py --dataset pascal_voc --net res101 \
	--load_dir models \
	--cuda \
	2>&1 | tee log_test
