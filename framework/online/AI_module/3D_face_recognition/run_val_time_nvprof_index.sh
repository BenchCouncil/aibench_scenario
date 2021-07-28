for line in $(cat metrics_ispass)
do
	echo $line
	/usr/local/cuda/bin/nvprof --metrics $line --log-file ./result/$line --system-profiling on --csv -t 600 -f --continuous-sampling-interval 1 \
python evaluation.py \
    --test_dataset_csv test.csv \
    --eval_dataset_csv eval.csv \
    --pretrained_model_path logs/04-12.05-49/resnet50-3d-model.pkl \
    --num_of_workers 8 \
   2>&1 | tee log_infer_nvprof_$line
	 done
