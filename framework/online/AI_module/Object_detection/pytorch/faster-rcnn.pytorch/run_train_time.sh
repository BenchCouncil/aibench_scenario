# Trainning Configurations
GPU_ID=0
BATCH_SIZE=5
WORKER_NUMBER=10
LEARNING_RATE=0.001
DECAY_STEP=5


# CPU mode
#python trainval_net.py \
#    --dataset coco --net res101 \
#    --bs $BATCH_SIZE --nw $WORKER_NUMBER \
#    --lr $LEARNING_RATE --lr_decay_step $DECAY_STEP

# GPU mode
CUDA_VISIBLE_DEVICES=$GPU_ID python trainval_net.py \
                    --dataset pascal_voc --net res101 \
                    --bs $BATCH_SIZE --nw $WORKER_NUMBER \
                    --lr $LEARNING_RATE --lr_decay_step $DECAY_STEP \
                    --disp_interval 1 \
                    --epochs 1 \
                    --cuda
