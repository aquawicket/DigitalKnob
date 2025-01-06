#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ pacman ############
# https://wiki.archlinux.org/title/Pacman
# https://walterteng.com/using-zsh-on-windows


dk_validate(MSYS2 "dk_depend(msys2)")


dk_findProgram(PACMAN_EXE pacman "${MSYS2_DIR}/usr/bin")
if((NOT DKUPDATE) AND (EXISTS ${PACMAN_EXE}))
	dk_notice("PACMAN_EXE is already installed, returning")
	dk_return()
endif()



#dk_installPackage(pacman)
#dk_firewallAllow("pacman" "${PACMAN_EXE}")
	
dk_assertPath(PACMAN_EXE)
