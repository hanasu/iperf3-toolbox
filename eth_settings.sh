#!/bin/bash

#find out what device is assigned to the 100.0.0.X address thus is 100G
eth_device=`ifconfig | sed -n '/addr:100.0/{g;H;p};H;x' | awk '{print $1}'`
mtu=1500

#handle parsing the -m argument for MTU setting
while getopts m: opt; do
  case $opt in
    m) mtu=$OPTARG
      ;;
  esac
done

#set large-receive-offload on, turn off pause frames, increase ring NIC buffers
ethtool -K $eth_device lro on
ethtool -A $eth_device tx off rx off
ethtool -G $eth_device tx 8192 rx 8192

#increase txqueuelen for 100G
ifconfig $eth_device txqueuelen 20000

#set MTU according to argument, iperf3 does not allow sending specific size
#frames for TCP transfers so this can be accomplished with altered MTU instead
ifconfig $eth_device mtu $mtu

#stop the irqbalance service because interrupts are happening across many cores
service irqbalance stop

#disable the firewall to prevent connection issues
/sbin/rcSuSEfirewall2 stop

#check the current status of all the settings just changed to verify
ethtool -k $eth_device | grep large-receive-offload
ethtool -a $eth_device
ethtool -g $eth_device
ifconfig $eth_device | grep txqueuelen
ifconfig $eth_device | grep MTU
ps aux | grep irqbalance
