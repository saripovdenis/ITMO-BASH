#!/bin/bash

# $# - count of arguments
# -ne - doesn't equals

fileTrashName=$1
homeTrash=$HOME/.trash
homeLog=$HOME/.trash.log

if [ $# -ne 1 ]; then # if count of arguments != 1 =>  error
    echo "Error. Wrong number of arguments"
    exit 1
fi

if [ ! -f ""$PWD"/"$1"" ]; then # if file in argument doesnt exist in this directory =>  error
    echo "Error. File "$1" not found"
    exit 1
fi

if [ ! -d $homeTrash ]; then # if directory hometrash doesn't exist => create hometrash
    mkdir $homeTrash
fi

currentTrashFile=$(date +%s) 
ln $fileTrashName "$homeTrash/$fileTrashName_$currentTrashFile" # make a hard reference and delete the original

rm $fileTrashName

if [ ! -e $homeLog ]; then # if trash.log doesn't exist => create a trash.log
    touch $homeLog
fi

echo "$PWD/$fileTrashName:$fileTrashName_$currentTrashFile" >> $homeLog # create a data, which file we removed

echo "=== File successfully removed ==="














