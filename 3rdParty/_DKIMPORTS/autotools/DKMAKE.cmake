# http://autogen.sourceforge.net
# https://macappstore.org/autogen/
# https://www.xmodulo.com/fix-failed-to-run-aclocal.html
# https://thoughtbot.com/blog/the-magic-behind-configure-make-make-install

MAC_HOST_dk_queueCommand(brew install autogen)
MAC_HOST_dk_queueCommand(brew install autoconf)
MAC_HOST_dk_queueCommand(brew install automake)

if(MSYS2)
	#pacman -S mingw-w64-clang-i686-autotools		# CLANG32
	#pacman -S mingw-w64-clang-x86_64-autotools		# CLANG64
	#pacman -S mingw-w64-clang-aarch64-autotools	# CLANGARM64
	#pacman -S mingw-w64-i686-autotools				# MINGW32
	dk_msys2("pacman -S mingw-w64-x86_64-autotools --noconfirm")	# MINGW64
	#pacman -S mingw-w64-ucrt-x86_64-autotools		# UCRT64
	
	#dk_msys2("export ACLOCAL_PATH=${MSYS2}/usr/share/aclocal")
endif()
