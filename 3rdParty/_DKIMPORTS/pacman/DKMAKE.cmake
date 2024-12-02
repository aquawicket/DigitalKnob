#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ pacman ############
# https://wiki.archlinux.org/title/Pacman
# https://walterteng.com/using-zsh-on-windows


dk_depend(msys2)
dk_findProgram(PACMAN_EXE pacman "${MSYS2_DIR}/usr/bin")
if((NOT DKUPDATE) AND (EXISTS ${PACMAN_EXE}))
	dk_notice("PACMAN_EXE is already installed, returning")
	dk_return()
endif()


dk_delete("${MSYS2_DIR}/var/lib/pacman/db.lck")		# delete the database lock file
#dk_firewallAllow("pacman" "${PACMAN_EXE}")
	
dk_assertPath(PACMAN_EXE)
