include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://github.com/openssl/openssl.git
# https://www.openssl.org/
# https://www.npcglib.org/~stathis/downloads/openssl-1.0.2h-vs2015.7z
# https://github.com/openssl/openssl/issues/14131 # iOS & iOS-Simulator
# https://blog.rplasil.name/2015/09/compiling-openssl-with-emscripten.html

dk_validate(HOST_TRIPLE   		"dk_getHostTriple()")
dk_validate(TARGET_TRIPLE 		"dk_getTargetTriple()")
dk_validate(DKBUILD_TYPE		"dk_getBUILD_TYPE()")
dk_validate(CONFIG_PATH   		"dk_getMULTI_CONFIG()")
dk_validate(CMAKE_C_COMPILER	"dk_depend(clang)")
dk_validate(CMAKE_CXX_COMPILER	"dk_depend(clang)")

### DEPEND ###
#dk_depend(openssl-cmake)
#EMSCRIPTEN_dk_depend(python3)
dk_depend(dl)
dk_depend(pthread)
dk_depend(ws2_32)
dk_depend(crypt32)
dk_depend(perl)
WIN_HOST_dk_depend(msys2)
dk_depend(nasm)

### IMPORT ###
#WIN_dk_import	(https://www.npcglib.org/~stathis/downloads/openssl-1.0.2h-vs2015.7z)
#dk_import		(https://github.com/openssl/openssl.git PATCH) #PATCH: premade emscripten libraries
#dk_import		(https://github.com/openssl/openssl.git)
dk_import		(https://github.com/openssl/openssl/archive/refs/heads/master.zip)

#if(EMSCRIPTEN)
#	dk_copy(${OPENSSL_CMAKE} ${OPENSSL})
#endif()


### LINK ###
dk_include					(${OPENSSL_DIR}/include							OPENSSL_INCLUDE_DIR)
dk_include					(${OPENSSL_CONFIG_DIR}/include					OPENSSL_INCLUDE_DIR2)

dk_set						(OPENSSL_INCLUDE_DIR 							"${OPENSSL_INCLUDE_DIR};${OPENSSL_INCLUDE_DIR2}")
dk_set						(OPENSSL_ROOT_DIR 								${OPENSSL_CONFIG_DIR})

if(MSVC)
	WIN_X86_dk_libDebug		(${OPENSSL_DIR}/lib/libeay32MTd.lib				OPENSSL_LIBEAY_DEBUG_LIB)
	WIN_X86_dk_libRelease	(${OPENSSL_DIR}/lib/libeay32MT.lib				OPENSSL_LIBEAY_RELEASE_LIB)
	WIN_X86_64_dk_libDebug	(${OPENSSL_DIR}/lib64/libeay32MTd.lib			OPENSSL_LIBEAY_DEBUG_LIB)
	WIN_X86_64_dk_libRelease(${OPENSSL_DIR}/lib64/libeay32MT.lib			OPENSSL_LIBEAY_RELEASE_LIB)
	WIN_X86_dk_libDebug		(${OPENSSL_DIR}/lib/ssleay32MTd.lib				OPENSSL_SSLEAY_DEBUG_LIB)
	WIN_X86_dk_libRelease	(${OPENSSL_DIR}/lib/ssleay32MT.lib				OPENSSL_SSLEAY_RELEASE_LIB)
	WIN_X86_64_dk_libDebug	(${OPENSSL_DIR}/lib64/ssleay32MTd.lib			OPENSSL_SSLEAY_DEBUG_LIB)
	WIN_X86_64_dk_libRelease(${OPENSSL_DIR}/lib64/ssleay32MT.lib			OPENSSL_SSLEAY_RELEASE_LIB)
else()
	dk_libDebug				(${OPENSSL_CONFIG_DIR}/libcrypto.a				OPENSSL_CRYPTO_DEBUG_LIB)
	dk_libRelease			(${OPENSSL_CONFIG_DIR}/libcrypto.a				OPENSSL_CRYPTO_RELEASE_LIB)
	dk_libDebug				(${OPENSSL_CONFIG_DIR}/libssl.a					OPENSSL_DEBUG_LIB)
	dk_libRelease			(${OPENSSL_CONFIG_DIR}/libssl.a					OPENSSL_RELEASE_LIB)
	dk_libDebug				(${OPENSSL_CONFIG_DIR}/providers/liblegacy.a	OPENSSL_LEGACY_DEBUG_LIB)
	dk_libRelease			(${OPENSSL_CONFIG_DIR}/providers/liblegacy.a	OPENSSL_LEGACY_RELEASE_LIB)
endif()



### 3RDPARTY LINK ###
# https://cmake.org/cmake/help/latest/module/FindOpenSSL.html
if(MSVC)
	WIN_dk_set(OPENSSL_CMAKE
		-DOPENSSL_USE_STATIC_LIBS=ON
		-DOPENSSL_ROOT_DIR=${OPENSSL_ROOT_DIR}
		-DOPENSSL_INCLUDE_DIR=${OPENSSL_INCLUDE_DIR}
		-DOPENSSL_LIBRARIES=${OPENSSL_CONFIG_DIR}
		-DLIB_EAY_DEBUG=${OPENSSL_LIBEAY_DEBUG_LIB}
		-DLIB_EAY_RELEASE=${OPENSSL_LIBEAY_RELEASE_LIB}
		-DSSL_EAY_DEBUG=${OPENSSL_SSLEAY_DEBUG_LIB}
		-DSSL_EAY_RELEASE=${OPENSSL_SSLEAY_RELEASE_LIB}
		"-DCMAKE_C_FLAGS=/I${OPENSSL_INCLUDE_DIR} /I${OPENSSL_INCLUDE_DIR2}"
		"-DCMAKE_CXX_FLAGS=/I${OPENSSL_INCLUDE_DIR} /I${OPENSSL_INCLUDE_DIR2}")
else()
	DEBUG_dk_set(OPENSSL_CMAKE 
		-DOPENSSL_USE_STATIC_LIBS=ON
		-DOPENSSL_ROOT_DIR=${OPENSSL_ROOT_DIR}
		-DOPENSSL_INCLUDE_DIR=${OPENSSL_INCLUDE_DIR}
		-DOPENSSL_LIBRARIES=${OPENSSL_CONFIG_DIR}
		-DOPENSSL_CRYPTO_LIBRARY=${OPENSSL_CRYPTO_DEBUG_LIB}
		-DOPENSSL_SSL_LIBRARY=${OPENSSL_DEBUG_LIB}
		"-DCMAKE_C_FLAGS=-I${OPENSSL_INCLUDE_DIR} -I${OPENSSL_INCLUDE_DIR2}"
		"-DCMAKE_CXX_FLAGS=-I${OPENSSL_INCLUDE_DIR} -I${OPENSSL_INCLUDE_DIR2}")
	RELEASE_dk_set(OPENSSL_CMAKE 
		-DOPENSSL_USE_STATIC_LIBS=ON
		-DOPENSSL_ROOT_DIR=${OPENSSL_ROOT_DIR}
		-DOPENSSL_INCLUDE_DIR=${OPENSSL_INCLUDE_DIR}
		-DOPENSSL_LIBRARIES=${OPENSSL_CONFIG_DIR}
		-DOPENSSL_CRYPTO_LIBRARY=${OPENSSL_CRYPTO_RELEASE_LIB}
		-DOPENSSL_SSL_LIBRARY=${OPENSSL_RELEASE_LIB}
		"-DCMAKE_C_FLAGS=-I${OPENSSL_INCLUDE_DIR} -I${OPENSSL_INCLUDE_DIR2}"
		"-DCMAKE_CXX_FLAGS=-I${OPENSSL_INCLUDE_DIR} -I${OPENSSL_INCLUDE_DIR2}")
endif()
dk_assert(OPENSSL_CMAKE)


# https://wiki.openssl.org/index.php/Compilation_and_Installation
### GENERATE ###
#EMSCRIPTEN_DEBUG_dk_configure(${OPENSSL} -DBUILD_OPENSSL=ON -DGIT_EXECUTABLE=${GIT_EXE} -DPYTHON_EXECUTABLE=${PYTHON3_EXE})

   EMSCRIPTEN_DEBUG_dk_configure	(${OPENSSL} ../../Configure no-shared --debug linux-x32 -no-asm -static -no-sock -no-afalgeng -DOPENSSL_SYS_NETWARE -DSIG_DFL=0 -DSIG_IGN=0 -DHAVE_FORK=0 -DOPENSSL_NO_AFALGENG=1 -DOPENSSL_NO_SPEED=1)
ANDROID_ARM32_DEBUG_dk_configure	(${OPENSSL} ../../Configure no-shared --debug android-arm -D__ANDROID_API__=${ANDROID_API})
ANDROID_ARM64_DEBUG_dk_configure	(${OPENSSL} ../../Configure no-shared --debug CC=clang android-arm64 -D__ANDROID_API__=${ANDROID_API})
    IOS_ARM64_DEBUG_dk_configure	(${OPENSSL} ../../Configure no-shared --debug ios64-xcrun)
       IOSSIM_DEBUG_dk_configure	(${OPENSSL} ../../Configure no-shared --debug iossimulator-xcrun)
    LINUX_X86_DEBUG_dk_configure	(${OPENSSL} ../../Configure no-shared --debug linux-x32)
 LINUX_X86_64_DEBUG_dk_configure	(${OPENSSL} ../../Configure no-shared --debug linux-x86_64-clang)
          MAC_DEBUG_dk_configure	(${OPENSSL} ../../Configure no-shared --debug)
    RASPBERRY_DEBUG_dk_configure	(${OPENSSL} ../../Configure no-shared --debug)
      WIN_X86_DEBUG_dk_configure	(${OPENSSL} ../../Configure no-shared --debug mingw CC=clang)
   WIN_X86_64_DEBUG_dk_configure	(${OPENSSL} ../../Configure no-shared --debug mingw64 CC=clang)

   EMSCRIPTEN_RELEASE_dk_configure	(${OPENSSL} ../../Configure no-shared --release linux-x32 -no-asm -static -no-sock -no-afalgeng -DOPENSSL_SYS_NETWARE -DSIG_DFL=0 -DSIG_IGN=0 -DHAVE_FORK=0 -DOPENSSL_NO_AFALGENG=1 -DOPENSSL_NO_SPEED=1)
ANDROID_ARM32_RELEASE_dk_configure	(${OPENSSL} ../../Configure no-shared --release android-arm -D__ANDROID_API__=${ANDROID_API})
ANDROID_ARM64_RELEASE_dk_configure	(${OPENSSL} ../../Configure no-shared --release android-arm64 -D__ANDROID_API__=${ANDROID_API})
    IOS_ARM64_RELEASE_dk_configure	(${OPENSSL} ../../Configure no-shared --release ios64-xcrun)
       IOSSIM_RELEASE_dk_configure	(${OPENSSL} ../../Configure no-shared --release iossimulator-xcrun)
    LINUX_X86_RELEASE_dk_configure	(${OPENSSL} ../../Configure no-shared --release linux-x32)
 LINUX_X86_64_RELEASE_dk_configure	(${OPENSSL} ../../Configure no-shared --release linux-x64)
          MAC_RELEASE_dk_configure	(${OPENSSL} ../../Configure no-shared --release)
    RASPBERRY_RELEASE_dk_configure	(${OPENSSL} ../../Configure no-shared --release)
      WIN_X86_RELEASE_dk_configure	(${OPENSSL} ../../Configure no-shared --release mingw CC=clang)
   WIN_X86_64_RELEASE_dk_configure	(${OPENSSL} ../../Configure no-shared --release mingw64 CC=clang)


### COMPILE ###
dk_build(${OPENSSL})




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
# 		dk_command(${SUDO} apt-get -y install openssl)
# 	endif()
# endif()
# if(NOT EXISTS "${OPENSSL_BINARY_EXE}")
# 	dk_fatal("openssl_binary IS NOT FOUND OR INVALID")
# endif()
###################################################################
