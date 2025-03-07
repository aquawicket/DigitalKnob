#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

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

	###### argv/argc/argv<n> - this macro's arguments / argument count / each argument ######
	set(argc 0)
	set(argv "${ARGV}")
	foreach(arg IN LISTS argv)
		set(argv${argc} ${arg})
		math(EXPR argc "${argc}+1")
	endforeach()

	###### argn/argnc/argn<n> - this macro's extra arguments / extra argument count / each extra argument ######
	set(argnc 0)
	set(argn "${ARGN}")
	foreach(arg IN LISTS argn)
		set(argn${argnc} ${arg})
		math(EXPR argnc "${argnc}+1")		
	endforeach()
	
	###### PARGV/PARGV/PARGV<n> - parent function arguments / argument count / each argument ######
	unset(PARGV)
	set(PARGC 0)
	foreach(arg IN LISTS ARGV)
		set(PARGV${PARGC} ${arg})
		list(APPEND PARGV ${arg})
		math(EXPR PARGC "${PARGC}+1")
	endforeach()
	set(__ARGV__ "${PARGV}"                           CACHE INTERNAL "")
	set(__ARGC__ "${PARGC}"                           CACHE INTERNAL "")
	
	###### PARGN/PARGNC/PARGN<n> - parent function extra arguments / extra argument count / each extra argument ######
	unset(PARGN)
	set(PARGNC 0)
	foreach(arg IN LISTS ARGN)
		set(PARGN${PARGNC} ${arg})
		list(APPEND PARGN ${arg})
		math(EXPR PARGNC "${PARGNC}+1")
	endforeach()
	set(__ARGN__  "${PARGN}"                           CACHE INTERNAL "")
	set(__ARGNC__ "${PARGNC}"                          CACHE INTERNAL "")

	set(__FILE__ "${CMAKE_CURRENT_FUNCTION_LIST_FILE}" CACHE INTERNAL "")
    get_filename_component(__FILE__ "${__FILE__}" NAME CACHE INTERNAL "")
	set(__LINE__ "${CMAKE_CURRENT_FUNCTION_LIST_LINE}" CACHE INTERNAL "")
	set(__FUNCTION__ "${CMAKE_CURRENT_FUNCTION}"       CACHE INTERNAL "")
	
	#set(__WATCH_FUNCTION__ "${CMAKE_CURRENT_FUNCTION}")
	#variable_watch(__WATCH_FUNCTION__  dk_onCallstack)
    
	### Check Argument Count ###
	if("${argc}" STREQUAL "1")
		if(${PARGC} LESS ${argv0})
			dk_fatal("${__FUNCTION__}(${PARGV}) requires at least ${argv0} argments: got ${PARGC}")
		elseif(${PARGC} GREATER ${argv0})
			dk_fatal("${__FUNCTION__}(${PARGV}) takes ${argv0} argments max: got ${PARGC}")
		endif()
	elseif("${argc}" STREQUAL "2")
		if(${PARGC} LESS ${argv0})
			dk_fatal("${__FUNCTION__}(${PARGV}) requires at least ${argv0} argments: got ${PARGC}")
		elseif(${PARGC} GREATER ${argv1})
			dk_fatal("${__FUNCTION__}(${PARGV}) takes ${argv1} argments max: got ${PARGC}")
		endif()
	endif()
    
	list(GET STACK_LEVEL 0 __LEVEL__)
	set(__LEVEL__     ${__LEVEL__}                     CACHE INTERNAL "")
	
	string(TIMESTAMP __TIME__ "%M:%S:%f")
	string(SUBSTRING "${__TIME__}" 0 10 __TIME__)
	set(__TIME__      ${__TIME__}                      CACHE INTERNAL "")
	
	if(ENABLE_dk_debugFunc)	
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

		if(PARGV)
			string(STRIP "${PARGV}" PARGV)
			string(REPLACE ";" "', '" PARGV "${PARGV}")
		endif()
		#message("${cyan}[${__TIME__}]${indent}${__FILE__}:${__LINE__}  ${blue}${__FUNCTION__}('${PARGV}')${clr}")
		message("${cyan}[${__TIME__}]${indent}${blue}${__FUNCTION__}('${PARGV}')${clr}")
	endif()
endmacro()