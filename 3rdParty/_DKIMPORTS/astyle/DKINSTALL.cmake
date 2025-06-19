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


############ astyle ############

### IMPORT ###
dk_getFileParams	("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_import			(${ASTYLE_IMPORT})

### LINK ###
dk_validate			(Target_Tuple "dk_Target_Tuple()")
dk_include			(${ASTYLE}/src)

if(Windows)
	dk_libDebug		(${ASTYLE_DEBUG_DIR}/AStyleLib.a)
	dk_libRelease	(${ASTYLE_RELEASE_DIR}/AStyleLib.a)
else()
	dk_libDebug		(${ASTYLE_DEBUG_DIR}/libastyle.a)
	dk_libRelease	(${ASTYLE_RELEASE_DIR}/libastyle.a)
endif()


### GENERATE ###
dk_configure(${ASTYLE}
	-DBUILD_JAVA_LIBS=OFF 		# "Build java library"   OFF
	#-DBUILD_SHARED_LIBS=OFF 	# "Build shared library" OFF
	#-DBUILD_STATIC_LIBS=ON		# "Build static library" OFF
) 	

### COMPILE ###
dk_build(${ASTYLE})
