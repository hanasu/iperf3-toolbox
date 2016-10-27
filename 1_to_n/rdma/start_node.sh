#!/bin/bash

ib_write_bw -d mlx5_0 -i 1 -s 8 --report_gbits -D 20 -F -I 0 -t 1028 -Q 1 100.0.0.1 > `hostname`_to_blade1.log
