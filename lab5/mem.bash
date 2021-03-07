#!/bin/bash

> report.log

count=0
array=()
while true; do
	let "count=$count + 1"
	array+=(1 2 3 4 5 6 7 8 9 10)

	if (( $count % 100000 == 0 )); then
		echo "${#array[*]}" >> report.log
	fi
done

