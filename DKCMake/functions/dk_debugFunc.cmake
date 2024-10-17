#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

#set(ENABLE_dk_debugFunc 1 CACHE INTERNAL "")
##################################################################################
# dk_debugFunc()
#
#	Prints the current file name, line number, function or macro name, and argument names with values
#	Place this at the first line of every function in DKCMake and your own functions
# 
#	Example:
#		function(MyFunction myArg1 myArg2)
#			dk_debugFunc()  <--------
#
#			## user code
#		endfunction()
#
macro(dk_debugFunc)
	unset(DKARGC)
	unset(DKARGV)
	foreach(arg IN LISTS ARGV)
		list(APPEND DKARGV ${arg})
	endforeach()
	list(LENGTH DKARGV DKARGC)
	#message("${DKARGC} ${DKARGV}")	
  
	set(__FILE__ "${CMAKE_CURRENT_FUNCTION_LIST_FILE}" CACHE INTERNAL "")
    get_filename_component(__FILE__ "${__FILE__}" NAME CACHE INTERNAL "")
	set(__LINE__ "${CMAKE_CURRENT_FUNCTION_LIST_LINE}" CACHE INTERNAL "")
	set(__FUNCTION__ "${CMAKE_CURRENT_FUNCTION}"       CACHE INTERNAL "")
    set(__ARGC__ "${DKARGC}"                           CACHE INTERNAL "")
	if(DKARGV)
		string(STRIP "${DKARGV}" __ARGV__)
		string(REPLACE ";" "', '" __ARGV__ "${DKARGV}")
		#string(REGEX REPLACE "([][+.*()^])" "\\\\\\1" __ARGV__ "${ARGV}")
		set(__ARGV__ "${__ARGV__}" CACHE INTERNAL "")
	endif()
	
	### Check Argument Count ###
	if(${ARGC} EQUAL 1)
		if(${DKARGC} LESS ${ARGV0})
			dk_fatal("${__FUNCTION__}(${__ARGV__}) requires at least ${ARGV0} argments: got ${DKARGC}")
		elseif(${DKARGC} GREATER ${ARGV0})
			dk_fatal("${__FUNCTION__}(${__ARGV__}) takes ${ARGV0} argments max: got ${DKARGC}")
		endif()
	elseif(${ARGC} EQUAL 2)
		if(${DKARGC} LESS ${ARGV0})
			dk_fatal("${__FUNCTION__}(${__ARGV__}) requires at least ${ARGV0} argments: got ${DKARGC}")
		elseif(${DKARGC} GREATER ${ARGV1})
			dk_fatal("${__FUNCTION__}(${__ARGV__}) takes ${ARGV1} argments max: got ${DKARGC}")
		endif()
	endif()
    
	#message("${__FUNCTION__}(${__ARGV__})")

	list(GET STACK_LEVEL 0 __LEVEL__)
	set(__LEVEL__     ${__LEVEL__}                     CACHE INTERNAL "")
	string(TIMESTAMP __TIME__ "%M:%S:%f")
	string(SUBSTRING "${__TIME__}" 0 10 __TIME__)
	set(__TIME__      ${__TIME__}                      CACHE INTERNAL "")
	
	if(ENABLE_dk_debugFunc)	
		#dk_info("TODO: make an exclude echo list for dk_debugFunc")
		#    if("${__FUNCTION__}" STREQUAL "dk_echo")
		#elseif("${__FUNCTION__}" STREQUAL "dk_info")
		#elseif("${__FUNCTION__}" STREQUAL "dk_debug")
		#elseif("${__FUNCTION__}" STREQUAL "dk_warning")
		#elseif("${__FUNCTION__}" STREQUAL "dk_verbose")
		#elseif("${__FUNCTION__}" STREQUAL "dk_error")
		#elseif("${__FUNCTION__}" STREQUAL "dk_todo")
		#elseif("${__FUNCTION__}" STREQUAL "dk_fixme")
		#elseif("${__FUNCTION__}" STREQUAL "dk_printVar")
		#elseif("${__FUNCTION__}" STREQUAL "dk_dumpAllVariables")
		#elseif("${__FUNCTION__}" STREQUAL "dk_fileAppend")
		#else()
			set(ESC "")
			set(cyan "[36m")
			set(blue "[34m")
			set(clr "[0m")

			unset(indent)
			set(i 4)
			while(${i} LESS ${__LEVEL__})
				set(indent "${indent}-")
				math(EXPR i "${i}+1")
			endwhile(${i} LESS ${__LEVEL__})
			set(indent "${indent}-> ")
	
			#message("${cyan}[${__TIME__}]${indent}${__FILE__}:${__LINE__}  ${blue}${__FUNCTION__}('${__ARGV__}')${clr}")
			message("${cyan}[${__TIME__}]${indent}${blue}${__FUNCTION__}('${__ARGV__}')${clr}")
		#endif()
	endif()
endmacro()
