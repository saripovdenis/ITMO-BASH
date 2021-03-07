#!/bin/bash

#-r turns on recursive search of template
#-h helps to stop write a name of file where were took a string from
#-E to use better regualrki than -e =)
#-I don't ignore lower and upper cases
#-o only-matching(non-empty)

grep -r -h -E -I -o "[[:alnum:]_-]+@[[:alpha:]]+\.[[:alpha:]]+" /etc | tr "\n" "," > emails.lst
