# https://github.com/openssl/openssl.git
# https://www.openssl.org/
# https://www.npcglib.org/~stathis/downloads/openssl-1.0.2h-vs2015.7z
# https://github.com/openssl/openssl/issues/14131 # iOS & iOS-Simulator
# https://blog.rplasil.name/2015/09/compiling-openssl-with-emscripten.html

### DEPEND ###
#EMSCRIPTEN_dk_depend(openssl-cmake)
#EMSCRIPTEN_dk_depend(python3)
dk_depend(dl)
dk_depend(pthread)
dk_depend(ws2_32.lib)
dk_depend(crypt32.lib)
dk_depend(perl)

### IMPORT ###
#if(MSVC)
#	WIN_dk_import	(https://www.npcglib.org/~stathis/downloads/openssl-1.0.2h-vs2015.7z)
#else()
#	dk_import		(https://github.com/openssl/openssl.git PATCH) #PATCH: premade emscripten libraries
#endif()
dk_import			(https://github.com/openssl/openssl.git)


#if(EMSCRIPTEN)
#	dk_copy(${OPENSSL_CMAKE} ${OPENSSL})
#endif()

### LINK ###
dk_include				(${OPENSSL}/include								OPENSSL_INCLUDE_DIR)
DEBUG_dk_include		(${OPENSSL}/${OS}/${DEBUG_DIR}/include			OPENSSL_DEBUG_INCLUDE_DIR)
RELEASE_dk_include      (${OPENSSL}/${OS}/${RELEASE_DIR}/include		OPENSSL_RELEASE_INCLUDE_DIR)

if(Debug)
	set(OPENSSL_INCLUDE_DIR "${OPENSSL_INCLUDE_DIR};${OPENSSL_DEBUG_INCLUDE_DIR}")
endif()
if(Release)
	set(OPENSSL_INCLUDE_DIR "${OPENSSL_INCLUDE_DIR};${OPENSSL_RELEASE_INCLUDE_DIR}")
endif()

DEBUG_dk_set(OPENSSL_ROOT_DIR ${OPENSSL}/${OS}/${DEBUG_DIR})
RELEASE_dk_set(OPENSSL_ROOT_DIR ${OPENSSL}/${OS}/${RELEASE_DIR})

if(MSVC)
	WIN_X86_dk_libDebug		(${OPENSSL}/lib/libeay32MTd.lib)
	WIN_X86_dk_libRelease	(${OPENSSL}/lib/libeay32MT.lib)
	WIN_X86_64_dk_libDebug	(${OPENSSL}/lib64/libeay32MTd.lib)
	WIN_X86_64_dk_libRelease(${OPENSSL}/lib64/libeay32MT.lib)
	WIN_X86_dk_libDebug		(${OPENSSL}/lib/ssleay32MTd.lib)
	WIN_X86_dk_libRelease	(${OPENSSL}/lib/ssleay32MT.lib)
	WIN_X86_64_dk_libDebug	(${OPENSSL}/lib64/ssleay32MTd.lib)
	WIN_X86_64_dk_libRelease(${OPENSSL}/lib64/ssleay32MT.lib)
else()
	dk_libDebug			(${OPENSSL}/${OS}/${DEBUG_DIR}/libcrypto.a		OPENSSL_CRYPTO_DEBUG_LIBRARY)
	dk_libRelease		(${OPENSSL}/${OS}/${RELEASE_DIR}/libcrypto.a	OPENSSL_CRYPTO_RELEASE_LIBRARY)
	dk_libDebug			(${OPENSSL}/${OS}/${DEBUG_DIR}/libssl.a			OPENSSL_DEBUG_LIBRARY)
	dk_libRelease		(${OPENSSL}/${OS}/${RELEASE_DIR}/libssl.a		OPENSSL_RELEASE_LIBRARY)
endif()



### 3RDPARTY LINK ###
if(MSVC)
	WIN_X86_dk_set		(OPENSSL_CMAKE -DOPENSSL_INCLUDE_DIR=${OPENSSL_INCLUDE_DIR} -DLIB_EAY_DEBUG=${OPENSSL}/lib/libeay32MTd.lib -DLIB_EAY_RELEASE=${OPENSSL}/lib/libeay32MT.lib -DSSL_EAY_DEBUG=${OPENSSL}/lib/ssleay32MTd.lib -DSSL_EAY_RELEASE=${OPENSSL}/lib/ssleay32MT.lib "-DCMAKE_C_FLAGS=-I${OPENSSL}/include" "-DCMAKE_CXX_FLAGS=-I${OPENSSL}/include")
	WIN_X86_64_dk_set	(OPENSSL_CMAKE -DOPENSSL_INCLUDE_DIR=${OPENSSL_INCLUDE_DIR} -DLIB_EAY_DEBUG=${OPENSSL}/lib64/libeay32MTd.lib -DLIB_EAY_RELEASE=${OPENSSL}/lib64/libeay32MT.lib -DSSL_EAY_DEBUG=${OPENSSL}/lib64/ssleay32MTd.lib -DSSL_EAY_RELEASE=${OPENSSL}/lib64/ssleay32MT.lib "-DCMAKE_C_FLAGS=-I${OPENSSL}/include" "-DCMAKE_CXX_FLAGS=-I${OPENSSL}/include")
else()
	DEBUG_dk_set		(OPENSSL_CMAKE -DOPENSSL_USE_STATIC_LIBS=ON -DOPENSSL_ROOT_DIR=${OPENSSL_ROOT_DIR} -DOPENSSL_INCLUDE_DIR=${OPENSSL_INCLUDE_DIR} -DOPENSSL_LIBRARIES=${OPENSSL_DEBUG_LIBRARY} -DOPENSSL_CRYPTO_LIBRARY=${OPENSSL_CRYPTO_DEBUG_LIBRARY} -DOPENSSL_SSL_LIBRARY=${OPENSSL_DEBUG_LIBRARY} "-DCMAKE_C_FLAGS=-I${OPENSSL_INCLUDE_DIR} -I${OPENSSL_DEBUG_INCLUDE_DIR}" "-DCMAKE_CXX_FLAGS=-I${OPENSSL_INCLUDE_DIR} -I${OPENSSL_DEBUG_INCLUDE_DIR}")
	RELEASE_dk_set		(OPENSSL_CMAKE -DOPENSSL_USE_STATIC_LIBS=ON -DOPENSSL_ROOT_DIR=${OPENSSL_ROOT_DIR} -DOPENSSL_INCLUDE_DIR=${OPENSSL_INCLUDE_DIR} -DOPENSSL_LIBRARIES=${OPENSSL_RELEASE_LIBRARY} -DOPENSSL_CRYPTO_LIBRARY=${OPENSSL_CRYPTO_RELEASE_LIBRARY} -DOPENSSL_SSL_LIBRARY=${OPENSSL_RELEASE_LIBRARY} "-DCMAKE_C_FLAGS=-I${OPENSSL_INCLUDE_DIR} -I${OPENSSL_RELEASE_INCLUDE_DIR}" "-DCMAKE_CXX_FLAGS=-I${OPENSSL_INCLUDE_DIR} -I${OPENSSL_RELEASE_INCLUDE_DIR}")
endif()



### GENERATE ###
### COMPILE ###
DEBUG_dk_setPath(${OPENSSL}/${OS}/${DEBUG_DIR})
#ANDROID_ARM32_DEBUG_dk_queueBash(
#	"export ANDROID_NDK_ROOT=${ANDROID_NDK}\n"
#	"export PATH=${ANDROID_NDK}/toolchains/llvm/prebuilt/${ANDROID_HOST_TAG}/bin:$PATH\n"
#	#"export PATH=${ANDROID_NDK}/toolchains/arm-linux-androideabi-4.9/prebuilt/${ANDROID_HOST_TAG}/bin:$PATH\n"
#	"${OPENSSL}/Configure no-shared --debug android-arm -D__ANDROID_API__=31")
#ANDROID_ARM64_DEBUG_dk_queueBash(
#	"export ANDROID_NDK_ROOT=${ANDROID_NDK};"
#	"export PATH=${ANDROID_NDK}/toolchains/llvm/prebuilt/${ANDROID_HOST_TAG}/bin:$PATH;"
#	#"export PATH=${ANDROID_NDK}/toolchains/arm-linux-androideabi-4.9/prebuilt/${ANDROID_HOST_TAG}/bin:$PATH;"
#	"../../Configure no-shared --debug android-arm64 -D__ANDROID_API__=31")
#EMSCRIPTEN_DEBUG_dk_queueCommand(${EMCONFIGURE} ${OPENSSL}/Configure linux-x32 -no-asm -static -no-sock -no-afalgeng -DOPENSSL_SYS_NETWARE -DSIG_DFL=0 -DSIG_IGN=0 -DHAVE_FORK=0 -DOPENSSL_NO_AFALGENG=1 -DOPENSSL_NO_SPEED=1)
#EMSCRIPTEN_dk_queueCommand(${DKCMAKE_BUILD} -DBUILD_OPENSSL=ON -DGIT_EXECUTABLE=${GIT_EXE} -DPYTHON_EXECUTABLE=${PYTHON3_EXE} ${OPENSSL})

ANDROID_ARM32_DEBUG_dk_queueBash("export ANDROID_NDK_ROOT=${ANDROID_NDK}\n"
	"export PATH=${ANDROID_NDK}/toolchains/llvm/prebuilt/${ANDROID_HOST_TAG}/bin:$PATH\n"
	"export PATH=${ANDROID_NDK}/toolchains/llvm/prebuilt/${ANDROID_HOST_TAG}/sysroot/usr/include:$PATH\n"
	"../../Configure no-shared --debug android-arm -D__ANDROID_API__=31")
ANDROID_ARM64_DEBUG_dk_queueBash(../../Configure no-shared --debug android-arm64 -D__ANDROID_API__=31)
IOS_ARM64_DEBUG_dk_queueCommand	(../../Configure no-shared --debug ios64-xcrun)
IOSSIM_DEBUG_dk_queueCommand	(../../Configure no-shared --debug iossimulator-xcrun)
LINUX_DEBUG_dk_queueCommand		(../../Configure no-shared --debug)
MAC_DEBUG_dk_queueCommand		(../../Configure no-shared --debug)
RASPBERRY_DEBUG_dk_queueCommand	(../../Configure no-shared --debug)
if(MINGW)
	DEBUG_dk_queueCommand		(../../Configure no-shared --debug)
endif()

#if(NOT ANDROID AND NOT MSVC)
	DEBUG_dk_build(${OPENSSL})
#else()
#ANDROID_DEBUG_dk_queueCommand(${CMAKE_MAKE_PROGRAM})
#ANDROID_DEBUG_dk_queueBash(
#	"export ANDROID_NDK_ROOT=${ANDROID_NDK}"
#	"export PATH=$ANDROID_NDK_ROOT/toolchains/llvm/prebuilt/linux-aarch64/bin:$PATH"
#	#"export PATH=$ANDROID_NDK_ROOT/toolchains/arm-linux-androideabi-4.9/prebuilt/windows-x86_64/bin:$PATH"
#	"make")
#endif()


RELEASE_dk_setPath(${OPENSSL}/${OS}/${RELEASE_DIR})
#ANDROID_ARM32_RELEASE_dk_queueBash(
#	"export ANDROID_NDK_ROOT=${ANDROID_NDK}\n"
#	"export PATH=$ANDROID_NDK_ROOT/toolchains/llvm/prebuilt/windows-x86_64/bin:$PATH\n"
#	#"export PATH=$ANDROID_NDK_ROOT/toolchains/arm-linux-androideabi-4.9/prebuilt/windows-x86_64/bin:$PATH\n"
#	"../../Configure no-shared --release android-arm -D__ANDROID_API__=${ANDROID_API}")
#ANDROID_ARM64_RELEASE_dk_queueBash(
#	"export ANDROID_NDK_ROOT=${ANDROID_NDK}\n"
#	"export PATH=$ANDROID_NDK_ROOT/toolchains/llvm/prebuilt/windows-x86_64/bin:$PATH\n"
#	#"export PATH=$ANDROID_NDK_ROOT/toolchains/arm-linux-androideabi-4.9/prebuilt/windows-x86_64/bin:$PATH\n"
#	"../../Configure no-shared --release android-arm64 -D__ANDROID_API__=${ANDROID_API}")
#EMSCRIPTEN_RELEASE_dk_queueCommand(${EMCONFIGURE} ${OPENSSL}/Configure)

ANDROID_ARM32_RELEASE_dk_queueBash	(../../Configure no-shared --release android-arm -D__ANDROID_API__=31)
ANDROID_ARM64_RELEASE_dk_queueBash	(../../Configure no-shared --release android-arm64 -D__ANDROID_API__=31)
IOS_ARM64_RELEASE_dk_queueCommand	(../../Configure no-shared --release ios64-xcrun)
IOSSIM_RELEASE_dk_queueCommand		(../../Configure no-shared --release iossimulator-xcrun)
LINUX_RELEASE_dk_queueCommand		(../../Configure no-shared --release)
MAC_RELEASE_dk_queueCommand			(../../Configure no-shared --release)
RASPBERRY_RELEASE_dk_queueCommand	(../../Configure no-shared --release)
if(MINGW)
	RELEASE_dk_queueCommand			(../../Configure no-shared --release)
endif()

#if(NOT ANDROID AND NOT MSVC)
	RELEASE_dk_build(${OPENSSL})
#else()
#	ANDROID_RELEASE_dk_bash(
#		"export ANDROID_NDK_ROOT=${ANDROID_NDK}\n"
#		"export PATH=$ANDROID_NDK_ROOT/toolchains/llvm/prebuilt/windows-x86_64/bin:$PATH\n"
#		#"export PATH=$ANDROID_NDK_ROOT/toolchains/arm-linux-androideabi-4.9/prebuilt/windows-x86_64/bin:$PATH\n"
#		"make")
#endif()



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
# 		dk_command(sudo apt-get -y install openssl)
# 	endif()
# endif()
# if(NOT EXISTS "${OPENSSL_BINARY_EXE}")
# 	dk_error("openssl_binary IS NOT FOUND OR INVALID")
# endif()
###################################################################
