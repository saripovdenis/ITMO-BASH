#!/bin/bash
awk '{if ($2=="INFO") print $0 > "info.log"}' < /var/log/anaconda/syslog

