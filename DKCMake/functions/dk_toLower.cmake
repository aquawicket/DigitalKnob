include_guard()

###############################################################################
# dk_toLower(str RESULT)
#
#	Convert a string to lower case
#
#	@str	- The input string to convert
#	@RESULT	- Returns the converted output string
#
function(dk_toLower str RESULT)
	DKDEBUGFUNC(${ARGV})
	string(TOLOWER "${str}" upper)
	set(${RESULT} ${out} PARENT_SCOPE)
endfunction()