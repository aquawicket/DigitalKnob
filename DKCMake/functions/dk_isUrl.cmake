#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

##############################################################################
# dk_isUrl(variable rtn_var)
# 
#	Test if a varaible is a url
#
#	@variable	- The variable to test
#	@rtn_var: 	- True if the variable is a url, False if otherwise.
#
function(dk_isUrl rtn_var)
	dk_debugFunc()
	
	dk_todo("dk_isUrl():  this function is very rough draft and needs an overhaul")
	set(${rtn_var} 0 PARENT_SCOPE)
	# "/^(https?| ftp):\/\/[^\s/$.?#]") # replace this javascript regex pattern with cmake regex
	if(${ARGN} MATCHES "^[https]")
		set(${rtn_var} 1 PARENT_SCOPE)
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_isUrl(result https://www.test.com)
	dk_echo("https://www.test.com = ${result}")
	dk_isUrl(result "https://www.test.com")
	dk_echo("\"https://www.test.com\" = ${result}")
	dk_isUrl(result 'https://www.test.com')
	dk_echo("'https://www.test.com' = ${result}")
	
	dk_isUrl(result 'notAUrl')
	dk_echo("'notAUrl' = ${result}")
endfunction()
