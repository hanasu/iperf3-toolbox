#!/bin/bash

read -p "Enter a name for this test: " testname
logdir=/root/Desktop/iperf3-toolbox/logs/rdma/$testname
total=0

if [ ! -d "/root/Desktop/iperf3-toolbox/logs/" ]; then
  mkdir /root/Desktop/iperf3-toolbox/logs/
fi 

if [ ! -d "/root/Desktop/iperf3-toolbox/logs/rdma" ]; then
  mkdir /root/Desktop/iperf3-toolbox/logs/rdma
fi

mkdir $logdir

echo "1-to-N results" >> summary.log
echo "------------------------" >> summary.log

for log in blade1_to_*.log; do
  bandwidth=`sed -n '/BW average/{n;p;}' $log | sed 's/\s\s*/ /g' | cut -d ' ' -f 5`
  #echo "$log: $bandwidth"
  total=$( echo "$total + $bandwidth" | bc )
  if [[ $log != "summary.log" ]]; then
    echo $log ":" $bandwidth>> summary.log
  fi
done

echo "Total bandwidth 1-to-N: $total Gb/s" >> summary.log

total=0
echo "" >> summary.log
echo "N-to-1 results" >> summary.log
echo "------------------------" >> summary.log

for log in *_to_blade1.log; do
  bandwidth=`sed -n '/BW average/{n;p;}' $log | sed 's/\s\s*/ /g' | cut -d ' ' -f 5`
  #echo "$log: $bandwidth"
  total=$( echo "$total + $bandwidth" | bc )
  if [[ $log != "summary.log" ]]; then
    echo $log ":" $bandwidth  >> summary.log
  fi
done

echo "Total bandwidth N-to-1: $total Gb/s" >> summary.log

cat summary.log
mv *.log $logdir
