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
	dk_debugFunc(${ARGV})
	
	string(TOLOWER "${str}" lower)
	set(${RESULT} ${lower} PARENT_SCOPE)
	dk_printVar(RESULT)
endfunction()






function(DKTEST) ###############################################################################

	# Can't handle these characters yet->    [ ] \ ' . / ~ " ? < >
	set(myVar "a A b B c C d D e E f F g G h H i I j J k K l L m M n N o O p P q Q r R s S t T u U v V w W x X y Y z Z 1 2 3 4 5 6 7 8 9 0 ` - = ; , ! @ # $ % ^ & * ( ) _ + { } | :")
	dk_toLower("${myVar}" lower)
	dk_printVar(lower)

endfunction()