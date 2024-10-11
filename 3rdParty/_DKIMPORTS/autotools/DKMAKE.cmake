#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://www.gnu.org/software/automake/manual/html_node/Autotools-Introduction.html
# http://autogen.sourceforge.net
# https://macappstore.org/autogen/
# https://www.xmodulo.com/fix-failed-to-run-aclocal.html
# https://thoughtbot.com/blog/the-magic-behind-configure-make-make-install



if(MAC_HOST)
	dk_queueCommand(brew install autogen)
	dk_queueCommand(brew install autoconf)
	dk_queueCommand(brew install automake)
endif()


if(CLANG OR MINGW OR UCRT)
	dk_depend(msys2)
	
	dk_installPackage(autotools)
	
	set(ENV{ACLOCAL_PATH} "${MSYS2_DIR}/usr/share/aclocal")
endif()

