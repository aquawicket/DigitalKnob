#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


########### msys2 ###########
# https://www.msys2.org
# https://silentinstallhq.com/msys2-silent-install-how-to-guide


dk_validate(Host_Os "dk_Host_Os()")

if(NOT DEFINED Win_Host)
	dk_undepend(msys2)
	return()
endif()

############ MSYS2 variables ############
dk_validate			(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
dk_getFileParams	("$ENV{DKIMPORTS_DIR}/msys2/dkconfig.txt")
dk_importVariables	("${MSYS2_DL}")
dk_validate			(DKDOWNLOAD_DIR 	"dk_DKDOWNLOAD_DIR()")
dk_set				(MSYS2_DBPath		"${MSYS2_DIR}/var/lib/pacman")
dk_set				(MSYS2_CacheDir		"${MSYS2_DIR}/var/cache/pacman/pkg")
dk_set				(MSYS2_LogFile		"${MSYS2_DIR}/var/log/pacman.log")
dk_set				(MSYS2_GPGDir		"${MSYS2_DIR}/etc/pacman.d/gnupg")
dk_set				(MSYS2_BIN 			"${MSYS2}/usr/bin")
dk_set				(CLANGARM64_BIN		"${MSYS2}/clangarm64/bin")
dk_set				(CLANG32_BIN		"${MSYS2}/clang32/bin")
dk_set				(CLANG64_BIN		"${MSYS2}/clang64/bin")
dk_set				(MINGW32_BIN		"${MSYS2}/mingw32/bin")
dk_set				(MINGW64_BIN		"${MSYS2}/mingw64/bin")
dk_set				(UCRT64_BIN			"${MSYS2}/ucrt64/bin")
dk_set				(MSYS2_MAKE_PROGRAM "${MSYS2_BIN}/make.exe")

############ INSTALL ############
dk_import(${MSYS2_DL})
dk_firewallAllow("dirmngr" "${MSYS2}/usr/bin/dirmngr.exe")

### Save Pacman database, keys and cache to download directory for offline buiding ###
#dk_copy("$ENV{DKIMPORTS_DIR}/msys2/pacman.conf" "${MSYS2}/etc/pacman.conf" OVERWRITE) #FIXME - move to pacman
#dk_set				(MSYS2_DBPath		"$ENV{DKDOWNLOAD_DIR}/MSYS2/var/lib/pacman")
#dk_set				(MSYS2_LogFile		"$ENV{DKDOWNLOAD_DIR}/MSYS2/var/log/pacman.log")
#dk_set				(MSYS2_GPGDir		"$ENV{DKDOWNLOAD_DIR}/MSYS2/etc/pacman.d/gnupg")
#dk_mkdir("${MSYS2_DBPath}")
dk_set				(MSYS2_CacheDir		"$ENV{DKDOWNLOAD_DIR}/MSYS2/var/cache/pacman/pkg")
dk_mkdir("${MSYS2_CacheDir}")




### exe installer ###
#if((NOT DEFINED DKUPDATE) AND (EXISTS "${MSYS2}/msys2.exe"))
#	dk_notice("${MSYS2_FOLDER} is already installed, returning")
#	return()
#else()
#	dk_info("Installing ${MSYS2_FOLDER}")
#	dk_import(${MSYS2_DL})
#	
#	#dk_validate(ENV{DKDOWNLOAD_DIR} "dk_DKDOWNLOAD_DIR()")
#	#dk_download(${MSYS2_DL} $ENV{DKDOWNLOAD_DIR})
#	#dk_command("$ENV{DKDOWNLOAD_DIR}/${MSYS2_DL_FILE}" install --root "${MSYS2}" --confirm-command)
#endif()

