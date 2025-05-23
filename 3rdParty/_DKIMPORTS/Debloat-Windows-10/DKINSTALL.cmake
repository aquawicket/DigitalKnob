#/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### Debloat-Windows-10 ######
# https://github.com/W4RH4WK/Debloat-Windows-10/archive/refs/heads/master.zip

### INSTALL ###
dk_validate		(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
dk_getFileParams	("$ENV{DKIMPORTS_DIR}/Debloat-Windows-10/dkconfig.txt")
dk_import			(${DEBLOAT-WINDOWS-10_IMPORT} NAME Debloat-Windows-10)
