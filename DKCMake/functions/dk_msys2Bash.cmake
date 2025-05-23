#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_msys2Bash(args) NO_HALT
#
#	TODO
#
#	@args	- TODO
#
function(dk_msys2Bash)
	dk_debugFunc()
	
	dk_assertVar(MINGW)
	dk_assertVar(MSYSTEM)
	dk_assertVar(MSYS2)
	
	dk_getOption(NO_HALT)
	dk_getOption(NOECHO)
	dk_getOptionValue(OUTPUT_VARIABLE)
	
	set(EXTRA_ARGS "")
	
	if(OUTPUT_VARIABLE)
		list(APPEND EXTRA_ARGS OUTPUT_VARIABLE ${OUTPUT_VARIABLE})
	endif()
	
	if(NOT ${NOECHO})
		dk_replaceAll("${ARGV}" ";" " " ARGV_STRING)
		dk_info("\n${clr}${magenta} dk_msys2Bash> ${ARGV_STRING}\n")
	endif()

	set(bash "#!/bin/bash")
	list(APPEND bash "cd ${PWD}")
	if(win_x86_clang)
		list(APPEND bash "export PATH=${MSYS2_DIR}/clang32/bin:$PATH")
	elseif(win_x86_64_clang)	
		list(APPEND bash "export PATH=${MSYS2_DIR}/clang64/bin:$PATH")
	elseif(win_arm64_clang)
		list(APPEND bash "export PATH=${MSYS2_DIR}/clangarm64/bin:$PATH")
	elseif(win_x86_gcc)
		list(APPEND bash "export PATH=${MSYS2_DIR}/mingw32/bin:$PATH")
	elseif(win_x86_64_gcc)
		list(APPEND bash "export PATH=${MSYS2_DIR}/mingw64/bin:$PATH")
	elseif(win_x86_64_ucrt)
		list(APPEND bash "export PATH=${MSYS2_DIR}/ucrt64/bin:$PATH")
	else()
		dk_fatal("dk_msys2Bash(): ERROR: not CLANG32, CLANG64, CLANGARM64, MINGW32, MINGW64 or UCRT64")
	endif()
		
	list(APPEND bash "export PATH=${MSYS2_DIR}/usr/bin:$PATH")
	
	dk_replaceAll("${ARGV}"  ";"  " "	ARGV)
	list(APPEND bash "${ARGV}")
	
	list(APPEND bash "exit")
	list(APPEND bash " ")
	dk_replaceAll("${bash}"  ";"  "\n"	bash)
	dk_replaceAll("${bash}" "${CMAKE_GENERATOR}" "'${CMAKE_GENERATOR}'" bash)
	dk_replaceAll("${bash}"  "C:/"  "/c/"  bash)
	
	### run bash as a file
	#dk_fileWrite($ENV{DKCACHE_DIR}/dkscript.tmp ${bash})
	#dk_exec(${MSYS2_DIR}/usr/bin/bash $ENV{DKCACHE_DIR}/dkscript.tmp NOECHO)	
	
	### run bash as a string parameter
	#dk_info("\n${clr}${magenta} dk_msys2Bash> ${bash}\n")
	dk_exec(${MSYS2_DIR}/usr/bin/bash -c "${bash}" ${EXTRA_ARGS} ${NO_HALT} NOECHO)
	
	if(OUTPUT_VARIABLE)
		set(${OUTPUT_VARIABLE} ${${OUTPUT_VARIABLE}} PARENT_SCOPE)
	endif()
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_msys2Bash(todo) # TODO
endfunction()