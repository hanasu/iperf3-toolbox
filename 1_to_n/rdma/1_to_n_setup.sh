#!/bin/bash

#default port is 18515 so let's start there
port=18515

#there are 15 remote nodes that will be connecting to this 1 server node
#taskset assigns them to separate cpu cores for best performance
#each loop will increment the process' port by 1
for i in `seq 0 14`;
do
  taskset -c $i ib_write_bw -d mlx5_0 -p $port > blade$((i + 2))_to_blade1.log &
  port=$(( $port + 1 ))
done
