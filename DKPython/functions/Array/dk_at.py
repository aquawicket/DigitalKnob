import sys
sys.path.append(".")
sys.path.append("../")
from DK import *

################################################################################
# Array_dk_at(array, index)
#
#	 Takes an array instance with an integer value and returns the item at that index, 
#	 allowing for positive and negative integers. Negative integers count back from the last item in the array.  <-- TODO
#
#    PARAMETERS
#    index
#    Zero-based index of the array element to be returned, converted to an integer. Negative index counts back from the end of the array — if index < 0, index + array.length is accessed.
#
#    RETURN VALUE
#    The element in the array matching the given index. Always returns undefined if index < -array.length or index >= array.length without attempting to access the corresponding property.
#
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/array/at
#
def Array_dk_at(*args):
#	dk_debugFunc(2 99)
	
    print("Array_dk_at")
#	if(DEFINED "${ARGV0}")
#		set(array 	"${${ARGV0}}")
#	elseif(DEFINED ARGV0)
#		set(array 	"${ARGV0}")
#	else()
#		dk_fatal("dk_arrayLength(${ARGV}): array is invalid.")
#	endif()
#	
#	if(DEFINED "${ARGV1}")
#		set(index 	"${${ARGV1}}")
#	elseif(DEFINED ARGV0)
#		set(index 	"${ARGV1}")
#	else()
#		dk_fatal("dk_arrayLength(${ARGV}): index is invalid.")
#	endif()
#	
#	list(GET array ${index} dk_at)
#	set(dk_at ${dk_at} PARENT_SCOPE)





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
def DKTEST():
#	dk_debugFunc(0)
	
    print("DKTEST()")
#	list(APPEND myArray "a")
#	list(APPEND myArray "b")
#	list(APPEND myArray "c")
#	list(APPEND myArray "d")
#	list(APPEND myArray "e")
#	list(APPEND myArray "f")
#	list(APPEND myArray "g")
#	list(APPEND myArray "h")
#	list(APPEND myArray "i")
	
#	#Array::dk_at(myArray 0)
#	dk_call(Array::dk_at(myArray 0))
#	dk_info("dk_at 0 = ${dk_at}")
	
#	#Array::dk_at("myArray" 1)
#	dk_call(Array::dk_at("myArray" 1))
#	dk_info("dk_at 1 = ${dk_at}")
	
#	#Array::dk_at("${myArray}" 2)
#	dk_call(Array::dk_at "${myArray}" 2)
#	dk_info("dk_at 2 = ${dk_at}")
	
	# FIXME: Variables revieved by array value exceed allowed argument count
#	#Array::dk_at(${myArray} 3)				
#	dk_call(Array::dk_at ${myArray} 3)
#	dk_info("dk_at 3 = ${dk_at}")
	
#	set(at 4)
#	#Array::dk_at(myArray at)
#	dk_call(Array::dk_at myArray at)
#	dk_info("dk_at 4 = ${dk_at}")
	
#	set(at 5)
#	#Array::dk_at(myArray "at")
#	dk_call(Array::dk_at myArray "at")
#	dk_info("dk_at 5 = ${dk_at}")
	
#	set(at 6)
#	#Array::dk_at(myArray ${at})
#	dk_call(Array::dk_at myArray ${at})
#	dk_info("dk_at 6 = ${dk_at}")
	
#	set(at 7)
#	#Array::dk_at(myArray "${at}")
#	dk_call(Array::dk_at myArray "${at}")
#	dk_info("dk_at 7 = ${dk_at}")

