#!/bin/bash

#clean up any residual processes
killall ib_write_bw

#since there is only one connection to each node from the server only
#one instance of the ib_write_bw process is needed
ib_write_bw -d mlx5_0
