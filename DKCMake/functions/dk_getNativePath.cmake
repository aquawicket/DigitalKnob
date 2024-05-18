include_guard()

##################################################################################
# dk_getNativePath(<input> <output>)
#
#
function(dk_getNativePath input output)
	dk_debugFunc(${ARGV})
	if(NOT ${ARGC} EQUAL 2)
		dk_error("${CMAKE_CURRENT_FUNCTION}(): incorrect number of arguments")
	endif()
		
	file(TO_NATIVE_PATH ${input} native_path)
	
	set(${output} ${native_path} PARENT_SCOPE)
endfunction()




macro(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_todo()
	
endmacro(DKTEST)