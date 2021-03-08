#!/bin/bash

if [ $# -ne 1 ]; then # if count of arguments != 1 => error
    echo "Error. Wrong number of arguments"
    exit 1
fi

trashDir=~/.trash
trashLog=~/.trash.log

if [ ! -d "$trashDir" ]; then # if trashdir doesn't exist => error
    echo "Error! .trash does not exist"
    exit 1
fi

if [ ! -f "$trashLog" ]; then # if trashlog doesn't exist => error
    echo "Error! .trash.log. does not exist"
    exit 1
fi

if [ -z $(grep "$1" "$trashLog") ]; then # if file in argument doesn't exist in trashlog => error
    echo "Error! File $1 does not exist"
    exit 1
fi

restFile=/home/parallels/Labs/lab4/$1  

for i in $(grep -h $1 $HOME/.trash.log) # -h cancel echo file name in grep
do # run in trashlof and find argument
    glPath=$(echo $i | awk -F ":" '{print $1}') # -F mean a separate with ':' 
    fileId=$(echo $i | awk -F ":" '{print $2}')
    if [ $restFile == $glPath ]; then # if path of our file equal path from trashLog  
        rmFile=$HOME/.trash/$fileId 
        if [ -e $rmFile ]; then # if FILE exist and it's file:
            echo "Do you want to restore file -$glPath ? (y - yes, n - no)"
            read answer
            
            if [ "$answer" == "y" ]; then
                if [ -d $(dirname $glPath) ]; then # if this directory exist
                    if [ -e $glPath ]; then # if file with this name exist => read a new name
                        echo "Duplicate name! Type new name"
                        read newName
                        ln "$rmFile" "$(dirname $glPath)/$newName" 
                    else
                        ln $rmFile $glPath
                    fi
                else # if directory doesn't exist => untrash this file in home
                    echo "Folder $(dirname $glPath) is no longer exists"
                    ln $rmFile $HOME/$1
                fi
                rm $rmFile # delete this file in .trash
                    
                grep -v $fileId $HOME/.trash.log > $HOME/.trashTemp.log  # write all lines without a choosen (-v)
                mv $HOME/.trashTemp.log $HOME/.trash.log # rename a temp.log
            fi
        fi
    fi
done








