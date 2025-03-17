#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_eval(code)
#
# 	evals the specified cmake code.
# 	WARNING: there is no way to set(<var> <value> PARENT_SCOPE) because of the extra function scope defined by eval.
#
macro(dk_eval)
	#dk_debugFunc()
	
	set(code "${ARGV}")
	message("${lblue}dk_eval> ${lcyan}${code}\n ${clr}")

	#dk_replaceAll("${code}"  ";"  "\n"  code)
	#dk_replaceAll("${code}"  "'"  "\""  code)
	
	if(COMMAND cmake_language)
		cmake_language(EVAL CODE ${code})
	else()
		# Evaluate expression (faster version)
		# Suggestion from the Wiki: http://cmake.org/Wiki/CMake/Language_Syntax
		# Unfortunately, no built-in stuff for this: http://public.kitware.com/Bug/view.php?id=4034
		# eval will not modify ans (the code evaluated may modify ans)
		# vars starting with __eval should not be used in code

		dk_validate(ENV{DKCACHE_DIR} "dk_DKCACHE_DIR()")
		set(dk_evel_temp $ENV{DKCACHE_DIR}/dk_evel_temp.cmake)
		dk_fileWrite("${dk_evel_temp}" "
			function(eval code)
			dk_fileWrite(${dk_evel_temp} \"\${code}\")
			dk_load(${dk_evel_temp})
			#set(__ans \${__ans} PARENT_SCOPE)
			endfunction()
		")
		dk_load("${dk_evel_temp}")
		eval("${code}")
	endif()
endmacro()








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)

	set(test "test")
	dk_eval([[  message("test = ${test}")   ]])
endfunction()
