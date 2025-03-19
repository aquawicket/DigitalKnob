#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	file(TO_CMAKE_PATH "$ENV{USERPROFILE}$ENV{HOME}/digitalknob/Development/DKCMake/functions" DKCMAKE_FUNCTIONS_DIR)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "$ENV{DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

################################################################################
# dk_arrayPush(array, element1, element2, /* …, */ elementN)
#
#    The push() method of Array instances adds the specified elements to the end of an array and returns the new length of the array.
#
#    PARAMETERS
#    element1, …, elementN
#        The element(s) to add to the end of the array.
#
#    RETURN VALUE
#    The new length property of the object upon which the method was called.
#
#    REFERENCE
#    https://www.w3schools.com/js/js_array_methods.asp#mark_push
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/push
#
function(dk_arrayPush array)
	dk_debugFunc()
	
#	if(DEFINED "${ARGV}")
#		set(_array_ "${ARGV}")
#		set(name ${_array_})
#	elseif(DEFINED "ARGV")
#		set(_array_ "ARGV")
#		set(name ${_array_})
#	else()
#		dk_fatal("arguments invalid: ${_array_}")
#	endif()
	
	#dk_fixme("${CMAKE_CURRENT_FUNCTION}")
	#list(APPEND ${name} ${element1})
#	dk_append(${name} ${element1})


	list(APPEND ${array} ${ARGN})
	set(${array} ${${array}} PARENT_SCOPE)

	
# DEBUG
#	TODO
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_arrayPush(myArrayA "a b c") # new_lengthA
	dk_printVar(myArrayA)
	# dk_printVar(new_lengthA)
	
	dk_arrayPush(myArrayA "1 2 3" "d e f") # new_lengthA
	dk_printVar(myArrayA)
	# dk_printVar(new_lengthA)
	
	dk_arrayPush(myArrayA "4 5 6" "h i j") # new_lengthA
	dk_printVar(myArrayA)
	# dk_printVar(new_lengthA)
	
	
	
	# FIXME: the new array does not get assigned in command substitution.
	dk_arrayPush('myArrayB' "h i j" new_lengthB)
	dk_printVar(myArrayB)
	dk_printVar(new_lengthB)
	
	dk_arrayPush('myArrayB' "4 5 6" "d e f" new_lengthB)
	dk_printVar(myArrayB)
	dk_printVar(new_lengthB)
	
	dk_arrayPush('myArrayB' "1 2 3" "a b c" new_lengthB)
	dk_printVar(myArrayB)
	dk_printVar(new_lengthB)
endfunction()
