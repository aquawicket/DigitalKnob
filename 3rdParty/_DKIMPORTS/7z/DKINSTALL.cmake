#/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### 7z ######
# https://www.7-zip.org/a/7z2409-extra.7z

### INSTALL ###
dk_validate			(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
dk_getFileParams	("$ENV{DKIMPORTS_DIR}/7z/dkconfig.txt")
dk_import			(${7Z_IMPORT} 	NAME     7z)
dk_set				(7ZA_EXE		${_7Z}/7za.exe)
