#!/bin/bash
rm 7.finally
touch 7.temp
touch 7.stemp
touch 7.finally

for string in $(ps -axo pid)
do
  if [[ "$string" == "PID" ]]
  then
    continue
  fi

  Pid=$(grep -s "^Pid" /proc/$string/status | awk '{print $2}')
  Rchar=$(grep -s -i "rchar" /proc/$string/io | awk '{print $2}')
  if [[ -z "$Rchar" ]]
  then
    continue
  fi
  echo "$Pid $Rchar" >> 7.temp
done 

sleep 5s

for string in $(ps -axo pid)
do
  if [[ "$string" == "PID" ]]
  then
    continue
  fi

  Pid=$(grep -s "^Pid" /proc/$string/status | awk '{print $2}')
  Rchar=$(grep -s -i "rchar" /proc/$string/io | awk '{print $2}')
  if [[ -z "$Rchar" ]]
  then
    continue
  fi
  echo "$Pid $Rchar" >> 7.stemp
done

for string in $(cat 7.temp);
do
  Pid=$(echo "$string" | awk '{print $1}')
  rchar=$(echo "$string" | awk '{print $2}')
  secondString=$(grep -s "^$Pid " /home/parallels/lab2/7.stemp)
  if [[ -z "$secondString" ]]
  then
    secondrchar=$(echo "$secondString" | awk '{print $2}')
    if [[ "$secondrchar" -eq "$rchar" ]]
    then
      answer=0
    else
      answer=$(echo "scale=9; $secondrchar-$rchar" | bc | awk '{printf "%f", $0}')
    fi

    echo "$Pid $answer" >> 7.finally
  else
    continue
  fi
done

cat 7.finally | sort -nk2 | tail -n3
