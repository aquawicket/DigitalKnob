#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

##################################################################################
# dk_generate()
#
#
function(dk_generate)
	dk_debugFunc()

	dk_echo("")
	dk_echo("##################################################################################")
	dk_echo("  Generating ${Target_App} - ${Target_Tuple} - ${Target_Type} - ${Target_Level}")
	dk_echo("##################################################################################")
	dk_echo("")
	
	dk_validate(DKCPP_APPS_DIR "dk_DKBRANCH_DIR()")
	set(Target_App_Dir "$ENV{DKCPP_APPS_DIR}/${Target_App}")
	set(Target_Tuple_Dir "${Target_App}/${Target_Tuple}")
	dk_mkdir("${Target_Tuple_Dir}")
	dk_chdir("${Target_Tuple_Dir}")
	set(CMAKE_SOURCE_DIR "$ENV{DKCMAKE_DIR}")
	dk_assertPath(CMAKE_SOURCE_DIR)
	
	###### BUILD CMAKE_ARGS ARRAY ######
	set(Target_Level "RebuildAll")
	set(Target_Link "Static")
	
	set(CMAKE_ARGS "")
	dk_assertPath($ENV{DKCMAKE_FUNCTIONS_DIR_})
	dk_arrayPush(CMAKE_ARGS "-DDKCMAKE_FUNCTIONS_DIR_=$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	if("${Target_Type}" STREQUAL "Debug")
		dk_arrayPush(CMAKE_ARGS "-DDEBUG=ON" "-DRELEASE=OFF")
	elseif("${Target_Type}" STREQUAL "Release")
		dk_arrayPush(CMAKE_ARGS "-DDEBUG=OFF" "-DRELEASE=ON")
	elseif("${Target_Type}" STREQUAL "All")
		dk_arrayPush(CMAKE_ARGS "-DDEBUG=ON" "-DRELEASE=ON")
	else()
		dk_error("Target_Type:${Target_Type} is invalid")
	endif()
	
	##############################################################
	if("${Target_Level}" STREQUAL "Build")
		dk_arrayPush(CMAKE_ARGS "-DBUILD=ON")
	elseif("${Target_Level}" STREQUAL "Rebuild")
		dk_arrayPush(CMAKE_ARGS "-DREBUILD=ON")
	elseif("${Target_Level}" STREQUAL "RebuildAll")
		dk_arrayPush(CMAKE_ARGS "-DREBUILDALL=ON")
	else()
		dk_error("Target_Level:${Target_Level} is invalid")
	endif()
	
	if("${Target_Link}" STREQUAL "Static")
		dk_arrayPush(CMAKE_ARGS "-DSTATIC=ON")
	endif()
	if("${Target_Link}" STREQUAL "Shared")
		dk_arrayPush(CMAKE_ARGS "-DSHARED=ON")
	endif()
	
	set(CMAKE_BINARY_DIR "${Target_Tuple_Dir}/${Target_Type}")
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
	
	if("${Target_Tuple}" MATCHES "Cosmo")
		dk_arrayUnshift(CMAKE_ARGS "-G" "Unix Makefiles")
	endif()
	
	if("${Target_Tuple}" MATCHES "Cygwin")
		dk_arrayUnshift(CMAKE_ARGS "-G" "Unix Makefiles")
	endif()
	
	if("${Target_Tuple}" MATCHES "Android")
		dk_arrayUnshift(CMAKE_ARGS "-G" "Unix Makefiles")
	endif()

	if("${Target_Tuple}" MATCHES "Emscripten")
		dk_arrayUnshift(CMAKE_ARGS "-G" "Unix Makefiles")
	endif()
	
	if("${Target_Tuple}" MATCHES "Ios")
		dk_arrayUnshift(CMAKE_ARGS "-G" "Xcode")
	endif()
	
	if("${Target_Tuple}" MATCHES "Linux")
		dk_arrayUnshift(CMAKE_ARGS "-G" "Unix Makefiles")
	endif()
	
	if("${Target_Tuple}" MATCHES "Mac")
		dk_arrayUnshift(CMAKE_ARGS "-G" "Xcode")
	endif()
	
	if("${Target_Tuple}" MATCHES "Raspberry")
		dk_arrayUnshift(CMAKE_ARGS "-G" "Unix Makefiles")
	endif()
	
	if("${Target_Tuple}" STREQUAL "Windows_Arm64_Clang")
		dk_validate(ENV{DK3RDPARTY_DIR} "dk_DK3RDPARTY_DIR")
		# TODO: export PATH=$ENV{DK3RDPARTY_DIR}/msys2-x86_64-20231026/clangarm64/bin:${PATH}
		dk_arrayUnshift(CMAKE_ARGS "-G" "MinGW Makefiles" "-DMSYSTEM=CLANGARM64")
	endif()
	
	if("${Target_Tuple}" STREQUAL "Windows_X86_Clang")
		# TODO: export PATH=$ENV{DK3RDPARTY_DIR}/msys2-x86_64-20231026/clang32/bin:${PATH}
		dk_arrayUnshift(CMAKE_ARGS "-G" "MinGW Makefiles" "-DMSYSTEM=CLANG32")
	endif()
	
	if("${Target_Tuple}" STREQUAL "Windows_X86_Gcc")
		# TODO: export PATH=$ENV{DK3RDPARTY_DIR}/msys2-x86_64-20231026/mingw32/bin:${PATH}
		dk_arrayUnshift(CMAKE_ARGS "-G" "MinGW Makefiles" "-DMSYSTEM=MINGW32")
	endif()
	
	if("${Target_Tuple}" STREQUAL "Windows_X86_64_Clang")
		# TODO: export PATH=$ENV{DK3RDPARTY_DIR}/msys2-x86_64-20231026/clang64/bin:${PATH}
		# TODO: export MSYSTEM=CLANG64
		#dk_arrayUnshift(CMAKE_ARGS "-DCMAKE_EXE_LINKER_FLAGS=-static -mconsole")
		dk_arrayUnshift(CMAKE_ARGS "-G" "MinGW Makefiles" "-DMSYSTEM=CLANG64")
	endif()
	
	if("${Target_Tuple}" STREQUAL "Windows_X86_64_Gcc")
		# TODO: export PATH=$ENV{DK3RDPARTY_DIR}/msys2-x86_64-20231026/mingw64/bin:${PATH}
		dk_arrayUnshift(CMAKE_ARGS "-G" "MinGW Makefiles" "-DMSYSTEM=MINGW64")
	endif()
	
	if("${Target_Tuple}" STREQUAL "Windows_X86_64_Ucrt")
		# TODO: export PATH=$ENV{DK3RDPARTY_DIR}/msys2-x86_64-20231026/ucrt64/bin:${PATH}
		dk_arrayUnshift(CMAKE_ARGS "-G" "MinGW Makefiles" "-DMSYSTEM=UCRT64")
	endif()
	
	if("${Target_Tuple}" STREQUAL "Windows_X86_64_Msvc")
		dk_arrayUnshift(CMAKE_ARGS "-G" "Visual Studio 17 2022")
	endif()

	###### CMAKE_TOOLCHAIN_FILE ######
#	set(TOOLCHAIN "$ENV{DKCMAKE_DIR}/toolchains/${Target_Tuple}_toolchain.cmake")
#	dk_echo("TOOLCHAIN = ${TOOLCHAIN}")
#	if(dk_pathExists "${TOOLCHAIN}")
#		dk_arrayPush(CMAKE_ARGS "-DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN}")
#	endif()
	
	###### WSL CMake Fix ######
	if(DEFINED WSLENV) 
		dk_chdir("$ENV{DKCMAKE_DIR}")
		dk_arrayPush(CMAKE_ARGS ".")
	endif()
	
	###### Cygwin CMake Fix ######
	if(DEFINED CYGWIN) 
		dk_chdir("$ENV{DKCMAKE_DIR}")
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