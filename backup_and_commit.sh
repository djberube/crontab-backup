#!/bin/sh

./crontab_backup.rb $@ 
cd crontab_backups

# Note that git will only create a commit if actual changes are made;
# therefore, if nothing has changed, these next three lines won't do
# won't create noise commits. 

git add .
git commit -am "backup `date +%m/%d/%y`"
git push origin master

