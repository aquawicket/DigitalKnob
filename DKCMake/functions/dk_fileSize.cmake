#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

##############################################################################
# dk_fileSize(path)
# 
#
function(dk_fileSize)
	dk_debugFunc(1)
	
	set(path "${ARGV0}")
	dk_assertPath(${path})
	file(SIZE "${path}" dk_fileSize)
	set(dk_fileSize ${dk_fileSize} PARENT_SCOPE)
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_fileSize("C:/Windows/notepad.exe")
	dk_echo("filesize of notepad is ${dk_fileSize}")
endfunction()
