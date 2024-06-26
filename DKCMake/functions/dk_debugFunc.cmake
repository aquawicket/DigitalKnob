include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

#set(ENABLE_dk_debugFunc 1)
##################################################################################
# dk_debugFunc(${ARGV})
#
#	Prints the current file name, line number, function or macro name, and argument names with values
#	Place this at the first line of every function in DKCMake and your own functions
# 
#	Example:
#		function(MyFunction myArg1 myArg2)
#			dk_debugFunc(${ARGV})
#
#			## user code
#		endfunction()
#
macro(dk_debugFunc)
	set(__FILE__ "${CMAKE_CURRENT_FUNCTION_LIST_FILE}" CACHE INTERNAL "")
	set(__LINE__ "${CMAKE_CURRENT_FUNCTION_LIST_LINE}" CACHE INTERNAL "")
	set(__FUNCTION__ "${CMAKE_CURRENT_FUNCTION}"       CACHE INTERNAL "")
	
	#dk_info("TODO: make an exclude ARGV list for dk_debugFunc printing")
	if(NOT "${__FUNCTION__}" STREQUAL "dk_fileAppend")
	if(NOT "${__FUNCTION__}" STREQUAL "dk_fileWrite")
		set(__ARGV__     "${ARGV}"                     CACHE INTERNAL "")
	endif()
	endif()
	
	list(GET STACK_LEVEL 0 __LEVEL__)
	set(__LEVEL__     ${__LEVEL__}                     CACHE INTERNAL "")
	string(TIMESTAMP __TIME__ "%M:%S:%f")
	string(SUBSTRING "${__TIME__}" 0 10 __TIME__)
	set(__TIME__      ${__TIME__}                      CACHE INTERNAL "")
	
	if(ENABLE_dk_debugFunc)	
		#dk_info("TODO: make an exclude echo list for dk_debugFunc")
		    if("${__FUNCTION__}" STREQUAL "dk_echo")
		elseif("${__FUNCTION__}" STREQUAL "dk_info")
		elseif("${__FUNCTION__}" STREQUAL "dk_debug")
		elseif("${__FUNCTION__}" STREQUAL "dk_warning")
		elseif("${__FUNCTION__}" STREQUAL "dk_verbose")
		elseif("${__FUNCTION__}" STREQUAL "dk_error")
		elseif("${__FUNCTION__}" STREQUAL "dk_todo")
		elseif("${__FUNCTION__}" STREQUAL "dk_fixme")
		elseif("${__FUNCTION__}" STREQUAL "dk_printVar")
		elseif("${__FUNCTION__}" STREQUAL "dk_dumpAllVariables")
		elseif("${__FUNCTION__}" STREQUAL "dk_fileAppend")
		else()
			set(ESC "")
			set(cyan "[36m")
			set(blue "[34m")
			set(clr "[0m")

			unset(indent)
			set(i 4)
			while(${i} LESS ${__LEVEL__})
				set(indent "${indent}   ")
				math(EXPR i "${i}+1")
			endwhile(${i} LESS ${__LEVEL__})
			set(indent "${indent} L ")
	
			dk_echo("${cyan}[${__TIME__}]${indent}${__FILE__}:${__LINE__}   ${blue}${__FUNCTION__}(${__ARGV__})${clr}")
		endif()
	endif()
endmacro()
