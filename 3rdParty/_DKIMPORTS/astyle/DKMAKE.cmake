#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


###### astyle ######
# http://astyle.sourceforge.net
# https://sourceforge.net/projects/astyle/files/latest/download
# https://managedway.dl.sourceforge.net/project/astyle/astyle/astyle%203.1/AStyle_3.1_windows.zip
# https://svn.code.sf.net/p/astyle/code/trunk astyle-code

### IMPORT ###
dk_validate(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
dk_getFileParam(${DKIMPORTS_DIR}/astyle/dkconfig.txt ASTYLE_DL)
dk_import(${ASTYLE_DL})

### LINK ###
dk_validate(target_triple "dk_target_triple()")
dk_include			(${ASTYLE_DIR}/src)

if(WIN)
	dk_libDebug		(${ASTYLE_DEBUG_DIR}/AStyleLib.a)
	dk_libRelease	(${ASTYLE_RELEASE_DIR}/AStyleLib.a)
else()
	dk_libDebug		(${ASTYLE_DEBUG_DIR}/libastyle.a)
	dk_libRelease	(${ASTYLE_RELEASE_DIR}/libastyle.a)
endif()


### GENERATE ###
dk_configure(${ASTYLE_DIR}
	-DBUILD_JAVA_LIBS=OFF 		# "Build java library"   OFF
	#-DBUILD_SHARED_LIBS=OFF 	# "Build shared library" OFF
	#-DBUILD_STATIC_LIBS=ON		# "Build static library" OFF
) 	

### COMPILE ###
dk_build(${ASTYLE_DIR})
