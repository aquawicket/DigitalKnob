#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

###############################################################################
# dk_eval(code)
#
# 	evals the specified cmake code.
# 	WARNING: there is no way to set(<var> <value> PARENT_SCOPE) because of the extra function scope defined by eval.
#
macro(dk_eval)
	#dk_debugFunc()
<<<<<<< HEAD
	set(code "${ARGV}")
	message("${lblue}dk_eval> ${lcyan}${code}\n ${clr}")
	
	#dk_replaceAll("${code}"  ";"  "\n"  code)
	#dk_replaceAll("${code}"  "'"  "\""  code)
	
	#dk_printVar(code)
	if(COMMAND cmake_language)
		#dk_printVar(code)
=======
	
	set(code "${ARGV}")
	message("${lblue}dk_eval> ${lcyan}${code}\n ${clr}")

	#dk_replaceAll("${code}"  ";"  "\n"  code)
	#dk_replaceAll("${code}"  "'"  "\""  code)
	
	if(COMMAND cmake_language)
>>>>>>> Development
		cmake_language(EVAL CODE ${code})
	else()
		# Evaluate expression (faster version)
		# Suggestion from the Wiki: http://cmake.org/Wiki/CMake/Language_Syntax
		# Unfortunately, no built-in stuff for this: http://public.kitware.com/Bug/view.php?id=4034
		# eval will not modify ans (the code evaluated may modify ans)
		# vars starting with __eval should not be used in code

<<<<<<< HEAD
		# one file per execution of cmake (if this file were in memory it would probably be faster...)
		#fwrite_temp("" ".cmake")
		#ans(dk_evel_temp)
		# speedup: statically write filename so eval boils down to 3 function calls
		dk_validate(DKCACHE_DIR "dk_DKHOME_DIR()")
		set(dk_evel_temp ${DKCACHE_DIR}/dk_evel_temp.cmake)
=======
		dk_validate(ENV{DKCACHE_DIR} "dk_DKCACHE_DIR()")
		set(dk_evel_temp $ENV{DKCACHE_DIR}/dk_evel_temp.cmake)
>>>>>>> Development
		dk_fileWrite("${dk_evel_temp}" "
			function(eval code)
			dk_fileWrite(${dk_evel_temp} \"\${code}\")
			dk_load(${dk_evel_temp})
			#set(__ans \${__ans} PARENT_SCOPE)
			endfunction()
		")
<<<<<<< HEAD
		#include("${dk_evel_temp}")
=======
>>>>>>> Development
		dk_load("${dk_evel_temp}")
		eval("${code}")
	endif()
endmacro()


<<<<<<< HEAD
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
=======


>>>>>>> Development




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()

	set(test "test")
	dk_eval([[message("test = ${test}")]])
=======
	dk_debugFunc(0)

	set(test "test")
	dk_eval([[  message("test = ${test}")   ]])
>>>>>>> Development
endfunction()
