#/usr/bin/cmake -P 
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}") 
set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/") 
endif() 
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake") 
 
 
###### httrack ###### 
# https://download.httrack.com/httrack_x64-noinst-3.49.2.zip
 
### INSTALL ### 
dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_import		(${HTTRACK_IMPORT} NAME httrack) 
