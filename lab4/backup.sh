#!/bin/bash

backupHomeDir="$HOME/"
sourceDir="$HOME/source/"
todayDate=$(date "+%F") # %F mean full date (y,m,d)

dircreated=0
backupPrefix="Backup-"
backupReport="$HOME/backup-report"
todaySec=$(date --date=$todayDate "+%s")
isFirstBackup=1

# check first backup or not
touch temp.txt
ls $backupHomeDir -1 > temp.txt
if grep -qE "Backup-[0-9]{4}-[0-9]{2}-[0-9]{2}" temp.txt; then
    isFirstBackup=0
    echo "It is not a first backup"
else
    echo "It is a first backup"
fi
rm temp.txt

# ls -1 mean echo in stolbik)
#grep -E mean  extended regular expression
lastbackupDir=$(ls $backupHomeDir -1 | grep -E "Backup-[0-9]{4}-[0-9]{2}-[0-9]{2}" | sort | head -1)
lastbackupSec=$(date --date=$(ls $backupHomeDir -1 | grep -E "Backup-[0-9]{4}-[0-9]{2}-[0-9]{2}" | sort | head -1 | sed "s/^Backup-//") "+%s")

let dateDiff=($todaySec\-$lastbackupSec)/60/60/24 # get the different in the days

# check different in 7 days with last backup
if [[ "$dateDiff" -le 7 ]] && [[ "$isFirstBackup" == "0" ]]; then 
    echo "dateDiff less 7"
    currentbackupDir=$backupHomeDir$lastbackupDir"/"
else
    isFirstBackup=0
    echo "NOT dateDiff less 7"
    mkdir $backupHomeDir$backupPrefix$todayDate
    currentbackupDir=$backupHomeDir$backupPrefix$todayDate"/"
    dircreated=1
fi

# if dir created => copy files from source to new dir
if [ "$dircreated" == "1" ]; then
    echo "New backup. Date: "$todayDate". Directory: "$sourceDir". Files:" >> "$backupReport"
    for file in $(ls $sourceDir -1)
    do
        cp "$sourceDir$file" "$currentbackupDir$file"
        echo "$file" >> "$backupReport"
    done
else # if dir didn't created => update current backup
    echo "Updating backup. Date: "$todayDate". Directory "$currentbackupDir". " >> "$backupReport"

    for file in $(ls $sourceDir -1)
    do
        currentfile=$currentbackupDir$file
        if [ -f $currentfile ]; then # if this file exist in source and in this directory
            source_size=$(stat $sourceDir$file -c%s) # stat of files in format(-c) + size(%s) in bytes
            actual_size=$(stat $currentfile -c%s)
            if [ "$source_size" != "$actual_size" ]; then # if file changed
                mv $currentfile $currentfile"."$todayDate #rename file in  backupdir
                cp $sourceDir$file $currentfile
                echo "Found new version of "$file". Old version copied to "$file"."$todayDate"" >> $backupReport
            fi
        else # if in this directory file not exist
            cp $sourceDir$file $currentfile
            echo "New file "$file" copied" >> $backupReport
        fi
    done
fi

echo "=== Successfully backup ==="






















