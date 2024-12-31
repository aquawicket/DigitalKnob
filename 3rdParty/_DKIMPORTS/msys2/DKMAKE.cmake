#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


########### msys2 ###########
# https://www.msys2.org
# https://silentinstallhq.com/msys2-silent-install-how-to-guide
#
#	windows uninstall registry location
#	HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\{060aa283-cf16-4aad-9250-bd91ab4c3d2f}
#
### only accept windows hosts
dk_validate(host_triple "dk_host_triple()")
dk_assertVar(host_triple)

if(NOT DEFINED WIN_HOST)
	dk_undepend(msys2)
	return()
endif()

############ MSYS2 variables ############
#dk_set(MSYS2_DL https://github.com/msys2/msys2-installer/releases/download/2024-07-27/msys2-x86_64-20240727.exe)
dk_validate			(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
dk_getFileParam		("${DKIMPORTS_DIR}/msys2/dkconfig.txt" MSYS2_DL)
dk_importVariables	("${MSYS2_DL}")
dk_set				(MSYS2_CACHE_DIR 	"${DKDOWNlOAD_DIR}")
dk_set				(MSYS2_BIN 			"${MSYS2}/usr/bin")
dk_set				(CLANGARM64_BIN		"${MSYS2}/clangarm64/bin")
dk_set				(CLANG32_BIN		"${MSYS2}/clang32/bin")
dk_set				(CLANG64_BIN		"${MSYS2}/clang64/bin")
dk_set				(MINGW32_BIN		"${MSYS2}/mingw32/bin")
dk_set				(MINGW64_BIN		"${MSYS2}/mingw64/bin")
dk_set				(UCRT64_BIN			"${MSYS2}/ucrt64/bin")
dk_set				(MSYS2_MAKE_PROGRAM "${MSYS2_BIN}/make.exe")

############ INSTALL ############
if((NOT DEFINED DKUPDATE) AND (EXISTS "${MSYS2}/msys2.exe"))
	dk_notice("${MSYS2_FOLDER} is already installed, returning")
	return()
else()
	dk_info("Installing ${MSYS2_FOLDER}")
	dk_validate(DKDOWNLOAD_DIR "dk_DKDOWNLOAD_DIR()")
	dk_download(${MSYS2_DL} ${DKDOWNLOAD_DIR})
	dk_command("${DKDOWNLOAD_DIR}/${MSYS2_DL_FILE}" install --root "${MSYS2}" --confirm-command)
endif()	



### Create Bash Exports ###
#dk_depend(cygpath)
#dk_command(${CYGPATH_EXE} -m "${MSYS2_DIR}" OUTPUT_VARIABLE MSYS2_UNIXPATH)
#dk_set(CLANG32_BIN				"export PATH=${MSYS2_UNIXPATH}/clang32/bin:$PATH")
#dk_set(CLANG64_BIN				"export PATH=${MSYS2_UNIXPATH}/clang64/bin:$PATH")
#dk_set(CLANGARM64_BIN			"export PATH=${MSYS2_UNIXPATH}/clangarm64/bin:$PATH")
#dk_set(MINGW32_BIN				"export PATH=${MSYS2_UNIXPATH}/mingw32/bin:$PATH")
#dk_set(MINGW64_BIN				"export PATH=${MSYS2_UNIXPATH}/mingw64/bin:$PATH")
#dk_set(UCRT64_BIN				"export PATH=${MSYS2_UNIXPATH}/ucrt64/bin:$PATH")
#dk_set(MSYS2_BIN				"export PATH=${MSYS2_UNIXPATH}/usr/bin:$PATH")
	
### NOTE: moved to DKBuildFlags.cmake
#### Set CMAKE_GENERATOR ###
#dk_depend(cmd)
#if(CMD_EXE OR MINGW)
#	dk_set(MSYS2_GENERATOR	"MinGW Makefiles")	# if in CMD shell
#else()
#	dk_set(MSYS2_GENERATOR 	"MSYS Makefiles")	# if in SH shell
#endif()
#if(NOT CMAKE_GENERATOR AND MSYS2_GENERATOR)
#	dk_set(CMAKE_GENERATOR ${MSYS2_GENERATOR})
#endif()


#dk_validate(target_triple "dk_target_triple()")
#if(MSYSTEM OR ANDROID OR EMSCRIPTEN)
#	dk_prependEnvPath("${MSYS2_BIN}")	
#	### Update with pacman ###
#	#dk_findProgram(PACMAN_EXE pacman "${MSYS2_DIR}/usr/bin")
#	#execute_process(COMMAND ${PACMAN_EXE} -Syu --noconfirm --cachedir ${MSYS2_CACHE_DIR})
#	#dk_installPackage(update)
#	
#	if(MSYSTEM)
#		# Set PATH environment  variables
#		dk_setEnv("MSYSTEM"  	"${MSYSTEM}")
#		dk_setEnv("${MSYSTEM}"	ON)
#		dk_toLower(${MSYSTEM} 	msystem)
#		
#		if(COSMOPOLITAN)
#			# Temporary fix for cosmopoiltan
#		else()
#			dk_prependEnvPath("${MSYS2_DIR}/${msystem}/bin")
#			dk_exportVars(PATH "$ENV{PATH}")
#		endif()
#	endif()
#endif()	
	


