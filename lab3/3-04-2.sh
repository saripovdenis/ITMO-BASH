#!/bin/bash

nice -n 19 ./3-04-1.sh & f_pid=$!
nice -n 5 ./3-04-1.sh & s_pid=$!
nice -n 5 ./3-04-1.sh & t_pid=$!

echo "kill $t_pid" | at now + 1 minute
echo "kill $f_pid $s_pid" | at now + 5 minute
