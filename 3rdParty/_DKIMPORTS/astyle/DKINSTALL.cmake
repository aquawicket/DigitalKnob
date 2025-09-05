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


###### astyle ######
# http://astyle.sourceforge.net
# https://sourceforge.net/projects/astyle/files/latest/download
# https://managedway.dl.sourceforge.net/project/astyle/astyle/astyle%203.1/AStyle_3.1_windows.zip
# https://svn.code.sf.net/p/astyle/code/trunk astyle-code

### IMPORT ###
dk_import()

### LINK ###
dk_include			(${astyle}/src)

if(Windows)
	dk_libDebug		(${astyle_Debug_Dir}/AStyleLib.a)
	dk_libRelease	(${astyle_Release_Dir}/AStyleLib.a)
else()
	dk_libDebug		(${astyle_Debug_Dir}/libastyle.a)
	dk_libRelease	(${astyle_Release_Dir}/libastyle.a)
endif()


### GENERATE ###
dk_configure(${astyle}
	-DBUILD_JAVA_LIBS=OFF 		# "Build java library"   OFF
	#-DBUILD_SHARED_LIBS=OFF 	# "Build shared library" OFF
	#-DBUILD_STATIC_LIBS=ON		# "Build static library" OFF
) 	

### COMPILE ###
dk_build()
