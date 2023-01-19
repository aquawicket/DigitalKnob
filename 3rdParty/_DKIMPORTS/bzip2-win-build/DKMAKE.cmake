# https://github.com/kiyolee/bzip2-win-build
# https://github.com/kiyolee/bzip2-win-build/archive/refs/tags/v1.0.8.zip

### OS CHECK ###
UNIX_dk_return()


### DEPEND ###
dk_depend(libgcc)
dk_depend(mingw32)
dk_depend(mingw64)
dk_depend(msys2)


### IMPORT ###
dk_import(https://github.com/kiyolee/bzip2-win-build.git BRANCH main)


### LINK ###
dk_include			(${BZIP2-WIN-BUILD})
WIN32_dk_libDebug	(${BZIP2-WIN-BUILD}/${OS}/${DEBUG_DIR}/libbz2-static.lib)
WIN32_dk_libRelease	(${BZIP2-WIN-BUILD}/${OS}/${RELEASE_DIR}/libbz2-static.lib)
WIN64_dk_libDebug	(${BZIP2-WIN-BUILD}/${OS}/x64/${DEBUG_DIR}/libbz2-static.lib)
WIN64_dk_libRelease	(${BZIP2-WIN-BUILD}/${OS}/x64/${RELEASE_DIR}/libbz2-static.lib)


### 3RDPARTY LINK ###
WIN_dk_set(BZIP2-WIN-BUILD_CMAKE -DBZIP2_INCLUDE_DIR=${BZIP2-WIN-BUILD} -DBZIP2_LIBRARY_DEBUG=${BZIP2-WIN-BUILD}/${OS}/${DEBUG_DIR}/libbz2-static.lib -DBZIP2_LIBRARY_RELEASE=${BZIP2-WIN-BUILD}/${OS}/${RELEASE_DIR}/libbz2-static.lib)
	
	
### COMPILE ###
if(WIN_32)
	dk_define		(BZ_NO_STDIO)
	dk_copy			(${BZIP2-WIN-BUILD}/build-VS2022 ${BZIP2-WIN-BUILD}/${OS})
	dkFileReplace	(${BZIP2-WIN-BUILD}/${OS}/bzip2-static/bzip2-static.vcxproj "v142" "v143")
	dkFileReplace	(${BZIP2-WIN-BUILD}/${OS}/libbz2-static/libbz2-static.vcxproj "v142" "v143")
	dk_setPath		(${BZIP2-WIN-BUILD}/${OS})
	dk_build		(${BZIP2-WIN-BUILD} libbz2-static)
endif()


if(WIN_64)
	dk_copy			(${BZIP2-WIN-BUILD}/win32/bzip2.rc ${BZIP2-WIN-BUILD}/${OS}/bzip2.rc) #copy project files that came with bzip
	dk_copy			(${BZIP2-WIN-BUILD}/win32/bzip2recover.rc ${BZIP2-WIN-BUILD}/${OS}/bzip2recover.rc)
	dk_copy			(${BZIP2-WIN-BUILD}/win32/bzip2_version.h ${BZIP2-WIN-BUILD}/${OS}/bzip2_version.h)
	dk_copy			(${BZIP2-WIN-BUILD}/win32/libbz2.rc ${BZIP2-WIN-BUILD}/${OS}/libbz2.rc)
	dk_copy			(${BZIP2-WIN-BUILD}/build-VS2022 ${BZIP2-WIN-BUILD}/${OS})
	dkFileReplace	(${BZIP2-WIN-BUILD}/${OS}/bzip2-static/bzip2-static.vcxproj "v142" "v143")
	dkFileReplace	(${BZIP2-WIN-BUILD}/${OS}/libbz2-static/libbz2-static.vcxproj "v142" "v143")
	dk_setPath		(${BZIP2-WIN-BUILD}/${OS})
	dk_build		(${BZIP2-WIN-BUILD} libbz2-static x64)
endif()
