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


################## dk_fileVariables settings ###################################
set(dk_fileVariables_PRINT_VARIABLES 1)
#########################################################################
# dk_fileVariables(file)
#
function(dk_fileVariables)
    dk_debugFunc(1)
    
	set(_file_ "${ARGV0}")
	
	file(READ "${_file_}" file_content)
	string(REGEX REPLACE "\n" ";" file_content_list "${file_content}")
	
	if("${dk_fileVariables_PRINT_VARIABLES}" EQUAL 1)
		message("### ${_file_} Parameters ###")
	endif()
				
	# iterate through each line
	foreach(line IN LISTS file_content_list)
		# remove comments - everything after # 
		string(FIND "${line}" "#" comment)
		if(comment GREATER -1)
			string(SUBSTRING "${line}" 0 ${comment} line)	
		endif()
		
		string(FIND "${line}" "=" pos)
		if(pos GREATER -1)
			string(SUBSTRING "${line}" 0 ${pos} varname)
			math(EXPR pos "${pos}+1" OUTPUT_FORMAT DECIMAL) 
			string(SUBSTRING "${line}" ${pos} -1 value)
			
				# Evaluate varname and value to expand any variables
				
				#string(REPLACE "\$" "\$ENV" value "${value}") # Channge ${value} to $ENV{value}
				# cmake_language(EVAL CODE set(value "${value}"))
				
				cmake_language(EVAL CODE "set(varname \"${varname}\")")
				cmake_language(EVAL CODE "set(value \"${value}\")")
				
				if(varname)
					string(STRIP ${varname} varname)
				endif()
				if(value)
					string(REPLACE "\\" "/" value "${value}")
					string(STRIP ${value} value)
				endif()
				
				set(${varname} "${value}" CACHE INTERNAL "" FORCE)
				
				if("${dk_fileVariables_PRINT_VARIABLES}" EQUAL 1)
					dk_call(dk_debug("'${varname}' = '${${varname}}'"))
				endif()
		endif()
	endforeach()
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc(0)
  
	dk_validate(DKCACHE_DIR "dk_DKCACHE_DIR()")
	dk_fileWrite("${DKCACHE_DIR}/dk_fileVariables_TEST.txt"		"### dk_fileVariables TEST ###\n")
	dk_fileAppend("${DKCACHE_DIR}/dk_fileVariables_TEST.txt"	"varA=Value_of_varA\n")
	dk_fileAppend("${DKCACHE_DIR}/dk_fileVariables_TEST.txt"	"varB=Value_of_varB_with_trailing_comment 	# with trailing comment\n")
	dk_fileAppend("${DKCACHE_DIR}/dk_fileVariables_TEST.txt"	"varC=Value of varC with spaces\n")
	dk_fileAppend("${DKCACHE_DIR}/dk_fileVariables_TEST.txt"	" varD=Value of varD padded with spaces \n")
	#dk_fileAppend("${DKCACHE_DIR}/dk_fileVariables_TEST.txt"	"varE=\"Value of varE with value enclosed inquotes\"\n")
	#dk_fileAppend("${DKCACHE_DIR}/dk_fileVariables_TEST.txt"	"\"varF\"=Value of varF with varname enclosed in quotes\n")
	#dk_fileAppend("${DKCACHE_DIR}/dk_fileVariables_TEST.txt"	"\"varG=Value of varG with line enclosed in quotes\"\n")
	dk_fileAppend("${DKCACHE_DIR}/dk_fileVariables_TEST.txt"	"varH=Value of varH\n")
	dk_fileAppend("${DKCACHE_DIR}/dk_fileVariables_TEST.txt"	"varI=\${varH}\n")
	dk_fileAppend("${DKCACHE_DIR}/dk_fileVariables_TEST.txt"	"varJ=varK\n")
	dk_fileAppend("${DKCACHE_DIR}/dk_fileVariables_TEST.txt"	"\${varJ}=Value of varK\n")
	dk_fileAppend("${DKCACHE_DIR}/dk_fileVariables_TEST.txt"	"#varL=Value of varL Commented\n")
	dk_fileAppend("${DKCACHE_DIR}/dk_fileVariables_TEST.txt"	"ComSpec=\$ENV{ComSpec}\n")
	dk_fileAppend("${DKCACHE_DIR}/dk_fileVariables_TEST.txt"	"USERPROFILE=\$ENV{USERPROFILE}\n")
	dk_fileAppend("${DKCACHE_DIR}/dk_fileVariables_TEST.txt"	"SHELL=\$ENV{SHELL}\n")
	dk_fileAppend("${DKCACHE_DIR}/dk_fileVariables_TEST.txt"	"HOME=\$ENV{HOME}\n")
	
	
	dk_debug("Testing dk_fileVariables.cmake")
	set(dk_fileVariables_PRINT_VARIABLES 1)
    dk_fileVariables("${DKCACHE_DIR}/dk_fileVariables_TEST.txt")
endfunction()
