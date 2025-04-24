#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

# FIXME:  not working
###############################################################################
# dk_getTime(RTN_time)
#
#
function(dk_getTime)
	dk_debugFunc()
	set(RTN_time ${ARGV0})

	string(TIMESTAMP time "%H:%M:%S")

    set(${RTN_time} ${time} PARENT_SCOPE)
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_getTime(time)
	message("time = ${time}")
endfunction()