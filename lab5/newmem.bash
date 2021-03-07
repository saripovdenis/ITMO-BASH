#!/bin/bash

array_size=0
array=()
MAX_SIZE=$1

while true; do
	let "array_size=$array_size + 10"
	array+=(1 2 3 4 5 6 7 8 9 10)

	if (( $array_size == $MAX_SIZE )); then
		exit 0
	fi
done

