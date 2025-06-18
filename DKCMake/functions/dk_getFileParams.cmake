#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


################## dk_getFileParams settings ###################################
#	set(dk_getFileParams_PRINT_VARIABLES 1)
#########################################################################
# dk_getFileParams(file)
#
function(dk_getFileParams)
    dk_debugFunc(1)
    
	file(READ "${ARGV0}" file_content)
	string(REGEX REPLACE "\n" ";" file_content_list "${file_content}")
	
	if("${dk_getFileParams_PRINT_VARIABLES}" EQUAL 1)
		dk_debug("### ${ARGV0} Parameters ###")
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
			string(SUBSTRING "${line}" 0 ${pos} var)
			math(EXPR pos "${pos}+1" OUTPUT_FORMAT DECIMAL) 
			string(SUBSTRING "${line}" ${pos} -1 value)
			
				# Evaluate var and value to expand any variables
				cmake_language(EVAL CODE set(var ${var}))
				
				string(REPLACE "\$" "\$ENV" value "${value}") # Channge ${variable} to $ENV{variable}
				cmake_language(EVAL CODE set(value ${value}))

				set(${var} ${value})
				set(${var} "${${var}}" PARENT_SCOPE)
				if("${dk_getFileParams_PRINT_VARIABLES}" EQUAL 1)
					dk_debug("${var} = ${${var}}")
				endif()
		endif()
	endforeach()
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc(0)
  
	dk_validate(DKCACHE_DIR "dk_DKCACHE_DIR()")
	 dk_fileWrite("${DKCACHE_DIR}/dk_getFileParams_TEST.txt"	"Testing=dk_getFileParams.cmake\n")
	dk_fileAppend("${DKCACHE_DIR}/dk_getFileParams_TEST.txt"	"varA=ValueOfA\n")
	dk_fileAppend("${DKCACHE_DIR}/dk_getFileParams_TEST.txt"	"varB=ValueOfB 	# with trailing comment\n")
	dk_fileAppend("${DKCACHE_DIR}/dk_getFileParams_TEST.txt"	" varC=ValueOfC \n")
	dk_fileAppend("${DKCACHE_DIR}/dk_getFileParams_TEST.txt"	"varD = ValueOfD\n")
	dk_fileAppend("${DKCACHE_DIR}/dk_getFileParams_TEST.txt"	"#varNONE=ValueOfNONE\n")
	
	set(dk_getFileParams_PRINT_VARIABLES 1)
    dk_getFileParams("${DKCACHE_DIR}/dk_getFileParams_TEST.txt")
endfunction()
