#/usr/bin/cmake -P 
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}") 
set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/") 
endif() 
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake") 
 
 
###### rufus ###### 
# https://github.com/pbatard/rufus/releases/download/v4.7/rufus-4.7p.exe 
 
### INSTALL ### 
dk_validate		(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()") 
dk_getFileParams("$ENV{DKIMPORTS_DIR}/rufus/dkconfig.txt")
message("RUFUS_IMPORT = ${RUFUS_IMPORT}")

dk_download		("${RUFUS_IMPORT}")

#dk_validate(DKTOOLS_DIR "dk_DKTOOLS_DIR")
#dk_import		("${RUFUS_IMPORT}" NAME rufus ROOT "${DKTOOLS_DIR}") 
