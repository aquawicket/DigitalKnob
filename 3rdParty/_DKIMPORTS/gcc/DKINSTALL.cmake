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


############ gcc ############
# https://packages.msys2.org/package/mingw-w64-x86_64-gcc?repo=mingw64
dk_validate(Host_Tuple			"dk_Host_Tuple()")
dk_validate(Target_Tuple		"dk_Target_Tuple()")
dk_set(${Target_Tuple}			1)

##dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
if(MSYSTEM)
	dk_depend(msys2)
endif()
dk_installPackage(gcc)


if(Linux_Host)
	if(EXISTS /usr/bin/gcc)
		dk_set(GCC_C_COMPILER	/usr/bin/gcc)
	elseif(EXISTS /usr/local/bin/gcc)
		dk_set(GCC_C_COMPILER	/usr/local/bin/gcc)
	endif()

	if(EXISTS /usr/bin/g++)
		dk_set(GCC_CXX_COMPILER	/usr/bin/g++)
	elseif(EXISTS /usr/local/bin/g++)
		dk_set(GCC_CXX_COMPILER	/usr/local/bin/g++)
	endif()
elseif(Windows_Arm64_Clang)
	dk_validate(MSYS2 			"dk_depend(msys2)")
	dk_set(GCC_C_COMPILER   	"${MSYS2}/clangarm64/bin/gcc.exe")
	dk_set(GCC_CXX_COMPILER 	"${MSYS2}/clangarm64/bin/g++.exe")
	dk_set(GCC_RC_COMPILER  	"${MSYS2}/clangarm64/bin/windres.exe")	# TODO:  move to DKIMPORTS/windres
elseif(Windows_X86_Clang)
	dk_validate(MSYS2 			"dk_depend(msys2)")
	dk_set(GCC_C_COMPILER   	"${MSYS2}/clang32/bin/gcc.exe")
	dk_set(GCC_CXX_COMPILER 	"${MSYS2}/clang32/bin/g++.exe")
	dk_set(GCC_RC_COMPILER  	"${MSYS2}/clang32/bin/windres.exe")
elseif(Windows_X86_64_Clang)
	dk_validate(MSYS2 			"dk_depend(msys2)")
	dk_set(GCC_C_COMPILER   	"${MSYS2}/clang64/bin/gcc.exe")
	dk_set(GCC_CXX_COMPILER 	"${MSYS2}/clang64/bin/g++.exe")
	dk_set(GCC_RC_COMPILER  	"${MSYS2}/clang64/bin/windres.exe")
elseif(Windows_X86_Gcc)
	dk_validate(MSYS2 			"dk_depend(msys2)")
	dk_set(GCC_C_COMPILER   	"${MSYS2}/mingw32/bin/gcc.exe")
	dk_set(GCC_CXX_COMPILER		"${MSYS2}/mingw32/bin/g++.exe")
	dk_set(GCC_RC_COMPILER  	"${MSYS2}/mingw32/bin/windres.exe")
elseif(Windows_X86_64_Gcc)
	dk_validate(MSYS2 			"dk_depend(msys2)")
	dk_set(GCC_C_COMPILER   	"${MSYS2}/mingw64/bin/gcc.exe")
	dk_set(GCC_CXX_COMPILER 	"${MSYS2}/mingw64/bin/g++.exe")
	dk_set(GCC_RC_COMPILER  	"${MSYS2}/mingw64/bin/windres.exe")
elseif(Windows_X86_64_Ucrt)
	dk_validate(MSYS2 			"dk_depend(msys2)")
	dk_set(GCC_C_COMPILER   	"${MSYS2}/ucrt64/bin/gcc.exe")
	dk_set(GCC_CXX_COMPILER 	"${MSYS2}/ucrt64/bin/g++.exe")
	dk_set(GCC_RC_COMPILER  	"${MSYS2}/ucrt64/bin/windres.exe")
endif()



###### set GLOBAL CMAKE VARIABLES ######
#if(NOT CMAKE_C_COMPILER)
#	dk_set(CMAKE_C_COMPILER		${GCC_C_COMPILER})
#endif()
#if(NOT CMAKE_CXX_COMPILER)
#	dk_set(CMAKE_CXX_COMPILER	${GCC_CXX_COMPILER})
#endif()
#dk_set(CMAKE_RC_COMPILER	${GCC_RC_COMPILER})			# TODO:  move to DKIMPORTS/windres
#
#dk_set(DKCONFIGURE_CC		${CMAKE_C_COMPILER})
#dk_set(DKCONFIGURE_CXX		${CMAKE_CXX_COMPILER})
