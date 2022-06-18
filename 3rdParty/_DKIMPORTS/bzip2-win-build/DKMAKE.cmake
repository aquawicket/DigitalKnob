# https://github.com/kiyolee/bzip2-win-build

# https://github.com/kiyolee/bzip2-win-build/archive/refs/tags/v1.0.8.zip
if(NOT WIN)
	return()
endif()

DKDEPEND(mingw32)
DKDEPEND(mingw64)
DKDEPEND(msys2)
DKDEPEND(libgcc)

DKIMPORT(https://github.com/kiyolee/bzip2-win-build.git)
#DKIMPORT(https://github.com/kiyolee/bzip2-win-build/archive/c0242ad14ecc4e8c04e72bc6c980393be80e7bbd.zip)


#if(NOT EXISTS ${BZIP2-WIN-BUILD}/copy)
#	DKCOPY(${BZIP2-WIN-BUILD} ${BZIP2-WIN-BUILD}/copy TRUE)
#endif()


### DKPLUGINS LINK ###
DKINCLUDE(${BZIP2-WIN-BUILD})
WIN32_DEBUG_DKLIB(${BZIP2-WIN-BUILD}/${OS}/${DEBUG_DIR}/libbz2-static.lib)
WIN32_RELEASE_DKLIB(${BZIP2-WIN-BUILD}/${OS}/${RELEASE_DIR}/libbz2-static.lib)
WIN64_DEBUG_DKLIB(${BZIP2-WIN-BUILD}/${OS}/x64/${DEBUG_DIR}/libbz2-static.lib)
WIN64_RELEASE_DKLIB(${BZIP2-WIN-BUILD}/${OS}/x64/${RELEASE_DIR}/libbz2-static.lib)



### 3RDPARTY LINK ###
WIN_DKSET(BZIP2-WIN-BUILD_CMAKE -DBZIP2_INCLUDE_DIR=${BZIP2-WIN-BUILD} -DBZIP2_LIBRARY_DEBUG=${BZIP2-WIN-BUILD}/${OS}/${DEBUG_DIR}/libbz2-static.lib -DBZIP2_LIBRARY_RELEASE=${BZIP2-WIN-BUILD}/${OS}/${RELEASE_DIR}/libbz2-static.lib)
	
### COMPILE ###
if(WIN_32)
	DKDEFINE(BZ_NO_STDIO)
	DKCOPY(${BZIP2-WIN-BUILD}/build-VS2019 ${BZIP2-WIN-BUILD}/${OS} FALSE)
	dkFileReplace(${BZIP2-WIN-BUILD}/${OS}/bzip2-static/bzip2-static.vcxproj "v142" "v143")
	dkFileReplace(${BZIP2-WIN-BUILD}/${OS}/libbz2-static/libbz2-static.vcxproj "v142" "v143")
	WIN32_DKSETPATH(${BZIP2-WIN-BUILD}/${OS})
	WIN32_VS(${BZIP2-WIN-BUILD_NAME} bzip2.sln libbz2-static)
endif()


if(WIN_64)
	DKCOPY(${BZIP2-WIN-BUILD}/win32/bzip2.rc ${BZIP2-WIN-BUILD}/${OS}/bzip2.rc FALSE) #copy project files that came with bzip
	DKCOPY(${BZIP2-WIN-BUILD}/win32/bzip2recover.rc ${BZIP2-WIN-BUILD}/${OS}/bzip2recover.rc FALSE)
	DKCOPY(${BZIP2-WIN-BUILD}/win32/bzip2_version.h ${BZIP2-WIN-BUILD}/${OS}/bzip2_version.h FALSE)
	DKCOPY(${BZIP2-WIN-BUILD}/win32/libbz2.rc ${BZIP2-WIN-BUILD}/${OS}/libbz2.rc FALSE)
	DKCOPY(${BZIP2-WIN-BUILD}/build-VS2019 ${BZIP2-WIN-BUILD}/${OS} FALSE)
	dkFileReplace(${BZIP2-WIN-BUILD}/${OS}/bzip2-static/bzip2-static.vcxproj "v142" "v143")
	dkFileReplace(${BZIP2-WIN-BUILD}/${OS}/libbz2-static/libbz2-static.vcxproj "v142" "v143")
	WIN64_DKSETPATH(${BZIP2-WIN-BUILD}/${OS})
	WIN64_VS(${BZIP2-WIN-BUILD_NAME} bzip2.sln libbz2-static x64)
endif()
