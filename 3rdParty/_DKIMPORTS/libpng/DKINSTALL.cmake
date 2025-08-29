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


############ libpng ############
# https://github.com/glennrp/libpng
# http://www.libpng.org/pub/png/libpng.html

#dk_validate(Target_Config  "dk_Target_Config()")

### DEPEND ###
if(Emscripten)
	dk_depend(m)
endif()
dk_depend(zlib)


### IMPORT ###
#if(Mac)
#	#dk_import(https://github.com/glennrp/libpng.git)
#	dk_import(${libpng_Mac_Import})
#else()
#	dk_import(${libpng_Import} PATCH)
#endif()
dk_import()


### LINK ###
dk_define					(PNG_STATIC)
dk_include					(${LIBPNG}  															PNG_INCLUDE_DIR)
dk_include					(${LIBPNG_Config_Dir}													PNG_INCLUDE_DIR2)

if(MSVC)
	if(Android)
		dk_libDebug			(${LIBPNG_Debug_Dir}/libpng${LIBPNG_MAJOR}${LIBPNG_MINOR}d.a			PNG_LIBRARY_DEBUG)
		dk_libRelease		(${LIBPNG_Release_Dir}/libpng${LIBPNG_MAJOR}${LIBPNG_MINOR}.a			PNG_LIBRARY_RELEASE)
	endif()
	if(Windows)
		dk_libDebug			(${LIBPNG_Debug_Dir}/libpng${LIBPNG_MAJOR}${LIBPNG_MINOR}_staticd.lib	PNG_LIBRARY_DEBUG)
		dk_libRelease		(${LIBPNG_Release_Dir}/libpng${LIBPNG_MAJOR}${LIBPNG_MINOR}_static.lib	PNG_LIBRARY_RELEASE)
	endif()
elseif(Apple)
	dk_libDebug				(${LIBPNG_Debug_Dir}/libpng16d.a										PNG_LIBRARY_DEBUG)
	dk_libRelease			(${LIBPNG_Release_Dir}/libpng16d.a										PNG_LIBRARY_RELEASE)
else()
	dk_libDebug				(${LIBPNG_Debug_Dir}/libpng${LIBPNG_MAJOR}${LIBPNG_MINOR}d.a			PNG_LIBRARY_DEBUG)
	dk_libRelease			(${LIBPNG_Release_Dir}/libpng${LIBPNG_MAJOR}${LIBPNG_MINOR}.a			PNG_LIBRARY_RELEASE)
endif()


### 3RDPARTY LINK ###
if(MSVC)
	if(Windows)
		dk_set(LIBPNG_CMAKE 
		"-DCMAKE_C_FLAGS=/I${PNG_INCLUDE_DIR} /I${PNG_INCLUDE_DIR2}" 
		"-DCMAKE_CXX_FLAGS=/I${PNG_INCLUDE_DIR} /I${PNG_INCLUDE_DIR2}" 
		-DPNG_INCLUDE_DIR=${PNG_INCLUDE_DIR}
		-DPNG_INCLUDE_DIR2=${PNG_INCLUDE_DIR2} 
		-DPNG_PNG_INCLUDE_DIR=${PNG_INCLUDE_DIR2} 
		-DPNG_LIBRARY_DEBUG=${PNG_LIBRARY_DEBUG} 
		-DPNG_LIBRARY_RELEASE=${PNG_LIBRARY_RELEASE})
	
	elseif(Android)
		dk_set(LIBPNG_CMAKE 
		"-DCMAKE_CXX_FLAGS=-I${PNG_INCLUDE_DIR} -I${PNG_INCLUDE_DIR2}" 
		"-DCMAKE_C_FLAGS=-I${PNG_INCLUDE_DIR} -I${PNG_INCLUDE_DIR2}" 
		-DPNG_INCLUDE_DIR=${PNG_INCLUDE_DIR}
		-DPNG_INCLUDE_DIR2=${PNG_INCLUDE_DIR2} 
		-DPNG_LIBRARY_DEBUG=${PNG_LIBRARY_DEBUG} 
		-DPNG_LIBRARY_RELEASE=${PNG_LIBRARY_RELEASE}
		-DPNG_PNG_INCLUDE_DIR=${PNG_INCLUDE_DIR2})
	endif()
