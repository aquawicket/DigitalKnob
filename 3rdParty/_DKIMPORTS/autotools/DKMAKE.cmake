#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://www.gnu.org/software/automake/manual/html_node/Autotools-Introduction.html
# http://autogen.sourceforge.net
# https://macappstore.org/autogen/
# https://www.xmodulo.com/fix-failed-to-run-aclocal.html
# https://thoughtbot.com/blog/the-magic-behind-configure-make-make-install



dk_depend(pacman)

MAC_HOST_dk_queueCommand(brew install autogen)
MAC_HOST_dk_queueCommand(brew install autoconf)
MAC_HOST_dk_queueCommand(brew install automake)


if(CLANG OR MINGW OR UCRT)
	dk_depend(msys2)
	
	dk_delete(${MSYS2_DIR}/var/lib/pacman/db.lck NO_HALT)
	
	if(win_x86_clang)
		dk_command(${PACMAN_EXE} -S mingw-w64-clang-i686-autotools --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})		# CLANG32
	elseif(win_x86_64_clang)	
		dk_command(${PACMAN_EXE} -S mingw-w64-clang-x86_64-autotools --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})	# CLANG64
	elseif(win_arm64_clang)
		dk_command(${PACMAN_EXE} -S mingw-w64-clang-aarch64-autotools --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})	# CLANGARM64
	elseif(win_x86_mingw)
		dk_command(${PACMAN_EXE} -S mingw-w64-i686-autotools --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})			# MINGW32
	elseif(win_x86_64_mingw)
		dk_command(${PACMAN_EXE} -S mingw-w64-x86_64-autotools --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})			# MINGW64
	elseif(win_x86_64_ucrt)
		dk_command(${PACMAN_EXE} -S mingw-w64-ucrt-x86_64-autotools --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})		# UCRT64
	endif()
	
	set(ENV{ACLOCAL_PATH} "${MSYS2_DIR}/usr/share/aclocal")
endif()

