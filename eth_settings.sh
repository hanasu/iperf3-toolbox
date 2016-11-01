#!/bin/bash

#find out what device is assigned to the 100.0.0.X address thus is 100G
eth_device=`ifconfig | sed -n '/addr:100.0/{g;H;p};H;x' | awk '{print $1}'`
#default MTU if no argument passed on command line
mtu=1500
#number of cores available on system
cores=`cat /sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_cur_freq | wc -l`

#handle parsing the -m argument for MTU setting
while getopts m: opt; do
  case $opt in
    m) mtu=$OPTARG
      ;;
  esac
done

echo "OUTPUT"
echo "-----------------------"
echo ""

#set large-receive-offload on, turn off pause frames, increase ring NIC buffers
ethtool -K $eth_device lro on
ethtool -K $eth_device tx-nocache-copy off
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

#for each core on the system (zero-indexed) set the governor to performance
#to prevent CPU throttling for energy savings
for i in `seq 0 $(( cores - 1 ))`; do
  echo performance > /sys/devices/system/cpu/cpu$i/cpufreq/scaling_governor;
done

#Mellanox tool that automatically handles affinity settings for NICs
mlnx_affinity start

echo ""
echo "STATUS"
echo "-----------------------"

#check the current status of all the settings just changed to verify
echo "Large Receive Offload:`ethtool -k $eth_device | grep large-receive-offload | cut -d ':' -f 2`"
echo "TX No-cache Copy: `ethtool -k eth4 | grep tx-nocache | cut -d ' ' -f 2`"
echo ""
ethtool -a $eth_device
ethtool -g $eth_device
echo "TX queue length: `ifconfig $eth_device | grep txqueuelen | cut -d ':' -f 3`"
echo "MTU: `ifconfig $eth_device | grep MTU | cut -d ':' -f 2 | cut -c 1-4`"
if pgrep "irqbalance" > /dev/null
then
  echo "IRQbalance: Running"
else
  echo "IRQbalance: Stopped"
fi