elseif(Apple)
	dk_set(LIBPNG_CMAKE 
	"-DCMAKE_C_FLAGS=-I${PNG_INCLUDE_DIR} -I${PNG_INCLUDE_DIR2}" 
	"-DCMAKE_CXX_FLAGS=-I${PNG_INCLUDE_DIR} -I${PNG_INCLUDE_DIR2}" 
	-DPNG_INCLUDE_DIR=${PNG_INCLUDE_DIR} 
	-DPNG_INCLUDE_DIR2=${PNG_INCLUDE_DIR2}
	-DPNG_LIBRARY_DEBUG=${PNG_LIBRARY_DEBUG} 
	-DPNG_LIBRARY_RELEASE=${PNG_LIBRARY_RELEASE})	
elseif(Raspberry)
	if(Debug)
		dk_set(LIBPNG_CMAKE 
		"-DCMAKE_CXX_FLAGS=-I${PNG_INCLUDE_DIR} -I${PNG_INCLUDE_DIR2}" 
		"-DCMAKE_C_FLAGS=-I${PNG_INCLUDE_DIR} -I${PNG_INCLUDE_DIR2}"  
		-DPNG_INCLUDE_DIR=${PNG_INCLUDE_DIR}
		-DPNG_INCLUDE_DIR2=${PNG_INCLUDE_DIR2}
		-DPNG_LIBRARY_DEBUG=${PNG_LIBRARY_DEBUG} 
		-DPNG_LIBRARY_RELEASE=${PNG_LIBRARY_RELEASE})
	endif()
	if(Release)
		dk_set(LIBPNG_CMAKE 
		"-DCMAKE_CXX_FLAGS=-I${PNG_INCLUDE_DIR} -I${PNG_INCLUDE_DIR2}" 
		"-DCMAKE_C_FLAGS=-I${PNG_INCLUDE_DIR} -I${PNG_INCLUDE_DIR2}" 
		-DPNG_INCLUDE_DIR=${PNG_INCLUDE_DIR}
		-DPNG_INCLUDE_DIR2=${PNG_INCLUDE_DIR2} 
		-DPNG_LIBRARY_DEBUG=${PNG_LIBRARY_DEBUG} 
		-DPNG_LIBRARY_RELEASE=${PNG_LIBRARY_RELEASE})
	endif()
else()
	if(Debug)
		dk_set(LIBPNG_CMAKE 
		"-DCMAKE_CXX_FLAGS=-I${PNG_INCLUDE_DIR} -I${PNG_INCLUDE_DIR2}"
		"-DCMAKE_C_FLAGS=-I${PNG_INCLUDE_DIR} -I${PNG_INCLUDE_DIR2}"
		"-DCMAKE_EXE_LINKER_FLAGS=${PNG_LIBRARY_DEBUG}"
		-DPNG_INCLUDE_DIR=${PNG_INCLUDE_DIR}
		-DPNG_INCLUDE_DIR2=${PNG_INCLUDE_DIR2}
		-DPNG_LIBRARY_DEBUG=${PNG_LIBRARY_DEBUG}
		-DPNG_LIBRARY_RELEASE=${PNG_LIBRARY_RELEASE})
	endif()
	if(Release)
		dk_set(LIBPNG_CMAKE 
		"-DCMAKE_CXX_FLAGS=-I${PNG_INCLUDE_DIR} -I${PNG_INCLUDE_DIR2}" 
		"-DCMAKE_C_FLAGS=-I${PNG_INCLUDE_DIR} -I${PNG_INCLUDE_DIR2}" 
		"-DCMAKE_EXE_LINKER_FLAGS=${PNG_LIBRARY_RELEASE}"
		-DPNG_INCLUDE_DIR=${PNG_INCLUDE_DIR} 
		-DPNG_INCLUDE_DIR2=${PNG_INCLUDE_DIR2}
		-DPNG_LIBRARY_DEBUG=${PNG_LIBRARY_DEBUG} 
		-DPNG_LIBRARY_RELEASE=${PNG_LIBRARY_RELEASE})
	endif()
endif()



### GENERATE ###
dk_configure(${LIBPNG}
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
	${ZLIB_CMAKE})  



### COMPILE ###
dk_build(${LIBPNG} png_static)

