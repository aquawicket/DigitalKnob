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
# dk_toolchain(<toolchain_file:optional>)
#
#
function(dk_toolchain)
	dk_debugFunc(0 1)

	###### SET ######
	if(ARGV)
		dk_set(DKToolchain "${ARGV0}")
	
	###### GET ######	
	elseif(DEFINED ENV{DKToolchain})
		dk_set(DKToolchain "$ENV{DKToolchain}")
	else()
		dk_validate(DKCMAKE_DIR "dk_DKBRANCH_DIR()")
		dk_validate(Target_Tuple "dk_Target_Tuple()")
		dk_set(DKToolchain "${DKCMAKE_DIR}/toolchains/${Target_Tuple}_toolchain.cmake")
	
		#################### TOOLCHAINS ##########################
		#[[
		### Android_Arm32
		if(Android_Arm32)
			dk_load(${DKCMAKE_DIR}/toolchains/Android_Arm32_toolchain.cmake)
		endif()
		### Android_arm64
		if(Android_Arm64)
			dk_load(${DKCMAKE_DIR}/toolchains/Android_Arm32_toolchain.cmake)
		endif()
		### Android_x86
		if(Android_X86)
			dk_load(${DKCMAKE_DIR}/toolchains/Android_X86_toolchain.cmake)
		endif()
		### Android_X86_64
		if(Android_X86_64)
			dk_load(${DKCMAKE_DIR}/toolchains/Android_X86_64_toolchain.cmake)
		endif()
		### Cosmopolitan ###
		if(Cosmopolitan)
			dk_load(${DKCMAKE_DIR}/toolchains/Cosmopolitan_toolchain.cmake)
		endif()
		### Emscripten_x86 ###
		if(Emscripten_X86)
			dk_load(${DKCMAKE_DIR}/toolchains/Emscripten_X86_toolchain.cmake)
		endif()
		### Ios_Arm32 - XCODE ###
		if(Ios_Arm32)
			dk_load(${DKCMAKE_DIR}/toolchains/Ios_Arm32_toolchain.cmake)
		endif()
		### Ios_Arm64 - XCODE ###
		if(Ios_Arm64)
			dk_load(${DKCMAKE_DIR}/toolchains/Ios_Arm64_toolchain.cmake)
		endif()
		### iOS Simulator x86 - XCODE ###
		if(Iossim_X86)
			dk_load(${DKCMAKE_DIR}/toolchains/Iossim_X86_toolchain.cmake)
		endif()
		### iOS Simulator x86_64 - XCODE ###
		if(Iossim_X86_64)
			dk_load(${DKCMAKE_DIR}/toolchains/Iossim_X86_64_toolchain.cmake)
		endif()
		### Linux x86 ###
		if(Linux_X86)
			dk_load(${DKCMAKE_DIR}/toolchains/Linux_X86_toolchain.cmake)
		endif()
		#### Linux x86_64 - clang ###
		if(Linux_X86_64_Clang)
			dk_load(${DKCMAKE_DIR}/toolchains/Linux_X86_64_Clang_toolchain.cmake)
		endif()
		#### Linux x86_64 - gcc ###
		if(Linux_X86_64_Gcc)
			dk_load(${DKCMAKE_DIR}/toolchains/Linux_X86_64_Gcc_toolchain.cmake)
		endif()
		### Mac x86 - XCODE ###
		if(Mac_X86)
			dk_load(${DKCMAKE_DIR}/toolchains/Mac_X86_toolchain.cmake)
		endif()
		### Mac x86_64 - XCODE ###
		if(Mac_X86_64)
			dk_load(${DKCMAKE_DIR}/toolchains/Mac_X86_64_toolchain.cmake)
		endif()
		### Raspbery arm32 ###
		if(Raspberry_Arm32)
			dk_load(${DKCMAKE_DIR}/toolchains/Raspberry_Arm32_toolchain.cmake)
		endif()
		### Raspbery arm64 ###
		if(Raspberry_Arm64)
			dk_load(${DKCMAKE_DIR}/toolchains/Raspberry_Arm64_toolchain.cmake)
		endif()
		### Windows arm64 - CLANGARM64 ###
		if(Windows_Arm64_Clang)
			dk_load(${DKCMAKE_DIR}/toolchains/Windows_Arm64_Clang_toolchain.cmake)
		endif()
		### Windows x86 - MSVC ###
		if(Windows_X86_Msvc)
			dk_load(${DKCMAKE_DIR}/toolchains/Windows_X86_Msvc_toolchain.cmake)
		endif()
		### Windows x86 - MINGW32 ###
		if(Windows_X86_Gcc)
			dk_load(${DKCMAKE_DIR}/toolchains/Windows_X86_Gcc_toolchain.cmake)
		endif()
		### Windows x86 - CLANG32 ###
		if(Windows_X86_Clang)
			dk_load(${DKCMAKE_DIR}/toolchains/Windows_X86_Clang_toolchain.cmake)
		endif()
		### Windows x86_64 - MSVC ###
		if(Windows_X86_64_Msvc)
			dk_load(${DKCMAKE_DIR}/toolchains/Windows_X86_64_Msvc_toolchain.cmake)
		endif()
		### Windows x86_64 - CLANG64 ###
		if(Windows_X86_64_Clang)
			dk_load(${DKCMAKE_DIR}/toolchains/Windows_X86_64_Clang_toolchain.cmake)
		endif()
		### Windows x86_64 - MINGW64 ###
		if(Windows_X86_64_Gcc)
			dk_load(${DKCMAKE_DIR}/toolchains/Windows_X86_64_Gcc_toolchain.cmake)
		endif()
		### Windows x86_64 - UCRT64 ###
		if(Windows_X86_64_Ucrt)
			dk_load(${DKCMAKE_DIR}/toolchains/Windows_X86_64_Ucrt_toolchain.cmake)
		endif()
		### Windows x86_64 - MSYS ###
		if(Windows_X86_64_Msys)
			dk_load(${DKCMAKE_DIR}/toolchains/Windows_X86_64_Msys_toolchain.cmake)
		endif()
		]]
	endif()
	
	###### Load Toolchain ######
	if(EXISTS "${DKToolchain}")
		dk_debug("loading ${DKToolchain} . . .")
		dk_load(${DKToolchain})
	else()
		dk_fatal("DKToolchain:${DKToolchain} NOT FOUND")
	endif()
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	###### GET ######
    dk_toolchain()
	dk_echo("DKToolchain = ${DKToolchain}")
	
	###### SET ######
	dk_toolchain("C:/Users/Administrator/DigitalKnob/Development/DKCMake/toolchains/Windows_X86_Msvc_toolchain.cmake")
	dk_echo("DKToolchain = ${DKToolchain}")
endfunction()