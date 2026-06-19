#/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DK.cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


############ Dependencies ############
# https://github.com/lucasg/Dependencies/releases/download/v1.11.1/Dependencies_x64_Release.zip
#
function(DKUNINSTALL)
    dk_debugFunc()

    dk_validate		(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
    dk_fileVariables	("$ENV{DKIMPORTS_DIR}/Dependencies/dkconfig.txt")
    dk_importVariables	(${Dependencies_Import} NAME Dependencies)
    dk_delete			("${Dependencies}")
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)

	DKUNINSTALL()
endfunction()

