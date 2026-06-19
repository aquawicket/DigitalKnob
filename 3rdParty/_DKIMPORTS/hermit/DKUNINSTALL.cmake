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


############ hermit ############
# https://github.com/dylibso/hermit/archive/69d848c37da88a6047acac0fa9c1b23aefc47af9.zip
#
function(DKUNINSTALL)
    dk_debugFunc()

    dk_validate		(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
    dk_fileVariables	("$ENV{DKIMPORTS_DIR}/hermit/dkconfig.txt")
    dk_importVariables	(${hermit_Import} NAME hermit)
    dk_delete			("${hermit}")
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)

	DKUNINSTALL()
endfunction()

