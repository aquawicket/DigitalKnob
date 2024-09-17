include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://wiki.archlinux.org/title/Pacman
# https://walterteng.com/using-zsh-on-windows


if(EXISTS ${PACMAN_EXE})
	dk_return()
endif()




dk_validate(HOST_TRIPLE "dk_getHostTriple()")
if(NOT WIN_HOST)
	dk_undepend(pacman)
	dk_return()
endif()


dk_validate(MSYS2 "dk_depend(msys2)")
dk_findProgram(PACMAN_EXE pacman "${MSYS2}/usr/bin")
#dk_printVar(PACMAN_EXE)
#dk_firewallAllow("pacman" "${PACMAN_EXE}")
	
dk_assert(PACMAN_EXE)  # change to assertPath
