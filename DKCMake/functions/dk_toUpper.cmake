include_guard()

###############################################################################
# dk_toUpper(str RESULT)
#
#	Convert a string to upper case
#
#	@str	- The input string to convert
#	@RESULT	- Returns the converted output string
#
function(dk_toUpper str RESULT)
	#DKDEBUGFUNC(${ARGV})
	string(TOUPPER "${str}" upper)
	set(${RESULT} ${upper} PARENT_SCOPE)
endfunction()