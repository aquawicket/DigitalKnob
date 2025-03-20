#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

##################################################################################
# dk_generate()
#
#
function(dk_generate)
	dk_debugFunc()

	dk_echo("")
	dk_echo("########################################################################")
	dk_echo("     Generating ${target_app} - ${target_triple} - ${target_type} - ${target_level}")
	dk_echo("########################################################################")
	dk_echo("")
	
	dk_validate(DKCPP_APPS_DIR "dk_DKBRANCH_DIR()")
	set(TARGET_PATH "$ENV{DKCPP_APPS_DIR}/${target_app}")
	dk_printVar(TARGET_PATH)
	dk_makeDirectory("${TARGET_PATH}/${target_triple}")
	dk_cd("${TARGET_PATH}/${target_triple}")
	set(CMAKE_SOURCE_DIR "$ENV{DKCMAKE_DIR}")
	dk_assertPath(CMAKE_SOURCE_DIR)
	set(CMAKE_TARGET_PATH "${TARGET_PATH}")
	
	###### BUILD CMAKE_ARGS ARRAY ######
	set(target_level "RebuildAll")
	set(DKLINK "Static")
	
	set(CMAKE_ARGS "")
	dk_assertPath(ENV{DKCMAKE_FUNCTIONS_DIR_})
	dk_arrayPush(CMAKE_ARGS "-DDKCMAKE_FUNCTIONS_DIR_=$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	if("${target_type}" STREQUAL "Debug")
		dk_arrayPush(CMAKE_ARGS "-DDEBUG=ON" "-DRELEASE=OFF")
	elseif("${target_type}" STREQUAL "Release")
		dk_arrayPush(CMAKE_ARGS "-DDEBUG=OFF" "-DRELEASE=ON")
	elseif("${target_type}" STREQUAL "All")
		dk_arrayPush(CMAKE_ARGS "-DDEBUG=ON" "-DRELEASE=ON")
	else()
		dk_error("target_type:${target_type} is invalid")
	endif()
	
	##############################################################
	if("${target_level}" STREQUAL "Build")
		dk_arrayPush(CMAKE_ARGS "-DBUILD=ON")
	elseif("${target_level}" STREQUAL "Rebuild")
		dk_arrayPush(CMAKE_ARGS "-DREBUILD=ON")
	elseif("${target_level}" STREQUAL "RebuildAll")
		dk_arrayPush(CMAKE_ARGS "-DREBUILDALL=ON")
	else()
		dk_error("target_level:${target_level} is invalid")
	endif()
	
	if("${DKLINK}" STREQUAL "Static")
		dk_arrayPush(CMAKE_ARGS "-DSTATIC=ON")
	endif()
	if("${DKLINK}" STREQUAL "Shared")
		dk_arrayPush(CMAKE_ARGS "-DSHARED=ON")
	endif()
	
	set(CMAKE_BINARY_DIR "${CMAKE_TARGET_PATH}/${target_triple}/${target_type}")
	#dk_printVar(CMAKE_BINARY_DIR)
	
	if(NOT DEFINED ENV{WSLENV})
	if(NOT DEFINED ENV{CYGWIN})
		dk_arrayPush(CMAKE_ARGS "-S" "${CMAKE_SOURCE_DIR}")
	endif()
	endif()
	dk_arrayPush(CMAKE_ARGS "-B" "${CMAKE_BINARY_DIR}")
	
	############ CMake Options ############
    #dk_arrayPush(CMAKE_ARGS "-DCMAKE_VERBOSE_MAKEFILE=1")
	dk_arrayPush(CMAKE_ARGS "-DCMAKE_COLOR_DIAGNOSTICS=ON")
	#dk_arrayPush(CMAKE_ARGS "-Wdev")
	#dk_arrayPush(CMAKE_ARGS "-Werror=dev")
	#dk_arrayPush(CMAKE_ARGS "-Wdeprecated")
	#dk_arrayPush(CMAKE_ARGS "-Werror=deprecated")
	#dk_arrayPush(CMAKE_ARGS "--graphviz=graphviz.txt")
	#dk_arrayPush(CMAKE_ARGS "--system-information system_information.txt")
	#dk_arrayPush(CMAKE_ARGS "--debug-trycompile")
	#dk_arrayPush(CMAKE_ARGS "--debug-output")
	#dk_arrayPush(CMAKE_ARGS "--trace")
	#dk_arrayPush(CMAKE_ARGS "--trace-expand")
	#dk_arrayPush(CMAKE_ARGS "--warn-uninitialized")
	#dk_arrayPush(CMAKE_ARGS "--warn-unused-vars")
	#dk_arrayPush(CMAKE_ARGS "--check-system-vars")
	
	if("${target_triple}" STREQUAL "cosmopolitan")
		dk_arrayUnshift(CMAKE_ARGS "-G" "Unix Makefiles")
	endif()
	
	if("${target_triple}" STREQUAL "cygwin")
		dk_arrayUnshift(CMAKE_ARGS "-G" "Unix Makefiles")
	endif()
	
	if("${target_triple}" STREQUAL "android_arm32_clang")
		dk_arrayUnshift(CMAKE_ARGS "-G" "Unix Makefiles")
	endif()

	if("${target_triple}" STREQUAL "android_arm64_clang")
		dk_arrayUnshift(CMAKE_ARGS "-G" "Unix Makefiles")
	endif()
	
	if("${target_triple}" STREQUAL "emscripten_x86_clang")
		dk_arrayUnshift(CMAKE_ARGS "-G" "Unix Makefiles")
	endif()
	
	if("${target_triple}" STREQUAL "ios_arm32_clang")
		dk_arrayUnshift(CMAKE_ARGS "-G" "Xcode")
	endif()
	
	if("${target_triple}" STREQUAL "ios_arm64_clang")
		dk_arrayUnshift(CMAKE_ARGS "-G" "Xcode")
	endif()
	
	if("${target_triple}" STREQUAL "iossim_x86_clang")
		dk_arrayUnshift(CMAKE_ARGS "-G" "Xcode")
	endif()
	
	if("${target_triple}" STREQUAL "iossim_x86_64_clang")
		dk_arrayUnshift(CMAKE_ARGS "-G" "Xcode")
	endif()
	
	if("${target_triple}" STREQUAL "linux_x86_clang")
		dk_arrayUnshift(CMAKE_ARGS "-G" "Unix Makefiles")
	endif()
	
	if("${target_triple}" STREQUAL "linux_x86_64_clang")
		dk_arrayUnshift(CMAKE_ARGS "-G" "Unix Makefiles")
	endif()
	
	if("${target_triple}" STREQUAL "mac_x86_clang")
		dk_arrayUnshift(CMAKE_ARGS "-G" "Xcode")
	endif()
	
	if("${target_triple}" STREQUAL "mac_x86_64_clang")
		dk_arrayUnshift(CMAKE_ARGS "-G" "Xcode")
	endif()
	
	if("${target_triple}" STREQUAL "raspberry_arm32_clang")
		dk_arrayUnshift(CMAKE_ARGS "-G" "Unix Makefiles")
	endif()
	
	if("${target_triple}" STREQUAL "raspberry_arm64_clang")
		dk_arrayUnshift(CMAKE_ARGS "-G" "Unix Makefiles")
	endif()
	
	if("${target_triple}" STREQUAL "win_arm64_clang")
		dk_validate(ENV{DK3RDPARTY_DIR} "dk_DK3RDPARTY_DIR")
		# TODO: export PATH=$ENV{DK3RDPARTY_DIR}/msys2-x86_64-20231026/clangarm64/bin:${PATH}
		dk_arrayUnshift(CMAKE_ARGS "-G" "MinGW Makefiles" "-DMSYSTEM=CLANGARM64")
	endif()
	
	if("${target_triple}" STREQUAL "win_x86_clang")
		# TODO: export PATH=$ENV{DK3RDPARTY_DIR}/msys2-x86_64-20231026/clang32/bin:${PATH}
		dk_arrayUnshift(CMAKE_ARGS "-G" "MinGW Makefiles" "-DMSYSTEM=CLANG32")
	endif()
	
	if("${target_triple}" STREQUAL "win_x86_gcc")
		# TODO: export PATH=$ENV{DK3RDPARTY_DIR}/msys2-x86_64-20231026/mingw32/bin:${PATH}
		dk_arrayUnshift(CMAKE_ARGS "-G" "MinGW Makefiles" "-DMSYSTEM=MINGW32")
	endif()
	
	if("${target_triple}" STREQUAL "win_x86_64_clang")
		# TODO: export PATH=$ENV{DK3RDPARTY_DIR}/msys2-x86_64-20231026/clang64/bin:${PATH}
		# TODO: export MSYSTEM=CLANG64
		#dk_arrayUnshift(CMAKE_ARGS "-DCMAKE_EXE_LINKER_FLAGS=-static -mconsole")
		dk_arrayUnshift(CMAKE_ARGS "-G" "MinGW Makefiles" "-DMSYSTEM=CLANG64")
	endif()
	
	if("${target_triple}" STREQUAL "win_x86_64_gcc")
		# TODO: export PATH=$ENV{DK3RDPARTY_DIR}/msys2-x86_64-20231026/mingw64/bin:${PATH}
		dk_arrayUnshift(CMAKE_ARGS "-G" "MinGW Makefiles" "-DMSYSTEM=MINGW64")
	endif()
	
	if("${target_triple}" STREQUAL "win_x86_64_ucrt")
		# TODO: export PATH=$ENV{DK3RDPARTY_DIR}/msys2-x86_64-20231026/ucrt64/bin:${PATH}
		dk_arrayUnshift(CMAKE_ARGS "-G" "MinGW Makefiles" "-DMSYSTEM=UCRT64")
	endif()
	
	if("${target_triple}" STREQUAL "win_x86_64_msvc")
		dk_arrayUnshift(CMAKE_ARGS "-G" "Visual Studio 17 2022")
	endif()

	###### CMAKE_TOOLCHAIN_FILE ######
#	set(TOOLCHAIN "$ENV{DKCMAKE_DIR}/toolchains/${target_triple}_toolchain.cmake")
#	dk_echo("TOOLCHAIN = ${TOOLCHAIN}")
#	if(dk_pathExists "${TOOLCHAIN}")
#		dk_arrayPush(CMAKE_ARGS "-DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN}")
#	endif()
	
	###### WSL CMake Fix ######
	if(DEFINED WSLENV) 
		dk_cd("$ENV{DKCMAKE_DIR}")
		dk_arrayPush(CMAKE_ARGS ".")
	endif()
	
	###### Cygwin CMake Fix ######
	if(DEFINED CYGWIN) 
		dk_cd("$ENV{DKCMAKE_DIR}")
		dk_arrayPush(CMAKE_ARGS ".")
	endif()
	
	###### CMake Configure ######
	dk_validate(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
    dk_depend(cmake)
	
	dk_echo("")
	dk_echo("****** CLEAR CMAKE CACHE ******")
	dk_clearCmakeCache(${CMAKE_BINARY_DIR})
	
	dk_echo("")
	dk_echo("****** CMAKE COMMAND ******")
	#dk_nativePath("${CMAKE_EXE}" NATIVE_CMAKE_EXE)
	dk_printVar(CMAKE_ARGS)
	#TODO: ${CMAKE_EXE} "${CMAKE_ARGS[@]}" && dk_echo "CMake Generation Successful" || dk_error("CMake Generation Failed"
	execute_process(COMMAND ${CMAKE_EXE} ${CMAKE_ARGS})
	dk_echo("")
	
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_generate()
endfunction()