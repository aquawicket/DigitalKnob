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


#########################################################################
# dk_getFilename(<path>, <rtn_var:optional>)
#
#	Get file name with neither the directory nor the longest extension.
#
#	C:/Windows/System32/MyFile.tar.gz
#                       MyFile    <------
#
function(dk_getFilename)
	dk_debugFunc(1 2)
	dk_getArg(0 path)
	dk_getArg(1 rtn_var)

	get_filename_component(absolute_path ${path} ABSOLUTE)
	get_filename_component(dk_getFilename "${absolute_path}" NAME)

	dk_getExtension(${dk_getFilename})
	string(REPLACE "${dk_getExtension}" "" dk_getFilename "${dk_getFilename}")
	
	### return ###
	set(dk_getFilename ${dk_getFilename} PARENT_SCOPE)
	if(rtn_var)
		set(${rtn_var} ${dk_getFilename} PARENT_SCOPE)
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST) 
	dk_debugFunc(0)
	
	dk_echo("")
	dk_getFilename("/path/to/a/filename.txt")
	dk_info("dk_getFilename of /path/to/a/filename.txt = ${dk_getFilename}")
	
	dk_echo("")
	dk_getFilename("/path/to/a/filename.random")
	dk_info("dk_getFilename of /path/to/a/filename.random = ${dk_getFilename}")
	
	dk_echo("")
	dk_getFilename("C:/Windows/System32/filename.tar.gz")
	dk_info("dk_getFilename of C:/Windows/System32/filename.tar.gz = ${dk_getFilename}")
	
	dk_echo("")
	dk_getFilename("C:/Windows/System32/filename.7z.exe")
	dk_info("dk_getFilename of C:/Windows/System32/filename.7z.exe = ${dk_getFilename}")
	
	dk_echo("")
	dk_getFilename("/path/to/a/filename.v5.7.6.exe")
	dk_info("dk_getFilename of /path/to/a/filename.v5.7.6.exe = ${dk_getFilename}")
	
	dk_echo("")
	dk_getFilename("C:/Windows/System32")
	dk_info("dk_getFilename of C:/Windows/System32 = ${dk_getFilename}")
	
	dk_echo("")
	dk_getFilename("C:/Windows/System32/")
	dk_info("dk_getFilename of C:/Windows/System32/ = ${dk_getFilename}")
endfunction()