#!/bin/bash
#maintaionar abhishek
#05-082026
#backup and cleanup script


#variables start

year=$(date +%Y)
mon=$(date +%b)
day=$(date +%d)

source_dir="/home/abhishek/june2026/Assignment/project1"
var_path=$year/$mon/$day.$mon.$year
backup_dir="./backup"
log_dir="./logs"
log_file="$log_dir/$day$mon$year.log"
retention_day=2

mkdir -p "$log_dir"

#echo "$backup_dir"

#log function

log_message(){
        echo "$(date '+%Y-%m-%d %H:%M:%S') : $1 " >> "$log_file"
}


#check source directory exist or not

if [ ! -d "$source_dir" ]; then
        log_message "ERROR: Source directory not found."
        exit 1
fi

#create backup directory if not exists


#create backup file

backup_file="$backup_dir/backup_$day$mon$year.tar.gz"
echo "$backup_file"
# create compress backup
 

tar -czf "$backup_file" "$source_dir"

if [ $? -eq 0 ]; then
        log_message "Backup craeted sucessfully: $backup_file"
else
        log_message "Backup failed."
        exit 1
fi

#echo "$backup_file"
#echo "$source_dir/backup"
# Delete old files from directory

old_files=$(find "$source_dir/backup" -type f -mtime +$retention_day)

if [ -n "$old_files" ]; then
	find "$source_dir/backup" -type f -mtime +$retention_day -delete	
	log_message "Deleted $retention_day old files successfully."
else
	log_message "No files older than $retention_day days found."
fi
log_message "backup and cleanup process completed"

exit 0
