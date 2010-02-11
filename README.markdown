Crontab Backup Script
=====================

This is a simple tool for backing up and versioning crontabs on multiple machines. Run it as follows:

./crontab_backup.rb user@example.com other@example.com

It will create a directory under the current directory called "crontab_backups"; this will be populated with files named "user_at_example.com.crontab" and so forth. 

You can create a git repo in this directory. If you do so, you can use the backup_and_commit.sh script like this:

./backup_and_commit.sh user@example.com other@example.com

This script will run the crontab_backup script and if any crontabs have changed, commit the changes with a message of the form "backup mm/dd/yy". It will the automatically do a "git push origin master", so you can add a remote repo like GitHub, Assembla, Unfuddle, or a locally hosted repo. 

As always, suggestions and improvements are welcome.
