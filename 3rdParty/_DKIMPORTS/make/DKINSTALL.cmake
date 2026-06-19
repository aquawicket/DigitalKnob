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


############ make #############
# https://packages.msys2.org/base/make

if((NOT DKUPDATE) AND (EXISTS "${CMAKE_MAKE_PROGRAM}"))
	dk_notice("CMAKE_MAKE_PROGRAM:'${CMAKE_MAKE_PROGRAM}' is already set.")
	dk_return()
endif()


if(Android)
	if(Windows_Host)
		dk_validate(android-ndk "dk_depend(android-ndk)")
		dk_set(CMAKE_MAKE_PROGRAM	"${android-ndk}/prebuilt/${Android_Host_Tag}/bin/make${exe}")
	endif()
	
elseif(Cosmopolitan)
	if(Windows_Host)
		dk_validate(msys2 "dk_depend(msys2)")
		dk_installPackage(make)
		dk_cacheVariable(PATH "${msys2}/usr/bin;$ENV{PATH}")
		dk_set(CMAKE_MAKE_PROGRAM "${msys2}/usr/bin/make.exe")
	endif()
	
elseif(Emscripten)
	if(Windows_Host)
		dk_validate(msys2 "dk_depend(msys2)")
		dk_installPackage(make)
		dk_set(CMAKE_MAKE_PROGRAM "${msys2}/usr/bin/make.exe")
	elseif(Linux_Host)
		dk_set(CMAKE_MAKE_PROGRAM	make)
	else()
		dk_depend(emsdk)
		dk_set(CMAKE_MAKE_PROGRAM	"${emsdk}/upstream/emscripten/emmake${bat}")
	endif()
	
elseif(Windows_Arm64_Clang)
	dk_validate(msys2 "dk_depend(msys2)")
	dk_installPackage("make")
	dk_set(CMAKE_MAKE_PROGRAM	"${msys2}/clangarm64/bin/mingw32-make.exe")
	
elseif(Windows_X86_Clang)
	dk_validate(msys2 "dk_depend(msys2)")
	dk_installPackage("make")
	dk_set(CMAKE_MAKE_PROGRAM	"${msys2}/clang32/bin/mingw32-make.exe")
	
elseif(Windows_X86_64_Clang)
	dk_validate(msys2 "dk_depend(msys2)")
	dk_installPackage("make")
	dk_set(CMAKE_MAKE_PROGRAM	"${msys2}/clang64/bin/mingw32-make.exe")	

elseif(Windows_X86_Gcc)
	dk_validate(msys2 "dk_depend(msys2)")
	dk_installPackage("make")
	dk_set(CMAKE_MAKE_PROGRAM	"${msys2}/mingw32/bin/mingw32-make.exe")
	
elseif(Windows_X86_64_Gcc)
	dk_validate(msys2 "dk_depend(msys2)")
	dk_installPackage("make")
	dk_set(CMAKE_MAKE_PROGRAM	"${msys2}/mingw64/bin/mingw32-make.exe")
	
elseif(Windows_X86_64_Ucrt)
	dk_validate(msys2 "dk_depend(msys2)")
	dk_installPackage("make")
	dk_set(CMAKE_MAKE_PROGRAM	"${msys2}/ucrt64/bin/mingw32-make.exe")

elseif(Windows_X86_Msvc)
	dk_depend(visualstudio)
	dk_set(CMAKE_MAKE_PROGRAM	${VS_MAKE_PROGRAM})
	
elseif(Windows_X86_64_Msvc)
	dk_depend(visualstudio)
	dk_set(CMAKE_MAKE_PROGRAM	${VS_MAKE_PROGRAM})
endif()

if((NOT CMAKE_MAKE_PROGRAM) AND (NOT EXISTS "${CMAKE_MAKE_PROGRAM}"))
	dk_findProgram(CMAKE_MAKE_PROGRAM make)
endif()

if(NOT EXISTS "${CMAKE_MAKE_PROGRAM}")
	dk_warning("Could not determine the make file to use. Attempting to just use 'make' and hope it's in the path envirnment.")
	dk_set(CMAKE_MAKE_PROGRAM	make)
endif()

dk_assertVar(CMAKE_MAKE_PROGRAM)
