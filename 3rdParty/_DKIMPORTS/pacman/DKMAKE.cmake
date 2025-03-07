#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ pacman ############
# https://wiki.archlinux.org/title/Pacman
# https://walterteng.com/using-zsh-on-windows

dk_validate(MSYS2 "dk_depend(msys2)")
dk_findProgram(PACMAN_EXE pacman "${MSYS2_DIR}/usr/bin")


#if((NOT DKUPDATE) AND (EXISTS ${PACMAN_EXE}))
#	dk_notice("PACMAN_EXE is already installed, returning")
#	dk_return()
#endif()


###### init the pacman keyring ######
#dk_delete("${MSYS2_GPGDir}")
if(NOT EXISTS "${MSYS2_GPGDir}")
	set(ENV{PATH} "$ENV{PATH}:/usr/bin")
	dk_findProgram(BASH_EXE bash "${MSYS2_DIR}/usr/bin")
	execute_process(COMMAND ${BASH_EXE} -c "pacman-key --init")
	execute_process(COMMAND ${BASH_EXE} -c "pacman-key --populate msys2")
	dk_killProcess("gpg-agent.exe")
endif()

if(NOT EXISTS "${MSYS2_DBPath}/sync")
	execute_process(COMMAND "${PACMAN_EXE}" -Syu --noconfirm)
endif()
####################################

dk_FirewallAllow("pacman" "${PACMAN_EXE}")

#dk_installPackage(pacman)
dk_assertPath(PACMAN_EXE)
