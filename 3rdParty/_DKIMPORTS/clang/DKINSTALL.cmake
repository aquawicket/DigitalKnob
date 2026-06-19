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


############ clang ############
# https://packages.msys2.org/package/mingw-w64-x86_64-clang?repo=mingw64
#

if(MSYSTEM)
	dk_validate(msys2 "dk_depend(msys2)")
endif()
dk_installPackage(clang)

if(Android)
	dk_validate(android-ndk 	"dk_depend(android-ndk)")
	dk_set(CMAKE_C_COMPILER   	"${android-ndk}/toolchains/llvm/prebuilt/${Android_Host_Tag}/bin/clang${exe}")
	dk_set(CMAKE_CXX_COMPILER 	"${android-ndk}/toolchains/llvm/prebuilt/${Android_Host_Tag}/bin/clang++${exe}")
	
elseif(Linux_Host)
	if(EXISTS "/usr/bin/clang")
		dk_set(CMAKE_C_COMPILER		"usr/bin/clang")
	elseif(EXISTS "/usr/local/bin/clang")
		dk_set(CMAKE_C_COMPILER		"/usr/local/bin/clang")
	endif()

	if(EXISTS "/usr/bin/clang++")
		dk_set(CMAKE_CXX_COMPILER	"/usr/bin/clang++")
	elseif(EXISTS "/usr/local/bin/clang++")
		dk_set(CMAKE_CXX_COMPILER	"/usr/local/bin/clang++")
	endif()
	
elseif(Windows_Arm64_Clang)
	dk_validate(msys2 "dk_depend(msys2)")
	dk_set(CMAKE_C_COMPILER			"${msys2}/clangarm64/bin/clang.exe")
	dk_set(CMAKE_CXX_COMPILER		"${msys2}/clangarm64/bin/clang++.exe")
	dk_set(CMAKE_RC_COMPILER  		"${msys2}/clangarm64/bin/windres.exe")
	
elseif(Windows_X86_Clang)
	dk_validate(msys2 "dk_depend(msys2)")
	dk_set(CMAKE_C_COMPILER			"${msys2}/clang32/bin/clang.exe")
	dk_set(CMAKE_CXX_COMPILER		"${msys2}/clang32/bin/clang++.exe")
	dk_set(CMAKE_RC_COMPILER  		"${msys2}/clang32/bin/windres.exe")
	
elseif(Windows_X86_64_Clang)
	dk_validate(msys2 "dk_depend(msys2)")
	dk_set(CMAKE_C_COMPILER			"${msys2}/clang64/bin/clang.exe")
	dk_set(CMAKE_CXX_COMPILER		"${msys2}/clang64/bin/clang++.exe")
	dk_set(CMAKE_RC_COMPILER  		"${msys2}/clang64/bin/windres.exe")
	
elseif(Windows_X86_Gcc)
	dk_validate(msys2 "dk_depend(msys2)")
	dk_set(CMAKE_C_COMPILER			"${msys2}/mingw32/bin/clang.exe")
	dk_set(CMAKE_CXX_COMPILER		"${msys2}/mingw32/bin/clang++.exe")
	dk_set(CMAKE_RC_COMPILER  		"${msys2}/mingw32/bin/windres.exe")
	
elseif(Windows_X86_64_Gcc)
	dk_validate(msys2 "dk_depend(msys2)")
	dk_set(CMAKE_C_COMPILER			"${msys2}/mingw64/bin/clang.exe")
	dk_set(CMAKE_CXX_COMPILER		"${msys2}/mingw64/bin/clang++.exe")
	dk_set(CMAKE_RC_COMPILER  		"${msys2}/mingw64/bin/windres.exe")
	
elseif(Windows_X86_64_Ucrt)
	dk_validate(msys2 "dk_depend(msys2)")
	dk_set(clang_exe   				"${msys2}/ucrt64/bin/clang.exe")
	dk_set(CMAKE_CXX_COMPILER		"${msys2}/ucrt64/bin/clang++.exe")
	dk_set(CMAKE_RC_COMPILER  		"${msys2}/ucrt64/bin/windres.exe")
	
endif()
