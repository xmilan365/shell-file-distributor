# shell-file-distributor
Shell script manages files in download folder to defined directories based on their extensions.

This simple shell will clean Downloads directory and if files are not usedi, script will inform user by mail and purge them after one month. This needs to be run by crontab. 


do not forget to set the crontab - this will run script every 10 minutes
*      /10     *       *       *

