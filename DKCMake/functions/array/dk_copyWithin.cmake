#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	file(TO_CMAKE_PATH "$ENV{USERPROFILE}$ENV{HOME}/digitalknob/Development/DKCMake/functions" DKCMAKE_FUNCTIONS_DIR)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "$ENV{DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

################################################################################
# dk_arrayCopyWithin(array, target, start)
# dk_arrayCopyWithin(array, target, start, end)
#
#	The copyWithin() method of Array instances shallow copies part of this array to another location in the same array and returns this array without modifying its length.
#
#	PARAMETERS
#	target
#		Zero-based index at which to copy the sequence to, converted to an integer. This corresponds to where the element at start will be copied to, 
#		and all elements between start and end are copied to succeeding indices.
#		Negative index counts back from the end of the array — if -array.length <= target < 0, target + array.length is used.
#		If target < -array.length, 0 is used.
#		If target >= array.length, nothing is copied.
#		If target is positioned after start after normalization, copying only happens until the end of array.length (in other words, copyWithin() never extends the array).
#	start
#		Zero-based index at which to start copying elements from, converted to an integer.
#		Negative index counts back from the end of the array — if -array.length <= start < 0, start + array.length is used.
#		If start < -array.length, 0 is used.
#		If start >= array.length, nothing is copied.
#	end :optional
#		Zero-based index at which to end copying elements from, converted to an integer. copyWithin() copies up to but not including end.
#		Negative index counts back from the end of the array — if -array.length <= end < 0, end + array.length is used.
#		If end < -array.length, 0 is used.
#		If end >= array.length or end is omitted, array.length is used, causing all elements until the end to be copied.
#		If end implies a position before or at the position that start implies, nothing is copied.
#
#	RETURN VALUE
#		The modified array
#
#	REFERENCE
#		https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/copyWithin
#
function(dk_arrayCopyWithin array target start end)
	dk_debugFunc(3 4)

	dk_todo("dk_arrayCopyWithin")
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)

	dk_arrayCopyWithin(array target start end)
endfunction()
