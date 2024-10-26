#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://www.msys2.org


if(NOT WIN_HOST)
	dk_undepend(msys2)
	dk_return()
endif()

### Return if MSYS2_EXE is already set
#if(EXISTS ${MSYS2_EXE})
#	dk_return()
#endif()


if(WIN_HOST AND (MSYSTEM OR ANDROID OR EMSCRIPTEN))
	dk_prependEnvPath("${MSYS2_DIR}/usr/bin")
	
	### Install toolchain ###
	if(MSYSTEM)
		# Set PATH environment  variables
		dk_setEnv("MSYSTEM"  	"${MSYSTEM}")
		dk_setEnv("${MSYSTEM}"	ON)
		dk_toLower(${MSYSTEM} msystem)
		dk_prependEnvPath("${MSYS2_DIR}/${msystem}/bin")
		
		dk_installPackage(toolchain)
	else()
		dk_set(MSYS2_BASH_EXPORTS		"export PATH=${MSYS2_DIR}/usr/bin:$PATH")
	endif()
	
	### Create Bash Exports ###
	dk_depend(cygpath)
	dk_command(${CYGPATH_EXE} -m "${MSYS2_DIR}" OUTPUT_VARIABLE MSYS2_CYGPATH)
	
	dk_set(CLANG32_BASH_EXPORTS		"export PATH=${MSYS2_CYGPATH}/clang32/bin:$PATH")
	dk_set(CLANG64_BASH_EXPORTS		"export PATH=${MSYS2_CYGPATH}/clang64/bin:$PATH")
	dk_set(CLANGARM64_BASH_EXPORTS	"export PATH=${MSYS2_CYGPATH}/clangarm64/bin:$PATH")
	dk_set(MINGW32_BASH_EXPORTS		"export PATH=${MSYS2_CYGPATH}/mingw32/bin:$PATH")
	dk_set(MINGW64_BASH_EXPORTS		"export PATH=${MSYS2_CYGPATH}/mingw64/bin:$PATH")
	dk_set(UCRT64_BASH_EXPORTS		"export PATH=${MSYS2_CYGPATH}/ucrt64/bin:$PATH")
	dk_set(MSYS2_BASH_EXPORTS		"export PATH=${MSYS2_CYGPATH}/usr/bin:$PATH")
	
	dk_set(CLANG64_EXE ${MSYS2_DIR}/clang64.exe)
endif()
