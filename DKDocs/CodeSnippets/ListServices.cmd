@ECHO OFF

echo #### Windows Services ####
sc query
sc query > running_services.txt
sc query state= all > all_services.txt
pause