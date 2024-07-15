@echo off

::echo #### Windows Services ####
::sc query
::sc query > services_running.txt
::sc query state= all > services_all.txt
echo. > services_running.txt
for /f "tokens=2" %%s in ('sc query ^| find "SERVICE_NAME"') do echo %%s >> services_running.txt


echo. > services_all.txt
for /f "tokens=2" %%s in ('sc query state^= all ^| find "SERVICE_NAME"') do echo %%s >> services_all.txt
