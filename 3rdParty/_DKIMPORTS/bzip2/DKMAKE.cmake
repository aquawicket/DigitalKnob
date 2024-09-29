#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://www.sourceware.org/bzip2
# https://gitlab.com/bzip2/bzip2
# https://github.com/kiyolee/bzip2-win-build
# https://github.com/kiyolee/bzip2-win-build/archive/refs/tags/v1.0.8.zip
# https://gitlab.com/bzip2/bzip2/-/archive/bzip2-1.0.8/bzip2-bzip2-1.0.8.zip
# https://gist.github.com/DanAlbert/c7b6b2d93d4f6d672707803a6715095e			# ANDROID COMPILE


### DEPEND ###
#dk_depend(libgcc)
dk_depend(python3)
dk_depend(msys2)


### IMPORT ###
#dk_import(https://gitlab.com/bzip2/bzip2.git)
dk_import(https://gitlab.com/bzip2/bzip2/-/archive/master/bzip2-master.zip)




set(BZIP2_USE_CMAKE 1)
if(BZIP2_USE_CMAKE)
	dk_include(${BZIP2_DIR}/									BZIP2_INCLUDE_DIR)

	dk_libDebug		(${BZIP2_DEBUG_DIR}/libbz2_static.a			BZIP2_LIBRARY_DEBUG)
	dk_libRelease	(${BZIP2_RELEASE_DIR}/libbz2_static.a		BZIP2_LIBRARY_RELEASE)


	### 3RDPARTY LINK ###
	dk_set(BZIP2_CMAKE -DBZIP2_INCLUDE_DIR=${BZIP2_INCLUDE_DIR} -DBZIP2_LIBRARY_DEBUG=${BZIP2_LIBRARY_DEBUG} -DBZIP2_LIBRARY_RELEASE=${BZIP2_LIBRARY_RELEASE})
	
	### CONFIGURE ###
	if(LINUX_HOST)
		dk_configure(${BZIP2_DIR} -DENABLE_SHARED_LIB=OFF -DENABLE_STATIC_LIB=ON)
	else()
		dk_configure(${BZIP2_DIR} -DENABLE_SHARED_LIB=OFF -DENABLE_STATIC_LIB=ON ${PYTHON3_CMAKE}) #-DPython3_EXECUTABLE=${PYTHON3_EXE})
	endif()
	
	### COMPILE ###
	#dk_build(${BZIP2} ${PYTHON3_CMAKE})
	dk_build(${BZIP2_DIR})
	
else()
	if(NOT EXISTS ${BZIP2_DIR}/copy)
		dk_copy(${BZIP2_DIR} ${BZIP2_DIR}/copy OVERWRITE)
	endif()

	### LINK ###
	dk_include(${BZIP2_TRIPLE_DIR}															BZIP2_INCLUDE_DIR)
	if(MSVC)
		WIN_X86_dk_libDebug		(${BZIP2_DEBUG_DIR}/libbz2-static.lib						BZIP2_LIBRARY_DEBUG)
		WIN_X86_dk_libRelease	(${BZIP2_RELEASE_DIR}/libbz2-static.lib						BZIP2_LIBRARY_RELEASE)
		WIN_X86_64_dk_libDebug	(${BZIP2_TRIPLE_DIR}/x64/${DEBUG_DIR}/libbz2-static.lib		BZIP2_LIBRARY_DEBUG)
		WIN_X86_64_dk_libRelease(${BZIP2_TRIPLE_DIR}/x64/${RELEASE_DIR}/libbz2-static.lib	BZIP2_LIBRARY_RELEASE)
	else()
		dk_libDebug				(${BZIP2_TRIPLE_DIR}/libbz2.a								BZIP2_LIBRARY_DEBUG)
		dk_libRelease			(${BZIP2_TRIPLE_DIR}/libbz2.a								BZIP2_LIBRARY_RELEASE)
	endif()


	### 3RDPARTY LINK ###
	dk_set(BZIP2_CMAKE -DBZIP2_INCLUDE_DIR=${BZIP2_INCLUDE_DIR} -DBZIP2_LIBRARY_DEBUG=${BZIP2_LIBRARY_DEBUG} -DBZIP2_LIBRARY_RELEASE=${BZIP2_LIBRARY_RELEASE})


	### COMPILE ###
	if(MSVC)
		if(WIN_X86)
			dk_define	(BZ_NO_STDIO)
			dk_copy		(${BZIP2_DIR}/build-VS2019 ${BZIP2_TRIPLE_DIR})
			dk_cd		(${BZIP2_TRIPLE_DIR})
			dk_build	(${BZIP2_DIR} libbz2-static)
		endif()

		if(WIN_X86_64)
			dk_copy		(${BZIP2_DIR}/win32/bzip2.rc ${BZIP2_TRIPLE_DIR}/bzip2.rc) #copy project files that came with bzip
			dk_copy		(${BZIP2_DIR}/win32/bzip2recover.rc ${BZIP2_TRIPLE_DIR}/bzip2recover.rc)
			dk_copy		(${BZIP2_DIR}/win32/bzip2_version.h ${BZIP2_TRIPLE_DIR}/bzip2_version.h)
			dk_copy		(${BZIP2_DIR}/win32/libbz2.rc ${BZIP2_TRIPLE_DIR}/libbz2.rc)
			dk_copy		(${BZIP2_DIR}/build-VS2019 ${BZIP2_TRIPLE_DIR})
			dk_cd		(${BZIP2_TRIPLE_DIR})
			dk_build	(${BZIP2_DIR} libbz2-static x64)
		endif()
	else()
		if(NOT EXISTS ${BZIP2}/${triple}/bzip2.c)
			dk_copy		(${BZIP2_DIR}/copy ${BZIP2_TRIPLE_DIR} OVERWRITE)
			dk_sleep(2) # wait 2 seconds for files to copy over
		endif()
		dk_cd			(${BZIP2_TRIPLE_DIR})
		dk_build		(${BZIP2_DIR} libbz2.a)
	endif()
endif()
