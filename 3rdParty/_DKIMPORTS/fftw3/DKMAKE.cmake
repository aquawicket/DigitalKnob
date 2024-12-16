#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ fftw3 ############
# https://github.com/FFTW/fftw3.git
dk_load(dk_builder)

### IMPORT ###
dk_validate			(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
dk_getFileParam 	("${DKIMPORTS_DIR}/fftw3/dkconfig.txt" FFTW3_DL)
dk_import			(${FFTW3_DL})

### LINK ###
dk_include			(${FFTW3_DIR}/include)
if(MSVC)
	dk_libDebug		(${FFTW3_DEBUG_DIR}/fftw3.lib)
	dk_libRelease	(${FFTW3_RELEASE_DIR}/fftw3.lib)
else()
	dk_libDebug		(${FFTW3_DEBUG_DIR}/libfftw3.a)
	dk_libRelease	(${FFTW3_RELEASE_DIR}/libfftw3.a)
endif()

### GENERATE ###
dk_configure(${FFTW3_DIR}
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
dk_build(${FFTW3_DIR})# fftw3)
