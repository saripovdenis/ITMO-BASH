#!/bin/bash
#^ - start of the line
#$ - end of the line
#d - delete (sed)
#head -3 - last of sorted values


man bash | tr "[:upper:]" "[:lower:]" | tr '[:punct:]' ' ' |
           tr ' ' '\n' | sed '/^$/d' | sed '/..../!d' | sort |
           uniq -c | sort -rnk1 | head -3

