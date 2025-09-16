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


############ tbb ############
# https://packages.msys2.org/package/mingw-w64-x86_64-tbb
dk_validate(Host_Tuple		"dk_Host_Tuple()")
dk_validate(Target_Tuple	"dk_Target_Tuple()")
dk_set(${Target_Tuple} 		1)

##dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
if(MSYSTEM)
	dk_depend(msys2)
endif()
dk_installPackage(tbb)




# MSYS2 (-ltbb)
if(MSYSTEM)
	dk_set(TBB_CMAKE "-DCMAKE_EXE_LINKER_FLAGS=-ltbb")
endif()
	
