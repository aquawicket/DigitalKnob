#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


#########################################################################
# dk_convertToCIdentifier(<input> <output>)
#
#
function(dk_convertToCIdentifier)
	dk_debugFunc(1 2)
		
	set(input ${ARGV0})
	set(output ${ARGV1})
	string(MAKE_C_IDENTIFIER "${input}" dk_convertToCIdentifier)	
	
	###### output ######
	set(dk_convertToCIdentifier ${dk_convertToCIdentifier} PARENT_SCOPE)
	if(${ARGC} GREATER 1)
		set(${output} ${dk_convertToCIdentifier} PARENT_SCOPE)
	else()
		message("${dk_convertToCIdentifier}")
	endif()
endfunction()




function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
	dk_debugFunc(0)
	
	# Can't handle these characters yet->    [ ] \ ' . / ~ " ? < > { } `
	set(myVar "a A b B c C d D e E f F g G h H i I j J k K l L m M n N o O p P q Q r R s S t T u U v V w W x X y Y z Z 1 2 3 4 5 6 7 8 9 0 - = ; , ! @ # $ % ^ & * ( ) _ + | :")
	dk_convertToCIdentifier("${myVar}" myAlphaNumericVar)
	dk_echo("myAlphaNumericVar = ${myAlphaNumericVar}")
	dk_echo("dk_convertToCIdentifier = ${dk_convertToCIdentifier}")
endfunction()