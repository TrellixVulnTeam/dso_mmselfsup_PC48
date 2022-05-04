#PBS -l select=1:ncpus=20:ngpus=4
#PBS -l walltime=100:00:00
#PBS -N MALMH
#PBS -j oe
#PBS -o log/malmh.log
#PBS -q gold
#PBS -v CONTAINER_IMAGE=nvcr.io/nvidia/pytorch:20.06-py3

echo "CONTAINER_IMAGE=nvcr.io/nvidia/pytorch:20.06-py3"


cd "$PBS_O_WORKDIR" || exit $?
echo ${PBS_O_WORKDIR}

USER=thibaongoc_nguyen # Replace with your own HPC account name

nvidia-smi

export PYTHONPATH=/home/users/$USER/sutddev/mmselfsup/:$PYTHONPATH

cmd="bash tools/dist_train_kd_cluster.sh ${USER} \
configs/selfsup/simsiam_kd_test/simsiamkd_malmh_resnet18_4xb64-coslr-200e_in30p.py 4 \
--teacher_path \
../../scratch/dso/openss/work_dirs/selfsup/simsiam/simsiam_resnet50_4xb64-coslr-200e_in30p/epoch_200.pth &>> log/malmh.log"
echo ${cmd}
eval ${cmd}

#cmd="bash tools/dist_train_kd_cluster.sh ${USER} \
#configs/selfsup/simsiam_kd/simsiamkd_resnet18_wproject_4xb64-coslr-200e_in30p.py 4 \
#--teacher_path ../../scratch/dso/openss/work_dirs/selfsup/simsiam/simsiam_resnet50_4xb64-coslr-200e_in30p/epoch_200.pth"
#echo ${cmd}
##eval ${cmd}
