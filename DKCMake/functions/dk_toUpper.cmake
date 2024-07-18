include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
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
	dk_debugFunc(${ARGV})
	
	string(TOUPPER "${str}" toUpper)
	dk_printVar(toUpper)
	set(${rtn_var} ${toUpper} PARENT_SCOPE)
endfunction()





function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc(${ARGV})
	
	# Can't handle these characters yet->    [ ] \ ' . / ~ " ? < >
	set(myVar "a A b B c C d D e E f F g G h H i I j J k K l L m M n N o O p P q Q r R s S t T u U v V w W x X y Y z Z 1 2 3 4 5 6 7 8 9 0 ` - = ; , ! @ # $ % ^ & * ( ) _ + { } | :")
	dk_toUpper("${myVar}" Upper)
	dk_info("Upper = ${Upper}")
endfunction()