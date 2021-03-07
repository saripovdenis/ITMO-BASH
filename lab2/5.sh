#!/bin/bash
rm -R 5finally.txt
touch 5finally.txt

copyOfPreviousFile=$(cat 4sorted.txt)
arrayOfDifferentStrings=$(cat 4sorted.txt | awk '{print $3}' | uniq)

for string in $arrayOfDifferentStrings
do
  currentPPID=$(echo $string | tr -d "[a-z][A-Z]_")
  currentString=$(cat 4sorted.txt | grep -s "$string" | tr -d ':')
  strings=$(echo $currentString | tr ' ' '\n')
  quantity=$(cat 4sorted.txt | grep -c "$string")
  currentAVGART=0

  temp=$(echo "$strings" | grep "Average_Running_Time=" | tr -d "[a-z][A-Z]_=")
  for numbers in $temp
  do
    currentAVGART=$(echo "scale=9; $currentAVGART+$numbers" | bc | awk '{printf "%f", $0}')
  done

  currentAVGART=$(echo "scale=9; $currentAVGART/$quantity" | bc | awk '{printf "%f", $0}')
  echo "$currentString" >> 5finally.txt
  echo "Average_Sleeping_Children_of_ParentID$currentPPID is $currentAVGART" >> 5finally.txt
done
