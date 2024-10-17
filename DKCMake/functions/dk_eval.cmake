#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_eval(code)
#
# 	evals the specified cmake code.
# 	WARNING: there is no way to set(<var> <value> PARENT_SCOPE) because of the extra function scope defined by eval.
#
function(dk_eval code)
	#dk_debugFunc()
	
	dk_replaceAll("${code}"  ";"  "\n"  code)
	dk_replaceAll("${code}"  "'"  "\""  code)
	#dk_replaceAll("${code}"  "/c/"  "C:/" code)
	#dk_printVar(code)
	if(COMMAND cmake_language)
		#dk_printVar(code)
		cmake_language(EVAL CODE "${code}")
	else()
		# Evaluate expression (faster version)
		# Suggestion from the Wiki: http://cmake.org/Wiki/CMake/Language_Syntax
		# Unfortunately, no built-in stuff for this: http://public.kitware.com/Bug/view.php?id=4034
		# eval will not modify ans (the code evaluated may modify ans)
		# vars starting with __eval should not be used in code

		# one file per execution of cmake (if this file were in memory it would probably be faster...)
		#fwrite_temp("" ".cmake")
		#ans(__eval_temp_file)
		# speedup: statically write filename so eval boils down to 3 function calls
		dk_validate(DKCACHE_DIR "dk_DKHOME_DIR()")
		set(__eval_temp_file ${DKCACHE_DIR}/__eval_temp_file.cmake)
		dk_fileWrite("${__eval_temp_file}" "
			function(eval code)
			dk_fileWrite(${__eval_temp_file} \"\${code}\")
			#include(${__eval_temp_file})
			dk_load(${__eval_temp_file})
			#set(__ans \${__ans} PARENT_SCOPE)
			endfunction()
		")
		#include("${__eval_temp_file}")
		dk_load("${__eval_temp_file}")
		eval("${code}")
	endif()
endfunction()


#function(dk_eval code)
#	# one file per execution of cmake (if this file were in memory it would probably be faster...)
#	# this is where the temporary eval file will be stored.  it will only be used once per eval
#	# and since cmake is not multihreaded no race conditions should occure.  however if you start 
#	# two cmake processes in the same project this could lead to collisions
#	set(evalFile "${CMAKE_CURRENT_BINARY_DIR}/evalTemp.cmake")
#
#	# write the content of temp file and include it directly, this overwrite the 
#	# eval function you are currently defining (initializer function pattern)
#	dk_fileWrite("${evalFile}" "function(dk_eval code)\n	dk_fileWrite(${evalFile} \"\${code}\")\n	include(${evalFile})\nendfunction()")
#	include("${evalFile}")
#	## now eval is defined as what was just written into evalFile
#
#	## since we are still in first definition we just need to execute eval now
#	## (which calls the second definition of eval).
#	eval("${code}")
#endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()

	dk_todo()
endfunction()
