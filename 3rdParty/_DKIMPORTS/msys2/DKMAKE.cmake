#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


# https://www.msys2.org
# https://silentinstallhq.com/msys2-silent-install-how-to-guide

dk_load(dk_builder)

### only accept windows hosts
#dk_validate(host_triple "dk_host_triple()")
if(NOT WIN_HOST)
	dk_undepend(msys2)
	dk_return()
endif()



### Set CMAKE_GENERATOR ###
dk_validate(CMD_EXE "dk_depend(cmd)")
if(CMD_EXE OR MINGW)
	dk_set(MSYS2_GENERATOR	"MinGW Makefiles")	# if in Cmd
else()
	dk_set(MSYS2_GENERATOR 	"MSYS Makefiles")	# if in Shell
endif()
if(NOT CMAKE_GENERATOR AND MSYS2_GENERATOR)
	dk_set(CMAKE_GENERATOR ${MSYS2_GENERATOR})
endif()

### Return if MSYS2_EXE is already set
if(EXISTS ${MSYS2_EXE})
	dk_return()
endif()


### INSTALL ###
dk_set(MSYS2_DL https://github.com/msys2/msys2-installer/releases/download/2024-07-27/msys2-x86_64-20240727.exe)
dk_importVariables(${MSYS2_DL})

dk_set(MSYS2_EXE "${MSYS2_DIR}/msys2.exe")
dk_validate(DKDOWNLOAD_DIR "dk_DIGITALKNOB_DIR()")
dk_assertPath(DKDOWNLOAD_DIR)

### Install Msys2 ###
if(NOT EXISTS ${MSYS2_EXE})
	dk_info("Installing ${MSYS2_FOLDER}")
	dk_download(${MSYS2_DL} ${DKDOWNLOAD_DIR})
	dk_command("${DKDOWNLOAD_DIR}/${MSYS2_DL_FILE}" install --root "${MSYS2_DIR}" --confirm-command)
endif()	



if(WIN_HOST AND (MSYSTEM OR ANDROID OR EMSCRIPTEN))
	dk_prependEnvPath("${MSYS2_DIR}/usr/bin")	
	### Update with pacman ###
	#dk_findProgram(PACMAN_EXE pacman "${MSYS2_DIR}/usr/bin")
	#execute_process(COMMAND ${PACMAN_EXE} -Syu --noconfirm --cachedir ${DKDOWNLOAD_DIR})
	#dk_installPackage(update)
	
	### Install toolchain ###
	if(MSYSTEM)
		# Set PATH environment  variables
		dk_setEnv("MSYSTEM"  	"${MSYSTEM}")
		dk_setEnv("${MSYSTEM}"	ON)
		dk_toLower(${MSYSTEM} msystem)
		dk_prependEnvPath("${MSYS2_DIR}/${msystem}/bin")
		dk_exportVars(PATH "$ENV{PATH}")

		dk_installPackage(toolchain)
	else()
		dk_set(MSYS2_BASH_EXPORTS	"export PATH=${MSYS2_DIR}/usr/bin:$PATH")
	endif()
	
	### Create Bash Exports ###
	dk_depend(cygpath)
	dk_command(${CYGPATH_EXE} -m "${MSYS2_DIR}" OUTPUT_VARIABLE MSYS2_UNIXPATH)
	
	dk_set(CLANG32_BASH_EXPORTS		"export PATH=${MSYS2_UNIXPATH}/clang32/bin:$PATH")
	dk_set(CLANG64_BASH_EXPORTS		"export PATH=${MSYS2_UNIXPATH}/clang64/bin:$PATH")
	dk_set(CLANGARM64_BASH_EXPORTS	"export PATH=${MSYS2_UNIXPATH}/clangarm64/bin:$PATH")
	dk_set(MINGW32_BASH_EXPORTS		"export PATH=${MSYS2_UNIXPATH}/mingw32/bin:$PATH")
	dk_set(MINGW64_BASH_EXPORTS		"export PATH=${MSYS2_UNIXPATH}/mingw64/bin:$PATH")
	dk_set(UCRT64_BASH_EXPORTS		"export PATH=${MSYS2_UNIXPATH}/ucrt64/bin:$PATH")
	dk_set(MSYS2_BASH_EXPORTS		"export PATH=${MSYS2_UNIXPATH}/usr/bin:$PATH")
	
	dk_set(CLANG32_EXE 		"${MSYS2_DIR}/clang32.exe")
	dk_set(CLANG64_EXE 		"${MSYS2_DIR}/clang64.exe")
	dk_set(CLANGARM64_EXE 	"${MSYS2_DIR}/clangarm64.exe")
	dk_set(MINGW32_EXE 		"${MSYS2_DIR}/mingw32.exe")
	dk_set(MINGW64_EXE 		"${MSYS2_DIR}/mingw64.exe")
	dk_set(UCRT64_EXE 		"${MSYS2_DIR}/ucrt64.exe")
	dk_set(MSYS2_EXE 		"${MSYS2_DIR}/msys2.exe")
endif()


