#!/bin/bash

N=7400000
K=$1
i=0

for i in {1. .$K}
do
	./newmem.bash $N &
	sleep 1s
done 
