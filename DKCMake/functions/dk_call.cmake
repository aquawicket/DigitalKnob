#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


#########################################################################
# dk_call(FUNC) args
#
#	load a ${FUNC}.cmake file located in the DKCMake path and call the function with arguments
#
#	@FUNC				- The name of the .cmake function file as well as the name of the function
#	@args (optional) 	- The arguments to pass to the function
#
macro(dk_call)
	
	### dk_call() Settings ########
	if(NOT DEFINED dk_call_DEBUG)
		set(dk_call_DEBUG	0)
	endif()
	###############################
	
#	if("${PrintArgData}" STREQUAL "1")
#		message(" ")
#		message("###### dk_call() ${CMAKE_CURRENT_FUNCTION} ######")
#		set(ARGV "${ARGV}")
#		set(ARGN "${ARGN}")
#		
#		message(" ARGV = ${ARGV}")
#		set(n 0)
#		foreach(arg IN LISTS ARGV)
#			message("ARGV${n} = ${arg}")
#			math(EXPR n "${n}+1")
#		endforeach()
#		message(" ARGC = ${ARGC}")
#		
#		message(" ARGN = ${ARGN}")
#		set(ARGNC 0)
#		foreach(arg IN LISTS ARGN)
#			message("ARGV${ARGNC} = ${arg}")
#			math(EXPR ARGNC "${ARGNC}+1")
#		endforeach()
#		message("ARGNC = ${ARGNC}")
#		dk_printArgData()
#	endif()

	### CODE_LIST
	set(CODE_LIST ${ARGV})
	list(LENGTH CODE_LIST CODE_LIST_LENGTH)
#	message("CODE_LIST_LENGTH = ${CODE_LIST_LENGTH}")
	if(${CODE_LIST_LENGTH} EQUAL 1)
		string(REPLACE 	")" 	"#)#" 	CODE_LIST "${CODE_LIST}")
		string(REPLACE 	" " 	"#" 	CODE_LIST "${CODE_LIST}")
		string(REPLACE 	"(" 	"#(#" 	CODE_LIST "${CODE_LIST}")
		string(REPLACE 	"#" 	";"		CODE_LIST "${CODE_LIST}")
	endif()
	
#	list(LENGTH CODE_LIST CODE_LIST_LENGTH)
#	message("CODE_LIST_LENGTH = ${CODE_LIST_LENGTH}")

#	foreach(item IN LISTS CODE_LIST)
#		message("item = ${item}")
#	endforeach()

#	message("${lcyan}CODE_LIST = '${CODE_LIST}'${clr}")
	
	### CODE_STRING
	string(REPLACE ";" "" CODE_STRING "${CODE_LIST}")
#	message("${lcyan}CODE_STRING = '${CODE_STRING}'${clr}")
	
	### FUNC_ARGS_LIST
	set(FUNC_ARGS_LIST "${CODE_LIST}")
	list(REMOVE_ITEM FUNC_ARGS_LIST "(" ")")
#	list(TRANSFORM FUNC_ARGS_LIST REPLACE "\\]" "")
#	message("${lcyan}FUNC_ARGS_LIST = '${FUNC_ARGS_LIST}'${clr}")
	
	### FUNC_ARGS_STRING
	string(REPLACE ";" " " FUNC_ARGS_STRING "${FUNC_ARGS_LIST}")
#	message("${lcyan}FUNC_ARGS_STRING = '${FUNC_ARGS_STRING}'${clr}")
	
	### FUNC
	set(ARGS_LIST "${FUNC_ARGS_LIST}")
	list(POP_FRONT ARGS_LIST FUNC)
#	message("${lcyan}FUNC = '${FUNC}'${clr}")
	
	### ARGS_LIST
	string(REPLACE ";)" "" ARGS_LIST "${ARGS_LIST}")
#	message("${lcyan}ARGS_LIST = '${ARGS_LIST}'${clr}")
	
	### ARGS_STRING
	string(REPLACE ";" " " ARGS_STRING "${ARGS_LIST}")
#	message("${lcyan}ARGS_STRING = '${ARGS_STRING}'${clr}")

	
#	message("if(NOT COMMAND ${FUNC})")
	if(NOT COMMAND ${FUNC})
		if(NOT COMMAND dk_source)
			include("${CMAKE_CURRENT_LIST_DIR}/dk_source.cmake")
		endif()
		dk_source(${FUNC})
	endif()
	
	if(NOT COMMAND ${FUNC})
		dk_fatal("FUNC:'${FUNC}': command NOT FOUND")
	endif()
	
	if("${dk_call_DEBUG}" STREQUAL "1")
		message(${lblue}dk_call> '${lcyan}${FUNC} ${ARGS_LIST}'${clr})
	endif()
	
	#message("cmake_language(CALL "${FUNC}" ${ARGS_LIST})")
	cmake_language(CALL "${FUNC}" ${ARGS_LIST})
endmacro()


macro(dk_call2)
	dk_validateFunc(dk_eval)
		
	dk_call(${ARGV})
endmacro()



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	if(COMMAND dk_debugFunc)
		dk_debugFunc(0)
	endif()
	
	dk_call(  dk_debug(  testing dk_eval test1  )       )
	
	dk_call(  dk_debug( "testing dk_eval test2" )       )
	
	dk_call(  dk_debug(\"testing dk_eval test3\")       )
	
	dk_call(  dk_debug(  testing dk_eval test4  )       )
	
	dk_call(  dk_debug(  testing dk_eval test5 - line 1 ) "\n"
			  dk_debug(  testing dk_eval test5 - line 2 ) "\n"
			  dk_debug(  testing dk_eval test5 - line 3 ) "\n"
			  dk_debug(  testing dk_eval test5 - line 4 ) "\n"
			  dk_debug(  testing dk_eval test5 - line 5 ) 
	)
	
	dk_call(  dk_debug(  "testing dk_eval test5 - line 1" ) "\n"
			  dk_debug(  "testing dk_eval test5 - line 2" ) "\n"
			  dk_debug(  "testing dk_eval test5 - line 3" ) "\n"
			  dk_debug(  "testing dk_eval test5 - line 4" ) "\n"
			  dk_debug(  "testing dk_eval test5 - line 5" ) 
	)
	
#	dk_call(  "dk_debug(  testing dk_eval test5 - line 1 ) "\n"
#			   dk_debug(  testing dk_eval test5 - line 2 ) "\n"
#			   dk_debug(  testing dk_eval test5 - line 3 ) "\n"
#			   dk_debug(  testing dk_eval test5 - line 4 ) "\n"
#			   dk_debug(  testing dk_eval test5 - line 5 )" 
#	)
endfunction()
