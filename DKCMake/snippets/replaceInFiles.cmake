#!/usr/bin/cmake -P
set(DKCMAKE_FUNCTIONS_DIR_ "C:/Users/Administrator/digitalknob/Development/DKCMake/functions/")
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()



set(myPath "C:/Users/Administrator/digitalknob/Development/DKPowershell/functions")
dk_getFiles("${myPath}" files)

foreach(file ${files})
	#dk_echo("file = ${file}")
	dk_basename("${file}" func)
	dk_replaceAll("${func}" ".ps1" "" func)
	#dk_echo("func = ${func}")
	dk_fileReplace("${file}" "#TODO #include guard" "if(!\$${func}){ \$${func} = 1 } else{ return } #include guard")
	#dk_echo("if(!\$${func}){ \$${func} = 1 } else{ return } #include guard")
endforeach()