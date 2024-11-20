#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_toUpper(str rtn_var)
#
#	Convert a string to upper case
#
#	@str	- The input string to convert
#	@rtn_var	- Returns the converted output string
#
function(dk_toUpper str rtn_var)
	dk_debugFunc()
	
	string(TOUPPER "${str}" toUpper)
	#dk_printVar(toUpper)
	if(${rtn_var} MATCHES "ENV{")
		set(${rtn_var} "${toUpper}")
	else()
		set(${rtn_var} "${toUpper}" PARENT_SCOPE)
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)

	# these characters require escapes ->  \ "    use: \\ and \"
	set(myVar "aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ 1234567890 ` - = ; , ! @ # $ % ^ & * ( ) _ + { } | : [ ] ' . / ~ ? < > \\ \" ")
	dk_printVar(myVar)
	dk_toUpper("${myVar}" Upper)
	dk_printVar(Upper)
	
	set(ENV{myVarB} "aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ 1234567890 ` - = ; , ! @ # $ % ^ & * ( ) _ + { } | : [ ] ' . / ~ ? < > \\ \" ")
	dk_printVar(myVarB)
	dk_toUpper("$ENV{myVarB}" ENV{UpperB})
	dk_printVar(UpperB)
	
	set(myVarC [=[ aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ 1234567890 ` - = ; , ! @ # $ % ^ & * ( ) _ + { } | : [ ] ' . / ~ ? < > \ " ]=])
	dk_printVar(myVarC)
	dk_toUpper("${myVarC}" UpperC)
	dk_printVar(UpperC)
endfunction()