#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

################################################################################
# dk_arrayUnshift(array, element)
# dk_arrayUnshift(array, element, rtn_var)
#
#    Adds the specified elements to the beginning of an array and returns the new length of the array.
#
#    PARAMETERS
#    element1, …, elementN
#    The elements to add to the front of the arr.
#
#    RETURN VALUE
#    The new length property of the object upon which the method was called.
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_unshift
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/unshift
#
function(dk_arrayUnshift array)
	dk_debugFunc(2 99)
	
	list(PREPEND ${array} ${ARGN})
	set(${array} ${${array}} PARENT_SCOPE)
	
	### return value ###
	#local _length_=${#array[@]}
	#dk_return ${_length_} && return						# return value using command substitution
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_arrayUnshift(myArrayA "a b c") #new_lengthA
	dk_printVar(myArrayA)
	#dk_printVar(new_lengthA)
	
	dk_arrayUnshift(myArrayA "1 2 3") #new_lengthA
	dk_printVar(myArrayA)
	#dk_printVar(new_lengthA)
	
	dk_arrayUnshift(myArrayA "d e f") #new_lengthA
	dk_printVar(myArrayA)
	#dk_printVar(new_lengthA)
	
	dk_arrayUnshift(myArrayA "4 5 6") #new_lengthA
	dk_printVar(myArrayA)
	#dk_printVar(new_lengthA)
	
	dk_arrayUnshift(myArrayA "h i j") #new_lengthA
	dk_printVar(myArrayA)
	#dk_printVar(new_lengthA)
	
	
	# FIXME: command substitution cannot alter parent variables
	dk_arrayUnshift(myArrayB "h i j" new_lengthB)
	dk_printVar(myArrayB)
	dk_printVar(new_lengthB)
	
	dk_arrayUnshift(myArrayB "4 5 6" new_lengthB)
	dk_printVar(myArrayB)
	dk_printVar(new_lengthB)
	
	dk_arrayUnshift(myArrayB "d e f" new_lengthB)
	dk_printVar(myArrayB)
	dk_printVar(new_lengthB)
	
	dk_arrayUnshift(myArrayB "1 2 3" new_lengthB)
	dk_printVar(myArrayB)
	dk_printVar(new_lengthB)
	
	dk_arrayUnshift(myArrayB "a b c" new_lengthB)
	dk_printVar(myArrayB)
	dk_printVar(new_lengthB)
endfunction()