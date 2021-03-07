#!/bin/bash
touch temp.txt
ps -u parallels | awk '{if ($1 ~ /^[0-9]/) print $1":"$4}' > temp.txt
cat temp.txt | wc -l > processes.txt
cat temp.txt | awk '{print$0}' >> processes.txt
rm -R temp.txt
