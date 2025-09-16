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

dk_depend(msys2)
dk_findProgram(pacman_exe pacman "${msys2}/usr/bin")


#if((NOT DKUPDATE) AND (EXISTS ${pacman_exe}))
#	dk_notice("pacman_exe is already installed, returning")
#	dk_return()
#endif()


###### init the pacman keyring ######
#dk_delete("${msys2_GPGDir}")
if(NOT EXISTS "${msys2_GPGDir}")
	set(ENV{PATH} "${msys2}/usr/bin:$ENV{PATH}")
	set(ENV{MAKEPKG_LIBRARY} "${msys2}/usr/share/makepkg")
	dk_findProgram(bash_exe bash "${msys2}/usr/bin")
	execute_process(COMMAND ${bash_exe} -c "pacman-key --init")
	execute_process(COMMAND ${bash_exe} -c "pacman-key --populate msys2")
	dk_killProcess(gpg-agent.exe NO_HALT)
endif()

if(NOT EXISTS "${msys2_DBPath}/sync")
	execute_process(COMMAND "${pacman_exe}" -Syu --noconfirm)
endif()
####################################

dk_FirewallAllow("pacman" "${pacman_exe}")

#dk_installPackage(pacman)
dk_assertPath(pacman_exe)
