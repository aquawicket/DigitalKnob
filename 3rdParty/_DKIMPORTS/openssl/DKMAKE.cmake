# https://github.com/openssl/openssl.git
# https://www.openssl.org/
# https://www.npcglib.org/~stathis/downloads/openssl-1.0.2h-vs2015.7z
# https://github.com/openssl/openssl/issues/14131 # iOS & iOS-Simulator
# https://blog.rplasil.name/2015/09/compiling-openssl-with-emscripten.html

### DEPEND ###
#EMSCRIPTEN_dk_depend(openssl-cmake)
#EMSCRIPTEN_dk_depend(python3)

### IMPORT ###
if(MSVC)
	WIN_dk_import	(https://www.npcglib.org/~stathis/downloads/openssl-1.0.2h-vs2015.7z)
else()
	dk_import		(https://github.com/openssl/openssl.git PATCH) #PATCH: premade emscripten libraries
endif()


#if(EMSCRIPTEN)
#	dk_copy(${OPENSSL_CMAKE} ${OPENSSL})
#endif()

### LINK ###
dk_include				(${OPENSSL}/include							OPENSSL_INCLUDE_DIR)
DEBUG_dk_include		(${OPENSSL}/${OS}/${DEBUG_DIR}/include)
RELEASE_dk_include      (${OPENSSL}/${OS}/${RELEASE_DIR}/include)


if(MSVC)
	WIN32_dk_libDebug	(${OPENSSL}/lib/libeay32MTd.lib)
	WIN32_dk_libRelease	(${OPENSSL}/lib/libeay32MT.lib)
	WIN64_dk_libDebug	(${OPENSSL}/lib64/libeay32MTd.lib)
	WIN64_dk_libRelease	(${OPENSSL}/lib64/libeay32MT.lib)
	WIN32_dk_libDebug	(${OPENSSL}/lib/ssleay32MTd.lib)
	WIN32_dk_libRelease	(${OPENSSL}/lib/ssleay32MT.lib)
	WIN64_dk_libDebug	(${OPENSSL}/lib64/ssleay32MTd.lib)
	WIN64_dk_libRelease	(${OPENSSL}/lib64/ssleay32MT.lib)
else()
	dk_libDebug			(${OPENSSL}/${OS}/${DEBUG_DIR}/libcrypto.a)
	dk_libRelease		(${OPENSSL}/${OS}/${RELEASE_DIR}/libcrypto.a)
	dk_libDebug			(${OPENSSL}/${OS}/${DEBUG_DIR}/libssl.a)
	dk_libRelease		(${OPENSSL}/${OS}/${RELEASE_DIR}/libssl.a)
endif()



### 3RDPARTY LINK ###
#-DOPENSSL_ROOT_DIR=${OPENSSL}
if(MSVC)
	WIN32_dk_set		(OPENSSL_CMAKE -DOPENSSL_INCLUDE_DIR=${OPENSSL_INCLUDE_DIR} -DLIB_EAY_DEBUG=${OPENSSL}/lib/libeay32MTd.lib -DLIB_EAY_RELEASE=${OPENSSL}/lib/libeay32MT.lib -DSSL_EAY_DEBUG=${OPENSSL}/lib/ssleay32MTd.lib -DSSL_EAY_RELEASE=${OPENSSL}/lib/ssleay32MT.lib "-DCMAKE_C_FLAGS=-I${OPENSSL}/include" "-DCMAKE_CXX_FLAGS=-I${OPENSSL}/include")
	WIN64_dk_set		(OPENSSL_CMAKE -DOPENSSL_INCLUDE_DIR=${OPENSSL_INCLUDE_DIR} -DLIB_EAY_DEBUG=${OPENSSL}/lib64/libeay32MTd.lib -DLIB_EAY_RELEASE=${OPENSSL}/lib64/libeay32MT.lib -DSSL_EAY_DEBUG=${OPENSSL}/lib64/ssleay32MTd.lib -DSSL_EAY_RELEASE=${OPENSSL}/lib64/ssleay32MT.lib "-DCMAKE_C_FLAGS=-I${OPENSSL}/include" "-DCMAKE_CXX_FLAGS=-I${OPENSSL}/include")
else()
	UNIX_DEBUG_dk_set	(OPENSSL_CMAKE -DOPENSSL_INCLUDE_DIR=${OPENSSL}/${OS}/${DEBUG_DIR}/include -DOPENSSL_CRYPTO_LIBRARY=${OPENSSL}/${OS}/${DEBUG_DIR}/libcrypto.a -DOPENSSL_SSL_LIBRARY=${OPENSSL}/${OS}/${DEBUG_DIR}/libssl.a "-DCMAKE_C_FLAGS=-I${OPENSSL}/include -I${OPENSSL}/${OS}/${DEBUG_DIR}/include" "-DCMAKE_CXX_FLAGS=-I${OPENSSL}/include -I${OPENSSL}/${OS}/${DEBUG_DIR}/include")
	UNIX_RELEASE_dk_set	(OPENSSL_CMAKE -DOPENSSL_INCLUDE_DIR=${OPENSSL}/${OS}/${RELEASE_DIR}/include -DOPENSSL_CRYPTO_LIBRARY=${OPENSSL}/${OS}/${RELEASE_DIR}/libcrypto.a -DOPENSSL_SSL_LIBRARY=${OPENSSL}/${OS}/${RELEASE_DIR}/libssl.a "-DCMAKE_C_FLAGS=-I${OPENSSL}/include -I${OPENSSL}/${OS}/${RELEASE_DIR}/include" "-DCMAKE_CXX_FLAGS=-I${OPENSSL}/include -I${OPENSSL}/${OS}/${RELEASE_DIR}/include")
endif()


### GENERATE ###
### COMPILE ###
DEBUG_dk_setPath(${OPENSSL}/${OS}/${DEBUG_DIR})
ANDROID32_DEBUG_dk_queueCommand(
"export ANDROID_NDK_ROOT=${ANDROID_NDK}\n"
"export PATH=$ANDROID_NDK_ROOT/toolchains/llvm/prebuilt/windows-x86_64/bin:$PATH\n"
"export PATH=$ANDROID_NDK_ROOT/toolchains/arm-linux-androideabi-4.9/prebuilt/windows-x86_64/bin:$PATH\n"
"../../Configure no-shared --debug android-arm -D__ANDROID_API__=31")
ANDROID64_DEBUG_dk_queueCommand(
"export ANDROID_NDK_ROOT=${ANDROID_NDK}\n"
"export PATH=$ANDROID_NDK_ROOT/toolchains/llvm/prebuilt/windows-x86_64/bin:$PATH\n"
"export PATH=$ANDROID_NDK_ROOT/toolchains/arm-linux-androideabi-4.9/prebuilt/windows-x86_64/bin:$PATH\n"
"../../Configure no-shared --debug android-arm64 -D__ANDROID_API__=31")
#EMSCRIPTEN_DEBUG_dk_queueCommand(${EMCONFIGURE} ${OPENSSL}/Configure linux-x32 -no-asm -static -no-sock -no-afalgeng -DOPENSSL_SYS_NETWARE -DSIG_DFL=0 -DSIG_IGN=0 -DHAVE_FORK=0 -DOPENSSL_NO_AFALGENG=1 -DOPENSSL_NO_SPEED=1)
#EMSCRIPTEN_dk_queueCommand(${DKCMAKE_BUILD} -DBUILD_OPENSSL=ON -DGIT_EXECUTABLE=${GIT_EXE} -DPYTHON_EXECUTABLE=${PYTHON3_APP} ${OPENSSL})

IOS64_DEBUG_dk_queueCommand		(../../Configure no-shared --debug ios64-xcrun)
IOSSIM_DEBUG_dk_queueCommand	(../../Configure no-shared --debug iossimulator-xcrun)
LINUX_DEBUG_dk_queueCommand		(../../Configure no-shared --debug)
MAC_DEBUG_dk_queueCommand		(../../Configure no-shared --debug)
RASPBERRY_DEBUG_dk_queueCommand	(../../Configure no-shared --debug)
if(MSYS)
	DEBUG_dk_queueCommand		(../../Configure no-shared --debug)
endif()

if(NOT ANDROID AND NOT MSVC)
	DEBUG_dk_queueCommand(make)
else()
	ANDROID_DEBUG_dk_queueCommand(
	"export ANDROID_NDK_ROOT=${ANDROID_NDK}\n"
	"export PATH=$ANDROID_NDK_ROOT/toolchains/llvm/prebuilt/windows-x86_64/bin:$PATH\n"
	"export PATH=$ANDROID_NDK_ROOT/toolchains/arm-linux-androideabi-4.9/prebuilt/windows-x86_64/bin:$PATH\n"
	"make")
endif()


RELEASE_dk_setPath(${OPENSSL}/${OS}/${RELEASE_DIR})
ANDROID32_RELEASE_dk_queueCommand(
"export ANDROID_NDK_ROOT=${ANDROID_NDK}\n"
"export PATH=$ANDROID_NDK_ROOT/toolchains/llvm/prebuilt/windows-x86_64/bin:$PATH\n"
"export PATH=$ANDROID_NDK_ROOT/toolchains/arm-linux-androideabi-4.9/prebuilt/windows-x86_64/bin:$PATH\n"
"../../Configure no-shared --release android-arm -D__ANDROID_API__=31")
ANDROID64_RELEASE_dk_queueCommand(
"export ANDROID_NDK_ROOT=${ANDROID_NDK}\n"
"export PATH=$ANDROID_NDK_ROOT/toolchains/llvm/prebuilt/windows-x86_64/bin:$PATH\n"
"export PATH=$ANDROID_NDK_ROOT/toolchains/arm-linux-androideabi-4.9/prebuilt/windows-x86_64/bin:$PATH\n"
"../../Configure no-shared --release android-arm64 -D__ANDROID_API__=31")
#EMSCRIPTEN_RELEASE_dk_queueCommand(${EMCONFIGURE} ${OPENSSL}/Configure)
IOS64_RELEASE_dk_queueCommand		(../../Configure no-shared --release ios64-xcrun)
IOSSIM_RELEASE_dk_queueCommand		(../../Configure no-shared --release iossimulator-xcrun)
LINUX_RELEASE_dk_queueCommand		(../../Configure no-shared --release)
MAC_RELEASE_dk_queueCommand			(../../Configure no-shared --release)
RASPBERRY_RELEASE_dk_queueCommand	(../../Configure no-shared --release)
if(MSYS)
	RELEASE_dk_queueCommand			(../../Configure no-shared --release)
endif()

if(NOT ANDROID AND NOT MSVC)
	RELEASE_dk_queueCommand(make)
else()
	ANDROID_RELEASE_dk_queueCommand(
	"export ANDROID_NDK_ROOT=${ANDROID_NDK}\n"
	"export PATH=$ANDROID_NDK_ROOT/toolchains/llvm/prebuilt/windows-x86_64/bin:$PATH\n"
	"export PATH=$ANDROID_NDK_ROOT/toolchains/arm-linux-androideabi-4.9/prebuilt/windows-x86_64/bin:$PATH\n"
	"make")
endif()



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
# 		dk_download(https://slproweb.com/download/Win64OpenSSL-3_0_4.exe ${DKDOWNLOAD}/Win64OpenSSL-3_0_4.exe)
# 		dk_command(${DKDOWNLOAD}/Win64OpenSSL-3_0_4.exe)
# 	endif()
# 	if(MAC_HOST)
# 		dk_command(brew install openssl)
# 	endif()
# 	if(LINUX_HOST)
# 		dk_command(sudo apt-get -y install openssl)
# 	endif()
# endif()
# if(NOT EXISTS "${OPENSSL_BINARY_EXE}")
# 	dk_assert("openssl_binary IS NOT FOUND OR INVALID")
# endif()
###################################################################
