#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

##################################################################################
# dk_convertToCIdentifier(<input> <output>)
#
#
function(dk_convertToCIdentifier input output)
	dk_debugFunc(2)
		
	string(MAKE_C_IDENTIFIER ${input} c_identifier)	
	
	set(${output} ${c_identifier} PARENT_SCOPE)
endfunction()




function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
	dk_debugFunc()
	
	# Can't handle these characters yet->    [ ] \ ' . / ~ " ? < > { } `
	set(myVar "a A b B c C d D e E f F g G h H i I j J k K l L m M n N o O p P q Q r R s S t T u U v V w W x X y Y z Z 1 2 3 4 5 6 7 8 9 0 - = ; , ! @ # $ % ^ & * ( ) _ + | :")
	dk_convertToCIdentifier("${myVar}" myAlphaNumericVar)
	dk_info("myAlphaNumericVar = ${myAlphaNumericVar}")
endfunction()