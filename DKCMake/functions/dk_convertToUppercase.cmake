include_guard()

################################################################################
# dk_convertToUppercase(<str> <output>)
#
#
function(dk_convertToUppercase str output)
	dk_debugFunc(${ARGV})
	
	string(TOUPPER ${str} upper)
	set(${output} ${upper} PARENT_SCOPE)
	dk_printVar(${output})
endfunction()



function(DKTEST) ###############################################################################

	# Can't handle these characters yet->    [ ] \ ' . / ~ " ? < >
	set(myVar "a A b B c C d D e E f F g G h H i I j J k K l L m M n N o O p P q Q r R s S t T u U v V w W x X y Y z Z 1 2 3 4 5 6 7 8 9 0 ` - = ; , ! @ # $ % ^ & * ( ) _ + { } | :")
	dk_convertToUppercase("${myVar}" myLowerCaseVar)
	dk_printVar(myLowercaseVar)

function()