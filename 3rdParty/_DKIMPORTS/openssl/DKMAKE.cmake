#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
# https://github.com/openssl/openssl.git
# https://www.openssl.org/
# https://www.npcglib.org/~stathis/downloads/openssl-1.0.2h-vs2015.7z
# https://github.com/openssl/openssl/issues/14131 # iOS & iOS-Simulator
# https://blog.rplasil.name/2015/09/compiling-openssl-with-emscripten.html


dk_validate(triple "dk_TARGET_TRIPLE()")
### DEPEND ###
#dk_depend(openssl-cmake)
#EMSCRIPTEN_dk_depend(python3)
dk_depend(dl)
dk_depend(pthread)
dk_depend(ws2_32)
dk_depend(crypt32)
dk_depend(perl)
if(WIN_HOST)
	dk_depend(msys2)
endif()
dk_depend(nasm)

### IMPORT ###
dk_import(https://github.com/openssl/openssl/archive/2f362e99a1178263c7102474f0190836166f416d.zip)
#dk_import(https://github.com/openssl/openssl/archive/refs/heads/master.zip)

#if(EMSCRIPTEN)
#	dk_copy(${OPENSSL_CMAKE} ${OPENSSL})
#endif()


### LINK ###
dk_include				(${OPENSSL_DIR}/include							OPENSSL_INCLUDE_DIR)
dk_include				(${OPENSSL_CONFIG_DIR}/include					OPENSSL_INCLUDE_DIR2)
dk_set					(OPENSSL_ROOT_DIR 								${OPENSSL_CONFIG_DIR})
if(MSVC)
	if(WIN_X86)
		dk_libDebug		(${OPENSSL_DIR}/lib/libeay32MTd.lib				LIB_EAY_DEBUG)
		dk_libRelease	(${OPENSSL_DIR}/lib/libeay32MT.lib				LIB_EAY_RELEASE)
		dk_libDebug		(${OPENSSL_DIR}/lib/ssleay32MTd.lib				SSL_EAY_DEBUG)
		dk_libRelease	(${OPENSSL_DIR}/lib/ssleay32MT.lib				SSL_EAY_RELEASE)
	endif()
	if(WIN_X86_64)
		dk_libDebug		(${OPENSSL_DIR}/lib64/libeay32MTd.lib			LIB_EAY_DEBUG)
		dk_libRelease	(${OPENSSL_DIR}/lib64/libeay32MT.lib			LIB_EAY_RELEASE)
		dk_libDebug		(${OPENSSL_DIR}/lib64/ssleay32MTd.lib			SSL_EAY_DEBUG)
		dk_libRelease	(${OPENSSL_DIR}/lib64/ssleay32MT.lib			SSL_EAY_RELEASE)
	endif()	
else()
	dk_libDebug			(${OPENSSL_CONFIG_DIR}/libcrypto.a				OPENSSL_CRYPTO_DEBUG_LIBRARY)
	dk_libRelease		(${OPENSSL_CONFIG_DIR}/libcrypto.a				OPENSSL_CRYPTO_RELEASE_LIBRARY)
	dk_libDebug			(${OPENSSL_CONFIG_DIR}/libssl.a					OPENSSL_SSL_DEBUG_LIBRARY)
	dk_libRelease		(${OPENSSL_CONFIG_DIR}/libssl.a					OPENSSL_SSL_RELEASE_LIBRARY)
	dk_libDebug			(${OPENSSL_CONFIG_DIR}/providers/liblegacy.a	OPENSSL_LEGACY_DEBUG_LIBRARY)
	dk_libRelease		(${OPENSSL_CONFIG_DIR}/providers/liblegacy.a	OPENSSL_LEGACY_RELEASE_LIBRARY)
endif()
dk_set					(OPENSSL_LIBRARIES								${OPENSSL_CONFIG_DIR})
if(DEBUG)
	dk_set				(OPENSSL_CRYPTO_LIBRARY							${OPENSSL_CRYPTO_DEBUG_LIBRARY})
	dk_set				(OPENSSL_SSL_LIBRARY							${OPENSSL_SSL_DEBUG_LIBRARY})
endif()
if(RELEASE)
	dk_set				(OPENSSL_CRYPTO_LIBRARY							${OPENSSL_CRYPTO_RELEASE_LIBRARY})
	dk_set				(OPENSSL_SSL_LIBRARY							${OPENSSL_SSL_RELEASE_LIBRARY})
endif()


### 3RDPARTY LINK ###
# https://cmake.org/cmake/help/latest/module/FindOpenSSL.html
dk_set(OPENSSL_CMAKE
	-DOPENSSL_USE_STATIC_LIBS=ON
	-DOPENSSL_ROOT_DIR=${OPENSSL_ROOT_DIR}
	-DOPENSSL_INCLUDE_DIR=${OPENSSL_INCLUDE_DIR}
	-DOPENSSL_LIBRARIES=${OPENSSL_LIBRARIES})
if(MSVC)
	dk_append(OPENSSL_CMAKE
		-DOPENSSL_MSVC_STATIC_RT=ON
		-DLIB_EAY_DEBUG=${LIB_EAY_DEBUG}
		-DLIB_EAY_RELEASE=${LIB_EAY_RELEASE}
		-DSSL_EAY_DEBUG=${SSL_EAY_DEBUG}
		-DSSL_EAY_RELEASE=${SSL_EAY_RELEASE}
		"-DCMAKE_C_FLAGS=/I${OPENSSL_INCLUDE_DIR} /I${OPENSSL_INCLUDE_DIR2}"
		"-DCMAKE_CXX_FLAGS=/I${OPENSSL_INCLUDE_DIR} /I${OPENSSL_INCLUDE_DIR2}")
else()
	dk_append(OPENSSL_CMAKE 
		-DOPENSSL_LIBRARIES=${OPENSSL_LIBRARIES}
		-DOPENSSL_CRYPTO_LIBRARY=${OPENSSL_CRYPTO_LIBRARY}
		-DOPENSSL_SSL_LIBRARY=${OPENSSL_SSL_LIBRARY}
		"-DCMAKE_C_FLAGS=-I${OPENSSL_INCLUDE_DIR} -I${OPENSSL_INCLUDE_DIR2}"
		"-DCMAKE_CXX_FLAGS=-I${OPENSSL_INCLUDE_DIR} -I${OPENSSL_INCLUDE_DIR2}")
endif()


# https://wiki.openssl.org/index.php/Compilation_and_Installation
### GENERATE ###
#EMSCRIPTEN_DEBUG_dk_configure(${OPENSSL_DIR} -DBUILD_OPENSSL=ON -DGIT_EXECUTABLE=${GIT_EXE} -DPYTHON_EXECUTABLE=${PYTHON3_EXE})
if(DEBUG)
	if(EMSCRIPTEN)
		dk_configure		(${OPENSSL_DIR} ../../Configure no-shared --debug linux-x32 -no-asm -static -no-sock -no-afalgeng -DOPENSSL_SYS_NETWARE -DSIG_DFL=0 -DSIG_IGN=0 -DHAVE_FORK=0 -DOPENSSL_NO_AFALGENG=1 -DOPENSSL_NO_SPEED=1)
	elseif(ANDROID_ARM32)
		dk_configure		(${OPENSSL_DIR} ../../Configure no-shared --debug android-arm -D__ANDROID_API__=${ANDROID_API})
	elseif(ANDROID_ARM64)
		dk_configure		(${OPENSSL_DIR} ../../Configure no-shared --debug CC=clang android-arm64 -D__ANDROID_API__=${ANDROID_API})
	elseif(IOS_ARM64)
		dk_configure		(${OPENSSL_DIR} ../../Configure no-shared --debug ios64-xcrun)
	elseif(IOSSIM)
		dk_configure		(${OPENSSL_DIR} ../../Configure no-shared --debug iossimulator-xcrun)
	elseif(LINUX_X86)
		dk_configure		(${OPENSSL_DIR} ../../Configure no-shared --debug linux-x32)
	elseif(LINUX_X86_64)
		dk_configure		(${OPENSSL_DIR} ../../Configure no-shared --debug linux-x86_64-clang)
	elseif(MAC)
		dk_configure		(${OPENSSL_DIR} ../../Configure no-shared --debug)
	elseif(RASPBERRY)
		dk_configure		(${OPENSSL_DIR} ../../Configure no-shared --debug)
	elseif(WIN_X86)
		if(MSVC)
			dk_configure	(${OPENSSL_DIR} ../../Configure no-shared --debug msvc CC=clang)
		else()
			dk_configure	(${OPENSSL_DIR} ../../Configure no-shared --debug mingw CC=clang)
		endif()
	elseif(WIN_X86_64)
		if(MSVC)
			dk_configure	(${OPENSSL_DIR} ../../Configure no-shared --debug msvc64 CC=clang)
		else()
			dk_configure	(${OPENSSL_DIR} ${PERL_EXE} ../../Configure no-shared --debug mingw64 CC=clang)
		endif()
	endif()
endif()

if(RELEASE)
	if(EMSCRIPTEN)
		dk_configure	(${OPENSSL_DIR} ../../Configure no-shared --release linux-x32 -no-asm -static -no-sock -no-afalgeng -DOPENSSL_SYS_NETWARE -DSIG_DFL=0 -DSIG_IGN=0 -DHAVE_FORK=0 -DOPENSSL_NO_AFALGENG=1 -DOPENSSL_NO_SPEED=1)
	elseif(ANDROID_ARM32)
		dk_configure	(${OPENSSL_DIR} ../../Configure no-shared --release android-arm -D__ANDROID_API__=${ANDROID_API})
	elseif(ANDROID_ARM64)
		dk_configure	(${OPENSSL_DIR} ../../Configure no-shared --release android-arm64 -D__ANDROID_API__=${ANDROID_API})
	elseif(IOS_ARM64)
		dk_configure	(${OPENSSL_DIR} ../../Configure no-shared --release ios64-xcrun)
	elseif(IOSSIM)
		dk_configure	(${OPENSSL_DIR} ../../Configure no-shared --release iossimulator-xcrun)
	elseif(LINUX_X86)
		dk_configure	(${OPENSSL_DIR} ../../Configure no-shared --release linux-x32)
	elseif(LINUX_X86_64)
		dk_configure	(${OPENSSL_DIR} ../../Configure no-shared --release linux-x64)
	elseif(MAC)
		dk_configure	(${OPENSSL_DIR} ../../Configure no-shared --release)
	elseif(RASPBERRY)
		dk_configure	(${OPENSSL_DIR} ../../Configure no-shared --release)
	elseif(WIN_X86)
		if(MSVC)
			dk_configure	(${OPENSSL_DIR} ../../Configure no-shared --release msvc CC=clang)
		else()
			dk_configure	(${OPENSSL_DIR} ../../Configure no-shared --release mingw CC=clang)
		endif()
	elseif(WIN_X86_64)
		if(MSVC)
			dk_configure	(${OPENSSL_DIR} ../../Configure no-shared --release msvc64 CC=clang)
		else()
			dk_configure	(${OPENSSL_DIR} ../../Configure no-shared --release mingw64 CC=clang)
		endif()
	endif()
endif()

dk_bashEnv(perl configdata.pm --dump)

### COMPILE ###
dk_build(${OPENSSL_DIR})




####### openssl_binary ###############################################
# https://slproweb.com/products/Win32OpenSSL.html
# https://slproweb.com/download/Win64OpenSSL-3_0_4.exe
### INSTALL ###
# WIN_HOST_dk_set(OPENSSL_BINARY "${ProgramFiles}/OpenSSL-Win64")
# WIN_HOST_dk_set(OPENSSL_BINARY_EXE ${OPENSSL_BINARY}/bin/openssl.exe)
# MAC_HOST_dk_set(OPENSSL_BINARY /usr/bin)
# MAC_HOST_dk_set(OPENSSL_BINARY_EXE ${OPENSSL_BINARY}/openssl)
# LINUX_HOST_dk_set(OPENSSL_BINARY /usr/bin)
# LINUX_HOST_dk_set(OPENSSL_BINARY_EXE ${OPENSSL_BINARY}/openssl)
# if(NOT EXISTS ${OPENSSL_BINARY_EXE})
# 	dk_info("Installing openssl_binary")
# 	if(WIN_HOST)	
# 		dk_download(https://slproweb.com/download/Win64OpenSSL-3_0_4.exe ${DKDOWNLOAD_DIR}/Win64OpenSSL-3_0_4.exe)
# 		dk_command(${DKDOWNLOAD_DIR}/Win64OpenSSL-3_0_4.exe)
# 	endif()
# 	if(MAC_HOST)
# 		dk_command(brew install openssl)
# 	endif()
# 	if(LINUX_HOST)
#		dk_depend(sudo)
# 		dk_installPackage(openssl)
# 	endif()
# endif()
# if(NOT EXISTS "${OPENSSL_BINARY_EXE}")
# 	dk_fatal("openssl_binary IS NOT FOUND OR INVALID")
# endif()
###################################################################
