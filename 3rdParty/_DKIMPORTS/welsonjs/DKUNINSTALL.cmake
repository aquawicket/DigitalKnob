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


############ welsonjs ############
# https://github.com/gnh1201/welsonjs/archive/8d4a90c0e11a737a77528e27f5913ef6baa7d7c2.zip
#
function(DKUNINSTALL)
    dk_debugFunc()

    dk_validate		(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
    dk_fileVariables	("$ENV{DKIMPORTS_DIR}/welsonjs/dkconfig.txt")
    dk_importVariables	(${welsonjs_Import} NAME welsonjs)
    dk_delete			("${welsonjs}")
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)

	DKUNINSTALL()
endfunction()

