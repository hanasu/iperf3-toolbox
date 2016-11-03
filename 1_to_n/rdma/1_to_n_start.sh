#!/bin/bash

#find out which blade number script is running on
#blade=`hostname | cut -c 6-7`
#default transfer size of ib_write_bw if no argument passed
size=8
#how long the test will run in seconds if no argument passed
duration=20
#counter for the target blade number
i=2

#parse command line arguments
while getopts s:t: opt;do
  case $opt in
    s) size=$OPTARG
      ;;
    t) duration=$OPTARG
      ;;
  esac
done

#remove any residual processes from previous testing
killall ib_write_bw

ib_write_bw -d mlx5_0 -i 1 -s $size --report_gbits -D $duration -F -I 0 -t 1028 -Q 1 -p $((18528 + $i)) -b 100.0.0.$i > blade1_to_`hostname`.log
i=$((i + 1))
ib_write_bw -d mlx5_0 -i 1 -s $size --report_gbits -D $duration -F -I 0 -t 1028 -Q 1 -p $((18528 + $i)) -b 100.0.0.$i > blade1_to_`hostname`.log
i=$((i + 1))
ib_write_bw -d mlx5_0 -i 1 -s $size --report_gbits -D $duration -F -I 0 -t 1028 -Q 1 -p $((18528 + $i)) -b 100.0.0.$i > blade1_to_`hostname`.log
i=$((i + 1))
ib_write_bw -d mlx5_0 -i 1 -s $size --report_gbits -D $duration -F -I 0 -t 1028 -Q 1 -p $((18528 + $i)) -b 100.0.0.$i > blade1_to_`hostname`.log
i=$((i + 1))
ib_write_bw -d mlx5_0 -i 1 -s $size --report_gbits -D $duration -F -I 0 -t 1028 -Q 1 -p $((18528 + $i)) -b 100.0.0.$i > blade1_to_`hostname`.log
i=$((i + 1))
ib_write_bw -d mlx5_0 -i 1 -s $size --report_gbits -D $duration -F -I 0 -t 1028 -Q 1 -p $((18528 + $i)) -b 100.0.0.$i > blade1_to_`hostname`.log
i=$((i + 1))
ib_write_bw -d mlx5_0 -i 1 -s $size --report_gbits -D $duration -F -I 0 -t 1028 -Q 1 -p $((18528 + $i)) -b 100.0.0.$i > blade1_to_`hostname`.log
i=$((i + 1))
ib_write_bw -d mlx5_0 -i 1 -s $size --report_gbits -D $duration -F -I 0 -t 1028 -Q 1 -p $((18528 + $i)) -b 100.0.0.$i > blade1_to_`hostname`.log
i=$((i + 1))
ib_write_bw -d mlx5_0 -i 1 -s $size --report_gbits -D $duration -F -I 0 -t 1028 -Q 1 -p $((18528 + $i)) -b 100.0.0.$i > blade1_to_`hostname`.log
i=$((i + 1))
ib_write_bw -d mlx5_0 -i 1 -s $size --report_gbits -D $duration -F -I 0 -t 1028 -Q 1 -p $((18528 + $i)) -b 100.0.0.$i > blade1_to_`hostname`.log
i=$((i + 1))
ib_write_bw -d mlx5_0 -i 1 -s $size --report_gbits -D $duration -F -I 0 -t 1028 -Q 1 -p $((18528 + $i)) -b 100.0.0.$i > blade1_to_`hostname`.log
i=$((i + 1))
ib_write_bw -d mlx5_0 -i 1 -s $size --report_gbits -D $duration -F -I 0 -t 1028 -Q 1 -p $((18528 + $i)) -b 100.0.0.$i > blade1_to_`hostname`.log
i=$((i + 1))
ib_write_bw -d mlx5_0 -i 1 -s $size --report_gbits -D $duration -F -I 0 -t 1028 -Q 1 -p $((18528 + $i)) -b 100.0.0.$i > blade1_to_`hostname`.log
i=$((i + 1))
ib_write_bw -d mlx5_0 -i 1 -s $size --report_gbits -D $duration -F -I 0 -t 1028 -Q 1 -p $((18528 + $i)) -b 100.0.0.$i > blade1_to_`hostname`.log
i=$((i + 1))
ib_write_bw -d mlx5_0 -i 1 -s $size --report_gbits -D $duration -F -I 0 -t 1028 -Q 1 -p $((18528 + $i)) -b 100.0.0.$i > blade1_to_`hostname`.log