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


############ fftw3 ############
# https://github.com/FFTW/fftw3.git
dk_validate(Target_Config  "dk_Target_Config()")

### IMPORT ###
dk_getFileParams	("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_import			(${FFTW3_DL})

### LINK ###
dk_include			(${FFTW3}/include)
if(MSVC)
	dk_libDebug		(${FFTW3.Debug_Dir}/fftw3.lib)
	dk_libRelease	(${FFTW3.Release_Dir}/fftw3.lib)
else()
	dk_libDebug		(${FFTW3.Debug_Dir}/libfftw3.a)
	dk_libRelease	(${FFTW3.Release_Dir}/libfftw3.a)
endif()

### GENERATE ###
dk_configure(${FFTW3}
	-DBUILD_TESTS=OFF				# "Build tests" ON
	-DENABLE_OPENMP=OFF				# "Use OpenMP for multithreading" OFF
	-DENABLE_THREADS=OFF 			# "Use pthread for multithreading" OFF
	-DWITH_COMBINED_THREADS=OFF		# "Merge thread library" OFF
	-DENABLE_FLOAT=OFF 				# "single-precision" OFF
	-DENABLE_LONG_DOUBLE=OFF 		# "long-double precision" OFF
	-DENABLE_QUAD_PRECISION=OFF		# "quadruple-precision" OFF
	-DENABLE_SSE=OFF 				# "Compile with SSE instruction set support" OFF
	-DENABLE_SSE2=OFF		 		# "Compile with SSE2 instruction set support" OFF
	-DENABLE_AVX=OFF 				# "Compile with AVX instruction set support" OFF
	-DENABLE_AVX2=OFF 				# "Compile with AVX2 instruction set support" OFF
	-DDISABLE_FORTRAN=OFF) 			# "Disable Fortran wrapper routines" OFF

### COMPILE ###
dk_build()
