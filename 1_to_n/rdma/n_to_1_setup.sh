#!/bin/bash

#find which blade the script is running on
blade=`hostname | cut -c 6-7`
#clean up any residual processes
killall ib_write_bw

#since there is only one connection to each node from the server only
#one instance of the ib_write_bw process is needed
ib_write_bw -d mlx5_0 -p $((18528 + blade)) #> blade$blade_to_blade1.log

#scp blade$blade_to_blade1.log root@blade1:/root/Desktop/iperf3-toolbox/1_to_n/rdma
