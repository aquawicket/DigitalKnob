# https://www.sourceware.org/bzip2
# https://gitlab.com/bzip2/bzip2
# https://github.com/kiyolee/bzip2-win-build
# https://github.com/kiyolee/bzip2-win-build/archive/refs/tags/v1.0.8.zip
# https://gitlab.com/bzip2/bzip2/-/archive/bzip2-1.0.8/bzip2-bzip2-1.0.8.zip
# https://gist.github.com/DanAlbert/c7b6b2d93d4f6d672707803a6715095e			# ANDROID COMPILE


### DEPEND ###
#dk_depend(libgcc)
dk_depend(msys2)


### IMPORT ###
UNIX_dk_import	(ftp://sourceware.org/pub/bzip2/bzip2-1.0.8.tar.gz)
WIN_dk_import	(https://github.com/kiyolee/bzip2-win-build/archive/refs/tags/v1.0.8.zip)
if(NOT EXISTS ${BZIP2}/copy)
	dk_copy(${BZIP2} ${BZIP2}/copy OVERWRITE)
endif()


### LINK ###
dk_include(${BZIP2}/${OS}																BZIP2_INCLUDE_DIR)
if(MSVC)
	WIN_X86_dk_libDebug		(${BZIP2}/${OS}/${DEBUG_DIR}/libbz2-static.lib				BZIP2_LIBRARY_DEBUG)
	WIN_X86_dk_libRelease	(${BZIP2}/${OS}/${RELEASE_DIR}/libbz2-static.lib			BZIP2_LIBRARY_RELEASE)
	WIN_X86_64_dk_libDebug	(${BZIP2}/${OS}/x64/${DEBUG_DIR}/libbz2-static.lib			BZIP2_LIBRARY_DEBUG)
	WIN_X86_64_dk_libRelease(${BZIP2}/${OS}/x64/${RELEASE_DIR}/libbz2-static.lib		BZIP2_LIBRARY_RELEASE)
else()
	dk_libDebug				(${BZIP2}/${OS}/libbz2.a									BZIP2_LIBRARY_DEBUG)
	dk_libRelease			(${BZIP2}/${OS}/libbz2.a									BZIP2_LIBRARY_RELEASE)
endif()


### 3RDPARTY LINK ###
dk_set(BZIP2_CMAKE -DBZIP2_INCLUDE_DIR=${BZIP2_INCLUDE_DIR} -DBZIP2_LIBRARY_DEBUG=${BZIP2_LIBRARY_DEBUG} -DBZIP2_LIBRARY_RELEASE=${BZIP2_LIBRARY_RELEASE})


### COMPILE ###
if(MSVC)
	if(WIN_X86)
		dk_define	(BZ_NO_STDIO)
		dk_copy		(${BZIP2}/build-VS2019 ${BZIP2}/${OS})
		dk_setPath	(${BZIP2}/${OS})
		dk_build	(${BZIP2} libbz2-static)
	endif()

	if(WIN_X86_64)
		dk_copy		(${BZIP2}/win32/bzip2.rc ${BZIP2}/${OS}/bzip2.rc) #copy project files that came with bzip
		dk_copy		(${BZIP2}/win32/bzip2recover.rc ${BZIP2}/${OS}/bzip2recover.rc)
		dk_copy		(${BZIP2}/win32/bzip2_version.h ${BZIP2}/${OS}/bzip2_version.h)
		dk_copy		(${BZIP2}/win32/libbz2.rc ${BZIP2}/${OS}/libbz2.rc)
		dk_copy		(${BZIP2}/build-VS2019 ${BZIP2}/${OS})
		dk_setPath	(${BZIP2}/${OS})
		dk_build	(${BZIP2} libbz2-static x64)
	endif()
else()
	if(NOT EXISTS ${BZIP2}/${OS}/bzip2.c)
		dk_copy		(${BZIP2}/copy ${BZIP2}/${OS} OVERWRITE)
	endif()
	dk_setPath		(${BZIP2}/${OS})
	
	dk_sleep(2) # wait 2 seconds for files to copy over
	#if(APPLE)
	#	dk_queueCommand(make)
	#elseif(NOT ANDROID)
		dk_queueCommand(${CMAKE_MAKE_PROGRAM} libbz2.a)
	#else()
	#	set(bash "#!/bin/bash")
	#	list(APPEND bash "cd ${BZIP2}/${OS}")
	#	list(APPEND bash "export ANDROID_NDK=${ANDROID_NDK}")
	#	list(APPEND bash "export PATH=${ANDROID_NDK}/prebuilt/${ANDROID_HOST_TAG}/bin:$PATH")
	#	list(APPEND bash "export TOOLCHAIN=${ANDROID_NDK}/toolchains/llvm/prebuilt/${ANDROID_HOST_TAG}/")
	#	list(APPEND bash "make")
	#	#list(APPEND bash "make.exe -j72 CC=$TOOLCHAIN/bin/armv7a-linux-androideabi16-clang AR=$TOOLCHAIN/bin/arm-linux-androideabi-ar RANLIB=$TOOLCHAIN/bin/arm-linux-androideabi-ranlib bzip2")
	#	string(REPLACE "C:/" "/c/" bash "${bash}")
	#	string(REPLACE ";" "\n"	bash "${bash}")
	#	message(STATUS "${bash}")
	#	dk_executeProcess(${MSYS2}/usr/bin/bash -c "${bash}")
		
		#/work/src/android-ndk-r19/toolchains/llvm/prebuilt/linux-x86_64//bin/armv7a-linux-androideabi16-clang -Wall -Winline -O2 -g -D_FILE_OFFSET_BITS=64 -c huffman.c
		#/work/src/android-ndk-r19/toolchains/llvm/prebuilt/linux-x86_64//bin/armv7a-linux-androideabi16-clang -Wall -Winline -O2 -g -D_FILE_OFFSET_BITS=64 -c crctable.c

		#If compilation produces errors, or a large number of warnings,
		#please read README.COMPILATION.PROBLEMS -- you might be able to
		#adjust the flags in this Makefile to improve matters.
		#
		#Also in README.COMPILATION.PROBLEMS are some hints that may help
		#if your build produces an executable which is unable to correctly
		#handle so-called 'large files' -- files of size 2GB or more.
		#
		#/work/src/android-ndk-r19/toolchains/llvm/prebuilt/linux-x86_64//bin/armv7a-linux-androideabi16-clang -Wall -Winline -O2 -g -D_FILE_OFFSET_BITS=64 -c randtable.c
		#/work/src/android-ndk-r19/toolchains/llvm/prebuilt/linux-x86_64//bin/armv7a-linux-androideabi16-clang -Wall -Winline -O2 -g -D_FILE_OFFSET_BITS=64 -c blocksort.c
		#/work/src/android-ndk-r19/toolchains/llvm/prebuilt/linux-x86_64//bin/armv7a-linux-androideabi16-clang -Wall -Winline -O2 -g -D_FILE_OFFSET_BITS=64 -c compress.c
		#/work/src/android-ndk-r19/toolchains/llvm/prebuilt/linux-x86_64//bin/armv7a-linux-androideabi16-clang -Wall -Winline -O2 -g -D_FILE_OFFSET_BITS=64 -c decompress.c
		#/work/src/android-ndk-r19/toolchains/llvm/prebuilt/linux-x86_64//bin/armv7a-linux-androideabi16-clang -Wall -Winline -O2 -g -D_FILE_OFFSET_BITS=64 -c bzlib.c
		#/work/src/android-ndk-r19/toolchains/llvm/prebuilt/linux-x86_64//bin/armv7a-linux-androideabi16-clang -Wall -Winline -O2 -g -D_FILE_OFFSET_BITS=64 -c bzip2.c
		#rm -f libbz2.a
		#/work/src/android-ndk-r19/toolchains/llvm/prebuilt/linux-x86_64//bin/arm-linux-androideabi-ar cq libbz2.a blocksort.o huffman.o crctable.o randtable.o compress.o decompress.o bzlib.o
		#/work/src/android-ndk-r19/toolchains/llvm/prebuilt/linux-x86_64//bin/arm-linux-androideabi-ranlib libbz2.a
		#/work/src/android-ndk-r19/toolchains/llvm/prebuilt/linux-x86_64//bin/armv7a-linux-androideabi16-clang -Wall -Winline -O2 -g -D_FILE_OFFSET_BITS=64  -o bzip2 bzip2.o -L. -lbz2
	endif()
endif()


