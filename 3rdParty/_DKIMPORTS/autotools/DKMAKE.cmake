#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### autotools ######
# https://www.gnu.org/software/automake/manual/html_node/Autotools-Introduction.html
# http://autogen.sourceforge.net
# https://macappstore.org/autogen/
# https://www.xmodulo.com/fix-failed-to-run-aclocal.html
# https://thoughtbot.com/blog/the-magic-behind-configure-make-make-install

if(MAC_HOST)
	#dk_queueCommand	(brew install autogen)
	#dk_queueCommand	(brew install autoconf)
	#dk_queueCommand	(brew install automake)
	dk_depend(autogen)
	dk_depend(autoconf)
	dk_depend(automake)
elseif(CLANG OR MINGW OR UCRT)
	dk_installPackage	(autotools)
	dk_validate(MSYS2 "dk_depend(msys2)")
	set					(ENV{ACLOCAL_PATH} "${MSYS2}/usr/share/aclocal")
	
	dk_set(AUTORECONF "${MSYS2}/usr/bin/autoreconf")
endif()

