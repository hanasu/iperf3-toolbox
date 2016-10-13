#!/bin/bash

eth_device=`ifconfig | sed -n '/addr:100.0/{g;H;p};H;x' | awk '{print $1}'`

ethtool -K $eth_device lro on
ethtool -A $eth_device tx off rx off
ethtool -G $eth_device tx 8192 rx 8192

ethtool -k $eth_device | grep large-receive-offload
ethtool -a $eth_device
ethtool -g $eth_device
