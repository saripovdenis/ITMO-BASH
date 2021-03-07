#!/bin/bash

awk '{if ($3=="(WW)") print $0}' < /var/log/anaconda/X.log | sed 's/(WW)/Warning:/' > full.log
awk '{if ($3=="(II)") print $0}' < /var/log/anaconda/X.log | sed 's/(II)/Information:/' >> full.log
