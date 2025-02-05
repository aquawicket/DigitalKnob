#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


########### msys2 ###########
# https://www.msys2.org
# https://silentinstallhq.com/msys2-silent-install-how-to-guide


dk_validate(host_triple "dk_host_triple()")

if(NOT DEFINED WIN_HOST)
	dk_undepend(msys2)
	return()
endif()

############ MSYS2 variables ############
dk_validate			(DIGITALKNOB_DIR "dk_DIGITALKNOB_DIR()")
dk_validate			(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
dk_getFileParam		("${DKIMPORTS_DIR}/msys2/dkconfig.txt" MSYS2_DL)
dk_importVariables	("${MSYS2_DL}")
dk_set				(MSYS2_CACHE_DIR 	"${DIGITALKNOB_DIR}/MSYS2")
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
dk_copy("${DKIMPORTS_DIR}/msys2/pacman.conf" "${MSYS2}/etc/pacman.conf" OVERWRITE)
dk_makeDirectory("${MSYS2_CACHE_DIR}/db")
dk_firewallAllow("dirmngr" "${MSYS2}/usr/bin/dirmngr.exe")



### exe installer ###
#if((NOT DEFINED DKUPDATE) AND (EXISTS "${MSYS2}/msys2.exe"))
#	dk_notice("${MSYS2_FOLDER} is already installed, returning")
#	return()
#else()
#	dk_info("Installing ${MSYS2_FOLDER}")
#	dk_import(${MSYS2_DL})
#	
#	#dk_validate(DKDOWNLOAD_DIR "dk_DKDOWNLOAD_DIR()")
#	#dk_download(${MSYS2_DL} ${DKDOWNLOAD_DIR})
#	#dk_command("${DKDOWNLOAD_DIR}/${MSYS2_DL_FILE}" install --root "${MSYS2}" --confirm-command)
#endif()

