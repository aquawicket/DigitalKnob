#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	file(TO_CMAKE_PATH "$ENV{USERPROFILE}$ENV{HOME}/digitalknob/Development/DKCMake/functions" DKCMAKE_FUNCTIONS_DIR)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "$ENV{DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()



set(myPath "C:/Users/Administrator/digitalknob/Development/DKPowershell/functions")
dk_getFiles("${myPath}")

foreach(file ${dk_getFiles})
	#dk_echo("file = ${file}")
	dk_basename("${file}" func)
	dk_replaceAll("${func}" ".ps1" "" func)
	#dk_echo("func = ${func}")
	dk_fileReplace("${file}" "#TODO #include guard" "if(!\$${func}){ \$${func} = 1 } else{ return } #include guard")
	#dk_echo("if(!\$${func}){ \$${func} = 1 } else{ return } #include guard")
endforeach()