include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://www.gnu.org/software/automake/manual/html_node/Autotools-Introduction.html
# http://autogen.sourceforge.net
# https://macappstore.org/autogen/
# https://www.xmodulo.com/fix-failed-to-run-aclocal.html
# https://thoughtbot.com/blog/the-magic-behind-configure-make-make-install

MAC_HOST_dk_queueCommand(brew install autogen)
MAC_HOST_dk_queueCommand(brew install autoconf)
MAC_HOST_dk_queueCommand(brew install automake)

if(MSYSTEM)
	dk_depend(msys2)
	
	dk_remove(${MSYS2}/var/lib/pacman/db.lck NO_HALT)
	
	if(CLANG32)
		dk_command(${PACMAN_EXE} -S mingw-w64-clang-i686-autotools --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})		# CLANG32
	elseif(CLANG64)
		dk_command(${PACMAN_EXE} -S mingw-w64-clang-x86_64-autotools --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})	# CLANG64
	elseif(CLANGARM64)
		dk_command(${PACMAN_EXE} -S mingw-w64-clang-aarch64-autotools --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})	# CLANGARM64
	elseif(MINGW32)
		dk_command(${PACMAN_EXE} -S mingw-w64-i686-autotools --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})			# MINGW32
	elseif(MINGW64)
		dk_command(${PACMAN_EXE} -S mingw-w64-x86_64-autotools --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})			# MINGW64
	elseif(UCRT64)
		dk_command(${PACMAN_EXE} -S mingw-w64-ucrt-x86_64-autotools --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})		# UCRT64
	endif()
	
	set(ENV{ACLOCAL_PATH} "${MSYS2}/usr/share/aclocal")
endif()

