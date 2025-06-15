#/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### everything ######
# https://www.voidtools.com/Everything-1.4.1.1027.x64.zip

### INSTALL ###
dk_getFileParams	("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_validate			(Host_Tuple "dk_Host_Tuple()")
dk_validate			(DKTOOLS_DIR "dk_DKTOOLS_DIR()")
dk_import			(${Everything_${Host_Tuple}_Import} ROOT "${DKTOOLS_DIR}")
