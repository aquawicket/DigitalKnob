@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )

echo #### Windows Services ####
sc query
sc query > services_running.txt
sc query state= all > services_all.txt
