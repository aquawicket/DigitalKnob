#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


###### autotools ######
# https://www.gnu.org/software/automake/manual/html_node/Autotools-Introduction.html
# http://autogen.sourceforge.net
# https://macappstore.org/autogen/
# https://www.xmodulo.com/fix-failed-to-run-aclocal.html
# https://thoughtbot.com/blog/the-magic-behind-configure-make-make-install

dk_validate(Target_Tuple "dk_Target_Tuple()")
if(Mac_Host)
	dk_depend			(autogen)
	dk_depend			(autoconf)
	dk_depend			(automake)
elseif(NOT Msvc)
	dk_installPackage	(autotools)
	dk_validate			(MSYS2 "dk_depend(msys2)")
	set					(ENV{ACLOCAL_PATH} "${MSYS2}/usr/share/aclocal")
	dk_set				(AUTORECONF "${MSYS2}/usr/bin/autoreconf")
endif()

