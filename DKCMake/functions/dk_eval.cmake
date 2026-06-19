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
# dk_eval(code)
#
# 	evals the specified cmake code.
# 	WARNING: there is no way to set(<var> <value> PARENT_SCOPE) because of the extra function scope defined by eval.
#
macro(dk_eval)
#	if("${PrintArgData}" STREQUAL "1")
#		message(" ")
#		message("###### dk_eval() ${CMAKE_CURRENT_FUNCTION} ######")
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
	
	
	### dk_eval() Settings ########
	if(NOT DEFINED dk_eval_DEBUG)
		set(dk_eval_DEBUG	1)
	endif()
	###############################
	
	
	### CODE_LIST
	set(CODE_LIST ${ARGV})
	list(LENGTH CODE_LIST CODE_LIST_LENGTH)
#	message("CODE_LIST_LENGTH = ${CODE_LIST_LENGTH}")
	if(${CODE_LIST_LENGTH} GREATER 1)
		string(REPLACE 	";"  " " 	code "${CODE_LIST}")
	endif()
	
	### TODO:  Extract function from the args and test it against dk_source
	
	
#	set(code "${ARGV}")
	if("${dk_eval_DEBUG}" STREQUAL "1")
		message("${lblue}dk_eval> ${lcyan}${code}\n ${clr}")
	endif()
	
	
	if(COMMAND cmake_language)
		cmake_language(EVAL CODE ${code})
	else()
		# Evaluate expression (faster version)
		# Suggestion from the Wiki: http://cmake.org/Wiki/CMake/Language_Syntax
		# Unfortunately, no built-in stuff for this: http://public.kitware.com/Bug/view.php?id=4034
		# eval will not modify ans (the code evaluated may modify ans)
		# vars starting with __eval should not be used in code

		dk_validate(DKCACHE_DIR "dk_DKCACHE_DIR()")
		set(dk_evel_temp ${DKCACHE_DIR}/dk_evel_temp.cmake)
		dk_fileWrite("${dk_evel_temp}" "
			function(eval code)
			dk_fileWrite(${dk_evel_temp} \"\${code}\")
			include(${dk_evel_temp})
			#set(__ans \${__ans} PARENT_SCOPE)
			endfunction()
		")
		include("${dk_evel_temp}")
		eval("${code}")
	endif()
endmacro()








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	if(COMMAND dk_debugFunc)
		dk_debugFunc(0)
	endif()
	
	dk_eval(  dk_debug(  testing dk_eval test1  )       )
	
	dk_eval(  dk_debug( "testing dk_eval test2" )       )
	
	dk_eval(  dk_debug(\"testing dk_eval test3\")       )
	
	dk_eval(  dk_debug(  testing dk_eval test4  )       )
	
	dk_eval(  dk_debug(  testing dk_eval test5 - line 1 ) "\n"
			  dk_debug(  testing dk_eval test5 - line 2 ) "\n"
			  dk_debug(  testing dk_eval test5 - line 3 ) "\n"
			  dk_debug(  testing dk_eval test5 - line 4 ) "\n"
			  dk_debug(  testing dk_eval test5 - line 5 ) 
	)
endfunction()
