include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

################################################################################
# dk_arrayCopyWithin(array, target, start, end)
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_copywithin
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/copyWithin
#
function(dk_arrayCopyWithin array target start end)
	dk_debugFunc("\${ARGV}")
	
	dk_todo("dk_arrayCopyWithin")
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_arrayCopyWithin(array target start end)
endfunction()