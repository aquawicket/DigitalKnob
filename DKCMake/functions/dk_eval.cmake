include_guard()

###############################################################################
# dk_eval(code)
#
# 	evals the specified cmake code.
# 	WARNING: there is no way to set(<var> <value> PARENT_SCOPE) because of the extra function scope defined by eval.
# 	WARNING: allowing eval can of course be dangerous.
#
function(dk_eval code)
	# one file per execution of cmake (if this file were in memory it would probably be faster...)
	# this is where the temporary eval file will be stored.  it will only be used once per eval
	# and since cmake is not multihreaded no race conditions should occure.  however if you start 
	# two cmake processes in the same project this could lead to collisions
	set(evalFile "${CMAKE_CURRENT_BINARY_DIR}/evalTemp.cmake")

	# write the content of temp file and include it directly, this overwrite the 
	# eval function you are currently defining (initializer function pattern)
	file(WRITE "${evalFile}" "function(dk_eval code)\n	file(WRITE ${evalFile} \"\${code}\")\n	include(${evalFile})\nendfunction()")
	include("${evalFile}")
	## now eval is defined as what was just written into evalFile

	## since we are still in first definition we just need to execute eval now
	## (which calls the second definition of eval).
	eval("${code}")
endfunction()
