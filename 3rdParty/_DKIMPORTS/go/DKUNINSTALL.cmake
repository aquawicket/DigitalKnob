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


############ go ############
# https://go.dev/dl/go1.26.3.windows-amd64.msi
#
function(DKUNINSTALL)
    dk_debugFunc()

    dk_validate		(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
    dk_fileVariables	("$ENV{DKIMPORTS_DIR}/go/dkconfig.txt")
    dk_importVariables	(${go_Import} NAME go)
    dk_delete			("${go}")
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)

	DKUNINSTALL()
endfunction()

