#!/bin/bash
rm -R 6.txt
touch 6.txt

for process in $(ps ax -o pid)
do
  Pid=$(grep -s '^Pid:' /proc/$process/status | awk '{print $2}')
  mem=$(grep -s '^VmRSS:' /proc/$process/status | awk '{print $2}')

  if [[ -z $mem ]] #if empty
  then
    continue
  else
    echo "$Pid : $mem kB" >> 6.txt
  fi
done

echo "Info from /status:"
cat 6.txt | sort -rnk3 | head -n1 | awk '{print $1" "$3}'

echo "Info from \$ top:"
top -bn1 > 6.top
less 6.top | grep -E -s "[[:digit:]]+  [[:digit:]]+" | awk '{print $1" "$6}'| sort -rnk2 | head -n1
