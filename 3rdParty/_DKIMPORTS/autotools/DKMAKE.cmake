# http://autogen.sourceforge.net
# https://macappstore.org/autogen/
# https://www.xmodulo.com/fix-failed-to-run-aclocal.html
# https://thoughtbot.com/blog/the-magic-behind-configure-make-make-install

MAC_HOST_dk_queueCommand(brew install autogen)
MAC_HOST_dk_queueCommand(brew install autoconf)
MAC_HOST_dk_queueCommand(brew install automake)
if(MSYS)
	dk_msys2("export ACLOCAL_PATH=${MSYS2}/usr/share/aclocal")
	dk_msys2("pacman -S mingw-w64-x86_64-autotools --noconfirm")	# MINGW64
endif()
