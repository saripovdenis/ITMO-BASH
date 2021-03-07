#!/bin/bash
#head -n1 mean last line(-n)
ps aux | awk '{if ($1 != "USER") print $0}' | sort -rk9 | head -n1 | awk '{print $2}'
