#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_toLower(str, rtn_var)
#
#	Convert a string to lower case
#
#	<str>   	- The input string to convert
#	<rtn_var>	- Returns the converted output string
#
function(dk_toLower str rtn_var)
	dk_debugFunc("\${ARGV}")
	
	string(TOLOWER "${str}" toLower)
	#dk_printVar(toLower)
	set(${rtn_var} "${toLower}" PARENT_SCOPE)
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	# Can't handle these characters yet->    [ ] \ ' . / ~ " ? < >
	set(myVar "a A b B c C d D e E f F g G h H i I j J k K l L m M n N o O p P q Q r R s S t T u U v V w W x X y Y z Z 1 2 3 4 5 6 7 8 9 0 ` - = ; , ! @ # $ % ^ & * ( ) _ + { } | :")
	dk_toLower("${myVar}" lower)
	dk_info("lower = ${lower}")
endfunction()