#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

##################################################################################
# dk_realpath(path, rtn_var)
#
#    CMAKE: https://cmake.org/cmake/help/latest/command/get_filename_component.html
#
function(dk_realpath path rtn_var)
	dk_debugFunc(2)
	
	get_filename_component(_realpath_ ${path} REALPATH)
	#dk_printVar(_realpath_)
	set(${rtn_var} ${_realpath_} PARENT_SCOPE)
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST) #
	dk_debugFunc()
	
	dk_realpath("bash" realpath)
	dk_info("realpath = ${realpath}")
endfunction()