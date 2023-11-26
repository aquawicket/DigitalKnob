@echo off
%dkbatch%

echo #### Windows Services ####
sc query
sc query > services_running.txt
sc query state= all > services_all.txt
