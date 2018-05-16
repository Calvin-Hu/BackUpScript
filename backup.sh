#!/bin/sh 
status=0
# param 1 is the directory to backup, param 2 is the directory to contain the hidden backup directory
if [$# -ne 2];
    then
    echo "Illegal Argument, Expecting 2 argument(Path to files, and where to store backups)" >&2
    status=1
    #exits with 1 if there is an illegal argument error or error accessing file or directory
    exit $status
fi
dir=$1
#checks if the directory that contains the files to be backed up exists
if [ ! -d dir ]; then
    echo "Not a directory" >&2
    status=1
    exit $status
    
fi
backup="$2/.backup"
#checks if the hidden back up directory exists, if not it will create it assuming it has permission
if [ ! -d $backup ]; then
    mkdir $backup
fi
cd dir
#it will try to copy every file in directory specified in param 1 into the hidden back up directory
for file in * ; do
    #checks if it is a file
    if [ -f file ]; then
        backupFile=$backup/$file
        #checks if it is the file in the hidden directory is newer than the one in the other directory
        if [ ! $backupFile -nt $dir/$file ] ; then
            #if it is not newer, it will try to copy the file into the hidden directory
            if ! cp "$file" $backup; then
                #exits 2 if there is an error copying file into hidden backup directory
                status=2
            fi
        fi
    fi
done
exit status
