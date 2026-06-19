#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
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


###### FileTest ######
# http://zezula.net/download/filetest.zip
#
function(DKINSTALL)
	dk_debugFunc(0 1)

	dk_import()
	
	if(Windows_X86_64_Host)
		dk_set(FileTest_exe "${FileTest}/x64/FileTest.exe")
	elseif(Windows_X86_Host)
		dk_set(FileTest_exe "${FileTest}/Win32/FileTest.exe")
	endif()
endfunction()










###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_envList(PLUGIN POP)
	dk_unset(FileTest)
	
	dk_validate(FileTest "dk_depend(FileTest)")
	dk_debug("FileTest = ${FileTest}")
	dk_debug("FileTest_exe = ${FileTest_exe}")
	
	dk_exec(${FileTest_exe})
endfunction()
