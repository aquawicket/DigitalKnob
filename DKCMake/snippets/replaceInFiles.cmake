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



set(myPath "C:/Users/Administrator/DigitalKnob/Development/DKPowershell/functions")
dk_getFiles("${myPath}")

foreach(file ${dk_getFiles})
	#dk_echo("file = ${file}")
	dk_basename("${file}" func)
	dk_replaceAll("${func}" ".ps1" "" func)
	#dk_echo("func = ${func}")
	dk_fileReplace("${file}" "#TODO #include guard" "if(!\$${func}){ \$${func} = 1 } else{ return } #include guard")
	#dk_echo("if(!\$${func}){ \$${func} = 1 } else{ return } #include guard")
endforeach()