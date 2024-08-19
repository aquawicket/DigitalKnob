include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://wiki.archlinux.org/title/Pacman
# https://walterteng.com/using-zsh-on-windows


if(NOT UNIX)
	dk_depend(msys2)
	dk_findProgram(PACMAN_EXE pacman "${MSYS2}/usr/bin")
	dk_printVar(PACMAN_EXE)
	#dk_firewallAllow("pacman" "${PACMAN_EXE}")
endif()

dk_assert(PACMAN_EXE)