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


############ pacman ############
# https://wiki.archlinux.org/title/Pacman
# https://walterteng.com/using-zsh-on-windows

dk_validate(MSYS2 "dk_depend(msys2)")
dk_assertPath(${MSYS2})
dk_findProgram(PACMAN_EXE pacman "${MSYS2}/usr/bin")


#if((NOT DKUPDATE) AND (EXISTS ${PACMAN_EXE}))
#	dk_notice("PACMAN_EXE is already installed, returning")
#	dk_return()
#endif()


###### init the pacman keyring ######
#dk_delete("${MSYS2_GPGDir}")
if(NOT EXISTS "${MSYS2_GPGDir}")
	set(ENV{PATH} "${MSYS2}/usr/bin:$ENV{PATH}")
	set(ENV{MAKEPKG_LIBRARY} "${MSYS2}/usr/share/makepkg")
	dk_findProgram(BASH_EXE bash "${MSYS2}/usr/bin")
	execute_process(COMMAND ${BASH_EXE} -c "pacman-key --init")
	execute_process(COMMAND ${BASH_EXE} -c "pacman-key --populate msys2")
	dk_killProcess(gpg-agent.exe NO_HALT)
endif()

if(NOT EXISTS "${MSYS2_DBPath}/sync")
	execute_process(COMMAND "${PACMAN_EXE}" -Syu --noconfirm)
endif()
####################################

dk_FirewallAllow("pacman" "${PACMAN_EXE}")

#dk_installPackage(pacman)
dk_assertPath(PACMAN_EXE)
