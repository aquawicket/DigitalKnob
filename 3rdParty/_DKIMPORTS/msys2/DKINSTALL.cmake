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

	
########### msys2 ###########
# https://www.msys2.org
# https://silentinstallhq.com/msys2-silent-install-how-to-guide
# https://repo.msys2.org/distrib/x86_64/msys2-base-x86_64-20241208.tar.xz
#
function(DKINSTALL)
#	if(NOT Windows_Host)
#		dk_disable(msys2)
#		return()
#	endif()

	dk_import()

	dk_set(msys2_DBPath			"${msys2}/var/lib/pacman")
	dk_set(msys2_CacheDir		"${msys2}/var/cache/pacman/pkg")
	dk_set(msys2_LogFile		"${msys2}/var/log/pacman.log")
	dk_set(msys2_GPGDir			"${msys2}/etc/pacman.d/gnupg")
	dk_set(msys2_dirmngr_exe	"${msys2}/usr/bin/dirmngr.exe")
	dk_set(msys2_bin 			"${msys2}/usr/bin")
	dk_set(CLANGARM64_BIN		"${msys2}/clangarm64/bin")
	dk_set(CLANG32_BIN			"${msys2}/clang32/bin")
	dk_set(CLANG64_BIN			"${msys2}/clang64/bin")
	dk_set(MINGW32_BIN			"${msys2}/mingw32/bin")
	dk_set(MINGW64_BIN			"${msys2}/mingw64/bin")
	dk_set(UCRT64_BIN			"${msys2}/ucrt64/bin")
	dk_set(msys2_MAKE_PROGRAM 	"${msys2}/usr/bin/make.exe")

	dk_mkdir("${DKDOWNLOAD_DIR}/msys2")
	dk_copy("$ENV{DKHttp_DKDownload_Dir}/msys2" "${DKDOWNLOAD_DIR}/msys2")

	dk_firewallAllow("${msys2_dirmngr_exe}")

	### Save Pacman database, keys and cache to download directory for offline buiding ###
	#dk_validate(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
	#dk_copy	("${DKIMPORTS_DIR}/msys2/pacman.conf" "${msys2}/etc/pacman.conf" OVERWRITE) #FIXME - move to pacman
	#dk_set		(msys2_DBPath		"${DKDOWNLOAD_DIR}/msys2/var/lib/pacman")
	#dk_set		(msys2_LogFile		"${DKDOWNLOAD_DIR}/msys2/var/log/pacman.log")
	#dk_set		(msys2_GPGDir		"${DKDOWNLOAD_DIR}/msys2/etc/pacman.d/gnupg")
	#dk_mkdir	("${msys2_DBPath}")
	dk_validate	(DKDOWNLOAD_DIR 	"dk_DKDOWNLOAD_DIR()")
	dk_set		(msys2_CacheDir		"${DKDOWNLOAD_DIR}/msys2/var/cache/pacman/pkg")
	dk_mkdir	("${msys2_CacheDir}")

	### exe installer ###
	#if((NOT DEFINED DKUPDATE) AND (EXISTS "${msys2}/msys2.exe"))
	#	dk_notice("${msys2_Install_Name} is already installed, returning")
	#	return()
	#else()
	#	dk_info("Installing ${msys2_Install_Name}")
	#	dk_import(${msys2_Import})
	#	
	#	#dk_validate(DKDOWNLOAD_DIR "dk_DKDOWNLOAD_DIR()")
	#	#dk_download(${msys2_Import})
	#	#dk_exec("${DKDOWNLOAD_DIR}/${msys2_Import_File}" install --root "${msys2}" --confirm-command)
	#endif()
endfunction()
