# http://autogen.sourceforge.net
# https://macappstore.org/autogen/
# https://www.xmodulo.com/fix-failed-to-run-aclocal.html
# https://thoughtbot.com/blog/the-magic-behind-configure-make-make-install

MAC_HOST_dk_queueCommand(brew install autogen)
MAC_HOST_dk_queueCommand(brew install autoconf)
MAC_HOST_dk_queueCommand(brew install automake)

if(MSYSTEM)
	dk_depend(msys2)
	
	if(CLANG32)
		dk_msys2("pacman -S mingw-w64-clang-i686-autotools --noconfirm")	# CLANG32
	elseif(CLANG64)
		dk_msys2("pacman -S mingw-w64-clang-x86_64-autotools --noconfirm")	# CLANG64
	elseif(CLANGARM64)
		dk_msys2("pacman -S mingw-w64-clang-aarch64-autotools --noconfirm")	# CLANGARM64
	elseif(MINGW32)
		dk_msys2("pacman -S mingw-w64-i686-autotools --noconfirm")			# MINGW32
	elseif(MINGW64)
		dk_msys2("pacman -S mingw-w64-x86_64-autotools --noconfirm")		# MINGW64
	elseif(UCRT64)
		dk_msys2("pacman -S mingw-w64-ucrt-x86_64-autotools --noconfirm")	# UCRT64
	else()
		dk_error("MSYSTEM is invalid")
	endif()
	
	dk_set(GCC_EXE gcc)
	dk_msys2(${GCC_EXE} --version)
	dk_debug("GCC_EXE = ${GCC_EXE}")
	return()
endif()
