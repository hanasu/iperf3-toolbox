#!/bin/bash

#default transfer size of ib_write_bw if no argument passed
size=8
#how long the test will run in seconds if no argument passed
duration=20
#number of queue pairs to use if no argument passed
qps=25

#parse command line arguments
while getopts s:t:q: opt;do
  case $opt in
    s) size=$OPTARG
      ;;
    t) duration=$OPTARG
      ;;
    q)
       qps=$OPTARG
      ;;
  esac
done

for i in `seq 2 16`; do
  ib_write_bw -d mlx5_0 -i 1 -s $size --report_gbits -D $duration -F -I 0 -t 1028 -Q $qps -p $((18528 + $i)) -b 100.0.0.$i > blade1_to_blade${i}.log &
done
