#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

##################################################################################
# dk_removeAll()
#
#
function(dk_removeAll)
	dk_debugFunc()

endfunction()



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_removeAll()
endfunction()