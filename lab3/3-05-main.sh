#!/bin/bash

mkfifo pipe

./3-05-handler.sh &
./3-05-generator.sh

rm pipe
