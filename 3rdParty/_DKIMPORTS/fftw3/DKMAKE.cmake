#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ fftw3 ############
# https://github.com/FFTW/fftw3.git
dk_load(dk_builder)

### IMPORT ###
dk_validate			(DKIMPORTS_DIR "dk_DKBRANCH_DIR()")
dk_getFileParam 	("${DKIMPORTS_DIR}/fftw3/fftw3.txt" FFTW3_DL)
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
dk_configure(${FFTW3_DIR})
	BUILD_TESTS=OFF				#"Build tests" ON
	ENABLE_OPENMP=ON 			#"Use OpenMP for multithreading" OFF
	ENABLE_THREADS=ON 			#"Use pthread for multithreading" OFF
	WITH_COMBINED_THREADS=ON 	#"Merge thread library" OFF
	ENABLE_FLOAT=ON 			#"single-precision" OFF
	ENABLE_LONG_DOUBLE=ON 		#"long-double precision" OFF
	ENABLE_QUAD_PRECISION=ON 	#"quadruple-precision" OFF
	ENABLE_SSE=ON 				#"Compile with SSE instruction set support" OFF
	ENABLE_SSE2=ON		 		#"Compile with SSE2 instruction set support" OFF
	ENABLE_AVX=ON 				#"Compile with AVX instruction set support" OFF
	ENABLE_AVX2=ON 				#"Compile with AVX2 instruction set support" OFF
	DISABLE_FORTRAN=ON) 		#"Disable Fortran wrapper routines" OFF

### COMPILE ###
dk_build(${FFTW3_DIR})# fftw3)
