Crontab Backup Script
=====================

This is a (very specific) tool for backing up and versioning crontabs on multiple machines. Run it as follows:

./crontab_backup.rb user@example.com other@example.com

It will create a directory under the current directory called "crontab_backups"; this will be populated with files named "user_at_example.com.crontab" and so forth. If this directory does nmot exist, it will be created, and a git repo initialized in it's place.

As always, suggestions and improvements are welcome.

     _    _   _                     _          
  __| |  (_) | |__   ___ _ __ _   _| |__   ___ 
 / _` |  | | | '_ \ / _ \ '__| | | | '_ \ / _ \
| (_| |_ | |_| |_) |  __/ |  | |_| | |_) |  __/
 \__,_(_)/ (_)_.__/ \___|_|   \__,_|_.__/ \___|
       |__/                                    
