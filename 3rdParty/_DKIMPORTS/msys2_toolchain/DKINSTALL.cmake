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


###### msys2_toolchain ######
# https://www.msys2.org
dk_validate(Target_Config  "dk_Target_Config()")

if(NOT Windows_Host)
	dk_disable(msys2)
	dk_return()
endif()

### Return if MSYS2_EXE is already set
#if(EXISTS ${msys2_EXE})
#	dk_return()
#endif()


if(Windows_Host AND (MSYSTEM OR Android OR Emscripten))
	dk_prependEnvPath("${msys2}/usr/bin")
	
	### Install toolchain ###
	if(MSYSTEM)
		# Set PATH environment  variables
		dk_setEnv("MSYSTEM"  	"${MSYSTEM}")
		dk_setEnv("${MSYSTEM}"	ON)
		dk_toLower(${MSYSTEM} msystem)
		dk_prependEnvPath("${msys2}/${msystem}/bin")
		
		dk_installPackage(toolchain)
	else()
		dk_set(msys2_bin		"export PATH=${msys2}/usr/bin:$PATH")
	endif()
	
	### Create Bash Exports ###
	dk_depend(cygpath)
	dk_exec(${cygpath_exe} -m "${msys2}" OUTPUT_VARIABLE MSYS2_CYGPATH)
	
	dk_set(CLANG32_BIN		"export PATH=${msys2_CYGPATH}/clang32/bin:$PATH")
	dk_set(CLANG64_BIN		"export PATH=${msys2_CYGPATH}/clang64/bin:$PATH")
	dk_set(CLANGARM64_BIN	"export PATH=${msys2_CYGPATH}/clangarm64/bin:$PATH")
	dk_set(MINGW32_BIN		"export PATH=${msys2_CYGPATH}/mingw32/bin:$PATH")
	dk_set(MINGW64_BIN		"export PATH=${msys2_CYGPATH}/mingw64/bin:$PATH")
	dk_set(UCRT64_BIN		"export PATH=${msys2_CYGPATH}/ucrt64/bin:$PATH")
	dk_set(msys2_bin		"export PATH=${msys2_CYGPATH}/usr/bin:$PATH")
	
	dk_set(CLANG32_EXE 		"${msys2}/clang32.exe")
	dk_set(CLANG64_EXE 		"${msys2}/clang64.exe")
	dk_set(CLANGARM64_EXE 	"${msys2}/clangarm64.exe")
	dk_set(MINGW32_EXE 		"${msys2}/mingw32.exe")
	dk_set(MINGW64_EXE 		"${msys2}/mingw64.exe")
	dk_set(UCRT64_EXE 		"${msys2}/ucrt64.exe")
	dk_set(MSYS2_EXE 		"${msys2}/msys2.exe")
endif()
