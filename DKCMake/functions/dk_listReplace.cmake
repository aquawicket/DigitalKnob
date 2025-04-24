#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

###############################################################################
# dk_listReplace(LIST old_value new_value)
#  
#	Replace a list item with a new value
#
#	@LIST		- TODO
#	@old_value	- The value to replace
#	@new_value	- The new value to replace with
#
function(dk_listReplace LIST old_value new_value)
	dk_debugFunc()
	
    list(FIND ${LIST} ${old_value} old_value_INDEX)
    if(old_value_INDEX GREATER_EQUAL 0)
        list(REMOVE_AT ${LIST} ${old_value_INDEX})
        list(INSERT ${LIST} ${old_value_INDEX} ${new_value})
    endif()
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(0)
>>>>>>> Development
	
	dk_todo()
endfunction()