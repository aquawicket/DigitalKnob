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


#########################################################################
# dk_fileVariable(file varname [set])
#
# todo: add optional 3rd parameter for output value
function(dk_fileVariable _file_ _varname_)
	dk_debugFunc(2 99)
    
	set(_file_ 		${ARGV0})
	set(_varname_ 	${ARGV1})
	string(REPLACE ";" "\;" _set_ "${ARGN}")
	
	### SET ###
	if(DEFINED ARGV2)
		if(NOT "${_set_}" STREQUAL "")
			dk_fileContains("${_file_}" "${_varname_}=")
			if(${dk_fileContains})
				dk_fileReplaceMatchLine("${_file_}" "${_varname_}=" "${_varname_}=${_set_}")
			else()
				dk_fileAppend("${_file_}" "${_varname_}=${_set_}\n")
			endif()
		else()
			dk_fileContains("${_file_}" "${_varname_}=")
			if(${dk_fileContains})
				dk_fileReplaceMatchLine("${_file_}" "${_varname_}=" "")
			endif()
		endif()
		set(${_varname_} ${_set_} PARENT_SCOPE)	
	
	### GET ###
	else()
		if(EXISTS "${_file_}")
			file(READ "${_file_}" file_content)
			string(REPLACE ";" "\;" file_content "${file_content}")
			string(REGEX REPLACE "\n" ";" file_content_list "${file_content}")
			foreach(line IN LISTS file_content_list)
				string(FIND "${line}" "=" pos)
				if(pos GREATER -1)
					string(SUBSTRING "${line}" 0 ${pos} A)
					math(EXPR pos "${pos}+1" OUTPUT_FORMAT DECIMAL) 
					string(SUBSTRING "${line}" ${pos} -1 B)
					if("${A}" STREQUAL "${ARGV1}")
						unset("${ARGV1}")
						set(${A} "${B}" PARENT_SCOPE)
						return()
					endif()
				endif()
			endforeach()
		else()
			dk_warning("_file_:${_file_} NOT FOUND")
		endif()
	endif()
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc(0)
  
	### SET
	dk_validate(DKCACHE_DIR "dk_DKCACHE_DIR()")
	dk_fileVariable("${DKCACHE_DIR}/DKCACHE" PATH_TEST $ENV{PATH})

	### GET
	unset(PATH_TEST)
	dk_fileVariable("${DKCACHE_DIR}/DKCACHE" PATH_TEST)
	dk_debug("PATH_TEST = ${PATH_TEST}")

	dk_validate(DKCACHE_DIR "dk_DKCACHE_DIR()")
	set(file "${DKCACHE_DIR}/dk_fileVariable_TEST.txt")
	
	###### SET ######
	message("")
	dk_fileVariable("${file}" one "a b c")
	if("${one}" STREQUAL "a b c")
		dk_success("one = '${one}'")
	else()
		dk_error("one = '${one}'")
	endif()
	unset(one)
	
	###### SET ######
	message("")
	dk_fileVariable("${file}" two "d e f")
	if("${two}" STREQUAL "d e f")
		dk_success("two = '${two}'")
	else()
		dk_error("two = '${two}'")
	endif()
	unset(two)
	
	###### SET ######
	message("")
	dk_fileVariable("${file}" three "g h i")
	if("${three}" STREQUAL "g h i")
		dk_success("three = '${three}'")
	else()
		dk_error("three = '${three}'")
	endif()
	unset(three)
	
	###### GET ######
	message("")
	dk_fileVariable("${file}" one)
	if("${one}" STREQUAL "a b c")
		dk_success("one = '${one}'")
	else()
		dk_error("one = '${one}'")
	endif()
	unset(one)
	
	###### GET ######
	message("")
	dk_fileVariable("${file}" two)
	if("${two}" STREQUAL "d e f")
		dk_success("two = '${two}'")
	else()
		dk_error("two = '${two}'")
	endif()
	unset(two)
	
	###### GET ######
	message("")
	dk_fileVariable("${file}" three)
	if("${three}" STREQUAL "g h i")
		dk_success("three = '${three}'")
	else()
		dk_error("three = '${three}'")
	endif()
	unset(three)
	
	###### SET ######
	message("")
	dk_fileVariable("${file}" two "x y z")
	if("${two}" STREQUAL "x y z")
		dk_success("two = '${two}'")
	else()
		dk_error("two = '${two}'")
	endif()
	unset(two)
	
	###### GET ######
	message("")
	dk_fileVariable("${file}" two)
	if("${two}" STREQUAL "x y z")
		dk_success("two = '${two}'")
	else()
		dk_error("two = '${two}'")
	endif()
	unset(two)
	
	###### SET ######
	message("")
	dk_fileVariable("${file}" one " ")
	if("${one}" STREQUAL " ")
		dk_success("one = '${one}'")
	else()
		dk_error("one = '${one}'")
	endif()
	unset(one)
	
	###### GET ######
	message("")
	dk_fileVariable("${file}" one)
	if("${one}" STREQUAL " ")
		dk_success("one = '${one}'")
	else()
		dk_error("one = '${one}'")
	endif()
	unset(one)
	
	###### SET ######
	message("")
	dk_fileVariable("${file}" two "")
	if("${two}" STREQUAL "")
		dk_success("two = '${two}'")
	else()
		dk_error("two = '${two}'")
	endif()
	unset(two)
	
	###### GET ######
	message("")
	dk_fileVariable("${file}" two)
	if("${two}" STREQUAL "")
		dk_success("two = '${two}'")
	else()
		dk_error("two = '${two}'")
	endif()
	unset(two)
	
	###### SET ######
	message("")
	dk_fileVariable("${file}" three nul)
	if("${three}" STREQUAL "nul")
		dk_success("three = '${three}'")
	else()
		dk_error("three = '${three}'")
	endif()
	unset(three)
	
	###### GET ######
	message("")
	dk_fileVariable("${file}" three)
	if("${three}" STREQUAL "nul")
		dk_success("three = '${three}'")
	else()
		dk_error("three = '${three}'")
	endif()
	unset(three)
	
	###### GET ######
	message("")
	dk_fileVariable("${file}" four)
	if("${four}" STREQUAL "")
		dk_success("four = '${four}'")
	else()
		dk_error("four = '${four}'")
	endif()
	unset(four)
	
	#dk_fileTrim("${file}")
endfunction()
