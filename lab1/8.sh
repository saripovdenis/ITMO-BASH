#!/bin/bash
#-F'some symbol' add to list of IFS a new symbol
#-n compare according to string numerical value
#-k2 sort with start in 2 pos

awk -F: '{print $1, $3}' /etc/passwd | sort -nk2

