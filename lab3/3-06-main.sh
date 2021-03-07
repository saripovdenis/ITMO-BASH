#!/bin/bash

./3-06-handler.sh &
pid=$!

./3-06-generator.sh $pid
