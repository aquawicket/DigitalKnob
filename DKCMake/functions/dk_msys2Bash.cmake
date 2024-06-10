include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

###############################################################################
# dk_msys2Bash(args) NO_HALT
#
#	TODO
#
#	@args	- TODO
#
function(dk_msys2Bash)
	dk_debugFunc(${ARGV})
	
	DK_ASSERT(MINGW)
	DK_ASSERT(MSYSTEM)
	DK_ASSERT(MSYS2)
	dk_getOption(NO_HALT ${ARGV})
	dk_getOption(NOECHO ${ARGV})
	dk_getOptionValue(OUTPUT_VARIABLE ${ARGV})
	set(EXTRA_ARGS "")
	
	if(OUTPUT_VARIABLE)
		list(APPEND EXTRA_ARGS OUTPUT_VARIABLE ${OUTPUT_VARIABLE})
	endif()
	
	if(NOT ${NOECHO})
		string(REPLACE ";" " " ARGV_STRING "${ARGV}")
		dk_info("\n${clr}${magenta} dk_msys2Bash> ${ARGV_STRING}\n")
	endif()

	set(bash "#!/bin/bash")
	list(APPEND bash "cd ${CURRENT_DIR}")
	if("${MSYSTEM}" STREQUAL "CLANG32")
		list(APPEND bash "export PATH=${MSYS2}/clang32/bin:$PATH")
	elseif("${MSYSTEM}" STREQUAL "CLANG64")
		list(APPEND bash "export PATH=${MSYS2}/clang64/bin:$PATH")
	elseif("${MSYSTEM}" STREQUAL "CLANGARM64")
		list(APPEND bash "export PATH=${MSYS2}/clangarm64/bin:$PATH")
	elseif("${MSYSTEM}" STREQUAL "MINGW32")
		list(APPEND bash "export PATH=${MSYS2}/mingw32/bin:$PATH")
	elseif("${MSYSTEM}" STREQUAL "MINGW64")
		list(APPEND bash "export PATH=${MSYS2}/mingw64/bin:$PATH")
	elseif("${MSYSTEM}" STREQUAL "UCRT64")
		list(APPEND bash "export PATH=${MSYS2}/ucrt64/bin:$PATH")
	else()
		dk_error("dk_msys2Bash(): ERROR: not CLANG32, CLANG64, CLANGARM64, MINGW32, MINGW64 or UCRT64")
	endif()
		
	list(APPEND bash "export PATH=${MSYS2}/usr/bin:$PATH")
	
	string(REPLACE ";" " "	ARGV "${ARGV}")
	list(APPEND bash "${ARGV}")
	
	list(APPEND bash "exit")
	list(APPEND bash " ")
	string(REPLACE ";" "\n"	bash "${bash}")
	string(REPLACE "${CMAKE_GENERATOR}" "'${CMAKE_GENERATOR}'" bash "${bash}")
	string(REPLACE "C:/" "/c/" bash "${bash}")
	
	### run bash as a file
	#file(WRITE ${MSYS2}/dkscript.tmp ${bash})
	#dk_executeProcess(${MSYS2}/usr/bin/bash ${MSYS2}/dkscript.tmp NOECHO)	
	
	### run bash as a string parameter
	#dk_info("\n${clr}${magenta} dk_msys2Bash> ${bash}\n")
	dk_executeProcess(${MSYS2}/usr/bin/bash -c "${bash}" ${EXTRA_ARGS} ${NO_HALT} NOECHO)
	
	if(OUTPUT_VARIABLE)
		set(${OUTPUT_VARIABLE} ${${OUTPUT_VARIABLE}} PARENT_SCOPE)
	endif()
endfunction()
dk_createOsMacros("dk_msys2Bash")