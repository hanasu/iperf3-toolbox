#!/bin/bash

#find out which blade number script is running on
blade=`hostname | cut -c 6-7`
#default transfer size of ib_write_bw if no argument passed
size=8
#how long the test will run for if no argument passed
duration=20

#parse command line arguments
while getopts s:t: opt; do
  case $opt in
    s) size=$optarg
      ;;
    t) duration=$optarg
      ;;
  esac
done

ib_write_bw -d mlx5_0 -i 1 -s $size --report_gbits -D $duration -F -I 0 -t 1028 -Q 1 -p $((18513 + $blade)) 100.0.0.1 > `hostname`_to_blade1.log
