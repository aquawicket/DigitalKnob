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
# dk_cacheVariable(varname [set]))
#
#
function(dk_cacheVariable)
	dk_debugFunc(1 99)
	
	dk_validate(DKCACHE_DIR "dk_DKCACHE_DIR()")
	set(DKCACHE_file "${DKCACHE_DIR}/DKCACHE")

	dk_fileVariable("${DKCACHE_file}" ${ARGV})
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	#dk_cacheVariable(TEST_VAR "value of Test_var variable")
	#dk_cacheVariable(TEST_VAR "value of Test_var variable")
	#dk_cacheVariable(TEST_VAR "value of Test_var variable2")
	#dk_cacheVariable(ABC "123")
	#dk_cacheVariable(TEST_VAR "value of Test_var variable")
	#dk_cacheVariable(ABC "123")
	
	#set(PATH_TMP $ENV{PATH})
	#dk_cacheVariable(PATH $ENV{PATH})
	dk_cacheVariable(cmake.exe $ENV{PATH})
endfunction()