#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


############ libpng ############
# https://github.com/glennrp/libpng
# http://www.libpng.org/pub/png/libpng.html

### DEPEND ###
if(Emscripten)
	dk_depend(m)
endif()
dk_depend(zlib)


### IMPORT ###
dk_import()


### LINK ###
dk_define			(PNG_STATIC)
dk_include			(${libpng}  																PNG_INCLUDE_DIR)
dk_include			(${libpng_Config_Dir}														PNG_INCLUDE_DIR2)

if(Windows AND MSVC)
	dk_libDebug		("${libpng_Debug_Dir}/libpng16_staticd.lib"									PNG_LIBRARY_DEBUG		PNG_LIBRARY)
	dk_libRelease	("${libpng_Release_Dir}/libpng16_static.lib"								PNG_LIBRARY_RELEASE		PNG_LIBRARY)
	#dk_libDebug	("${libpng_Debug_Dir}/libpng${libpng_Major}${libpng_Minor}_staticd.lib"		PNG_LIBRARY_DEBUG		PNG_LIBRARY)
	#dk_libRelease	("${libpng_Release_Dir}/libpng${libpng_Major}${libpng_Minor}_static.lib"	PNG_LIBRARY_RELEASE		PNG_LIBRARY)
else()
	dk_libDebug		("${libpng_Debug_Dir}/libpng16.a"											PNG_LIBRARY_DEBUG		PNG_LIBRARY)
	dk_libRelease	("${libpng_Release_Dir}/libpng16.a"											PNG_LIBRARY_RELEASE		PNG_LIBRARY)
	#dk_libDebug	("${libpng_Debug_Dir}/libpng${libpng_Major}${libpng_Minor}d.a"				PNG_LIBRARY_DEBUG		PNG_LIBRARY)
	#dk_libRelease	("${libpng_Release_Dir}/libpng${libpng_Major}${libpng_Minor}.a"				PNG_LIBRARY_RELEASE		PNG_LIBRARY)
endif()


### 3RDPARTY LINK ###
dk_set(libpng_CMAKE 
	-DPNG_INCLUDE_DIR=${PNG_INCLUDE_DIR}
	-DPNG_INCLUDE_DIR2=${PNG_INCLUDE_DIR2} 
	-DPNG_LIBRARY=${PNG_LIBRARY}
	-DPNG_LIBRARY_DEBUG=${PNG_LIBRARY_DEBUG} 
	-DPNG_LIBRARY_RELEASE=${PNG_LIBRARY_RELEASE}
	-DPNG_PNG_INCLUDE_DIR=${PNG_INCLUDE_DIR2})
	
if(Windows AND MSVC)
	dk_append(libpng_CMAKE 
		"-DCMAKE_C_FLAGS=/I${PNG_INCLUDE_DIR} /I${PNG_INCLUDE_DIR2}" 
		"-DCMAKE_CXX_FLAGS=/I${PNG_INCLUDE_DIR} /I${PNG_INCLUDE_DIR2}")
else()
	dk_append(libpng_CMAKE 
		"-DCMAKE_CXX_FLAGS=-I${PNG_INCLUDE_DIR} -I${PNG_INCLUDE_DIR2}" 
		"-DCMAKE_C_FLAGS=-I${PNG_INCLUDE_DIR} -I${PNG_INCLUDE_DIR2}")
endif()	
			




### GENERATE ###
dk_configure(${libpng}
	-DPNG_BUILD_ZLIB=OFF 			# "Custom zlib Location, otherwise find_package is used" OFF
	-DPNG_STATIC=ON					# "Build shared lib" ON
	-DPNG_SHARED=OFF				# "Build static lib" ON
	-DPNG_TESTS=OFF 				# "Build libpng tests" ON
	-DPNG_FRAMEWORK=OFF				# "Build OS X framework" OFF
	-DPNG_DEBUG=OFF    				# "Build with debug output" OFF
	-DPNGARG=OFF       				# "Disable ANSI-C prototypes" OFF
	-DPNG_HARDWARE_OPTIMIZATIONS=ON	# "Enable Hardware Optimizations" ON
	#-DPNG_PREFIX="" 				# "Prefix to add to the API function names"
	#-DDFA_XTRA=""					# "File containing extra configuration settings"
	-Dld-version-script=ON			# "Enable linker version script" ON
	-DSKIP_INSTALL_LIBRARIES=ON 
	-DSKIP_INSTALL_ALL=ON
	${zlib_CMAKE})  



### COMPILE ###
dk_build(${libpng} png_static)

