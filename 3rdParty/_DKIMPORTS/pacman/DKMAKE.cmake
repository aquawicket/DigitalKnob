#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://wiki.archlinux.org/title/Pacman
# https://walterteng.com/using-zsh-on-windows


if(EXISTS ${PACMAN_EXE})
	dk_return()
endif()

dk_validate(host_triple "dk_host_triple()")
if(NOT WIN_HOST)
	dk_undepend(pacman)
	dk_return()
endif()


dk_validate(MSYS2 "dk_depend(msys2)")
dk_findProgram(PACMAN_EXE pacman "${MSYS2_DIR}/usr/bin")
#dk_printVar(PACMAN_EXE)
#dk_firewallAllow("pacman" "${PACMAN_EXE}")
	
dk_assertPath(PACMAN_EXE)  # change to assertPath
