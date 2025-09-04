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

	
########### msys2 ###########
# https://www.msys2.org
# https://silentinstallhq.com/msys2-silent-install-how-to-guide


dk_validate(Host_Os "dk_Host_Os()")
if(NOT DEFINED Windows_Host)
	dk_undepend(msys2)
	return()
endif()

############ msys2 variables ############
#dk_getFileParams	("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
#dk_validate			(Host_Tuple "dk_Host_Tuple()")
#dk_importVariables	("${msys2_${Host_Tuple}_Import}")
#dk_assertVar(msys2)
dk_import()

dk_set				(msys2_DBPath		"${msys2}/var/lib/pacman")
dk_set				(msys2_CacheDir		"${msys2}/var/cache/pacman/pkg")
dk_set				(msys2_LogFile		"${msys2}/var/log/pacman.log")
dk_set				(msys2_GPGDir		"${msys2}/etc/pacman.d/gnupg")
dk_set				(msys2_bin 			"${msys2}/usr/bin")
dk_set				(CLANGARM64_BIN		"${msys2}/clangarm64/bin")
dk_set				(CLANG32_BIN		"${msys2}/clang32/bin")
dk_set				(CLANG64_BIN		"${msys2}/clang64/bin")
dk_set				(MINGW32_BIN		"${msys2}/mingw32/bin")
dk_set				(MINGW64_BIN		"${msys2}/mingw64/bin")
dk_set				(UCRT64_BIN			"${msys2}/ucrt64/bin")
dk_set				(msys2_MAKE_PROGRAM "${msys2}/usr/bin/make.exe")

############ INSTALL ############
#dk_import("${msys2_${Host_Tuple}_Import}" IMPORT_PATH ${CMAKE_CURRENT_LIST_DIR})
dk_firewallAllow("dirmngr" "${msys2}/usr/bin/dirmngr.exe")

### Save Pacman database, keys and cache to download directory for offline buiding ###
#dk_validate		(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
#dk_copy("$ENV{DKIMPORTS_DIR}/msys2/pacman.conf" "${msys2}/etc/pacman.conf" OVERWRITE) #FIXME - move to pacman
#dk_set				(msys2_DBPath		"$ENV{DKDOWNLOAD_DIR}/msys2/var/lib/pacman")
#dk_set				(msys2_LogFile		"$ENV{DKDOWNLOAD_DIR}/msys2/var/log/pacman.log")
#dk_set				(msys2_GPGDir		"$ENV{DKDOWNLOAD_DIR}/msys2/etc/pacman.d/gnupg")
#dk_mkdir("${msys2_DBPath}")
dk_validate			(DKDOWNLOAD_DIR 	"dk_DKDOWNLOAD_DIR()")
dk_set				(msys2_CacheDir		"$ENV{DKDOWNLOAD_DIR}/msys2/var/cache/pacman/pkg")
dk_mkdir("${msys2_CacheDir}")




### exe installer ###
#if((NOT DEFINED DKUPDATE) AND (EXISTS "${msys2}/msys2.exe"))
#	dk_notice("${msys2_FOLDER} is already installed, returning")
#	return()
#else()
#	dk_info("Installing ${msys2_FOLDER}")
#	dk_import(${msys2_IMPORT})
#	
#	#dk_validate(ENV{DKDOWNLOAD_DIR} "dk_DKDOWNLOAD_DIR()")
#	#dk_download(${msys2_IMPORT} $ENV{DKDOWNLOAD_DIR})
#	#dk_exec("$ENV{DKDOWNLOAD_DIR}/${msys2_IMPORT_FILE}" install --root "${msys2}" --confirm-command)
#endif()

