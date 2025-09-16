#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


############ openssl ############
# https://github.com/openssl/openssl.git
# https://www.openssl.org/
# https://www.npcglib.org/~stathis/downloads/openssl-1.0.2h-vs2015.7z
# https://github.com/openssl/openssl/issues/14131 # iOS & iOS-Simulator
# https://blog.rplasil.name/2015/09/compiling-openssl-with-emscripten.html
# https://github.com/openssl/openssl/archive/2f362e9.zip


#dk_validate(Target_Tuple "dk_Target_Tuple()")
if(Android OR Windows_X86_Msvc)
	dk_disable(openssl)
	dk_return()
endif()



### DEPEND ###
#dk_depend(openssl-cmake)
#if(Emscripten)
#	dk_depend(python3)
#endif()
dk_depend(dl)
dk_depend(pthread)
dk_depend(ws2_32)
dk_depend(crypt32)
dk_depend(perl)
#if(Windows_Host)
	dk_depend(msys2)
#endif()
dk_depend(nasm)

### IMPORT ###
dk_import()
#if(Emscripten)
#	dk_copy(${openssl_CMAKE} ${openssl})
#endif()


### LINK ###
dk_include				(${openssl}/include								OPENSSL_INCLUDE_DIR)
dk_include				(${openssl_Config_Dir}/include					OPENSSL_INCLUDE_DIR2)
dk_set					(OPENSSL_ROOT_DIR 								${openssl_Config_Dir})
if(MSVC)
	if(Windows_X86)
		dk_libDebug		(${openssl}/lib/libeay32MTd.lib					LIB_EAY_DEBUG)
		dk_libRelease	(${openssl}/lib/libeay32MT.lib					LIB_EAY_RELEASE)
		dk_libDebug		(${openssl}/lib/ssleay32MTd.lib					SSL_EAY_DEBUG)
		dk_libRelease	(${openssl}/lib/ssleay32MT.lib					SSL_EAY_RELEASE)
	endif()
	if(Windows_X86_64)
		dk_libDebug		(${openssl}/lib64/libeay32MTd.lib				LIB_EAY_DEBUG)
		dk_libRelease	(${openssl}/lib64/libeay32MT.lib				LIB_EAY_RELEASE)
		dk_libDebug		(${openssl}/lib64/ssleay32MTd.lib				SSL_EAY_DEBUG)
		dk_libRelease	(${openssl}/lib64/ssleay32MT.lib				SSL_EAY_RELEASE)
	endif()
	dk_libDebug			(${openssl_Config_Dir}/libcrypto.lib			OPENSSL_CRYPTO_DEBUG_LIBRARY	OPENSSL_CRYPTO_LIBRARY)
	dk_libRelease		(${openssl_Config_Dir}/libcrypto.lib			OPENSSL_CRYPTO_RELEASE_LIBRARY	OPENSSL_CRYPTO_LIBRARY)
	dk_libDebug			(${openssl_Config_Dir}/libssl.lib				OPENSSL_SSL_DEBUG_LIBRARY		OPENSSL_SSL_LIBRARY)
	dk_libRelease		(${openssl_Config_Dir}/libssl.lib				OPENSSL_SSL_RELEASE_LIBRARY		OPENSSL_SSL_LIBRARY)
	dk_libDebug			(${openssl_Config_Dir}/providers/liblegacy.lib	OPENSSL_LEGACY_DEBUG_LIBRARY	OPENSSL_LEGACY_LIBRARY)
	dk_libRelease		(${openssl_Config_Dir}/providers/liblegacy.lib	OPENSSL_LEGACY_RELEASE_LIBRARY	OPENSSL_LEGACY_LIBRARY)
else()
	dk_libDebug			(${openssl_Config_Dir}/libcrypto.a				OPENSSL_CRYPTO_DEBUG_LIBRARY	OPENSSL_CRYPTO_LIBRARY)
	dk_libRelease		(${openssl_Config_Dir}/libcrypto.a				OPENSSL_CRYPTO_RELEASE_LIBRARY	OPENSSL_CRYPTO_LIBRARY)
	dk_libDebug			(${openssl_Config_Dir}/libssl.a					OPENSSL_SSL_DEBUG_LIBRARY		OPENSSL_SSL_LIBRARY)
	dk_libRelease		(${openssl_Config_Dir}/libssl.a					OPENSSL_SSL_RELEASE_LIBRARY		OPENSSL_SSL_LIBRARY)
	dk_libDebug			(${openssl_Config_Dir}/providers/liblegacy.a	OPENSSL_LEGACY_DEBUG_LIBRARY	OPENSSL_LEGACY_LIBRARY)
	dk_libRelease		(${openssl_Config_Dir}/providers/liblegacy.a	OPENSSL_LEGACY_RELEASE_LIBRARY	OPENSSL_LEGACY_LIBRARY)
endif()
dk_set					(OPENSSL_LIBRARIES								${openssl_Config_Dir})


### 3RDPARTY LINK ###
# https://cmake.org/cmake/help/latest/module/FindOpenSSL.html
dk_set(openssl_CMAKE
	-DOPENSSL_USE_STATIC_LIBS=ON
	-DOPENSSL_ROOT_DIR=${OPENSSL_ROOT_DIR}
	-DOPENSSL_INCLUDE_DIR=${OPENSSL_INCLUDE_DIR}
	-DOPENSSL_LIBRARIES=${OPENSSL_LIBRARIES}
	-DOPENSSL_CRYPTO_LIBRARY=${OPENSSL_CRYPTO_LIBRARY}
	-DOPENSSL_SSL_LIBRARY=${OPENSSL_SSL_LIBRARY})
if(MSVC)
	dk_append(openssl_CMAKE
		-DOPENSSL_MSVC_STATIC_RT=ON
		-DLIB_EAY_DEBUG=${LIB_EAY_DEBUG}
		-DLIB_EAY_RELEASE=${LIB_EAY_RELEASE}
		-DSSL_EAY_DEBUG=${SSL_EAY_DEBUG}
		-DSSL_EAY_RELEASE=${SSL_EAY_RELEASE}
		"-DCMAKE_C_FLAGS=/I${OPENSSL_INCLUDE_DIR} /I${OPENSSL_INCLUDE_DIR2}"
		"-DCMAKE_CXX_FLAGS=/I${OPENSSL_INCLUDE_DIR} /I${OPENSSL_INCLUDE_DIR2}")
else()
	dk_append(openssl_CMAKE 
		"-DCMAKE_C_FLAGS=-I${OPENSSL_INCLUDE_DIR} -I${OPENSSL_INCLUDE_DIR2}"
		"-DCMAKE_CXX_FLAGS=-I${OPENSSL_INCLUDE_DIR} -I${OPENSSL_INCLUDE_DIR2}")
endif()


# https://wiki.openssl.org/index.php/Compilation_and_Installation
### GENERATE ###
dk_chdir(${openssl_Build_Dir})
#Emscripten_Debug_dk_configure(${openssl} -DBUILD_OPENSSL=ON -DGIT_EXECUTABLE=${git_exe} -DPYTHON_EXECUTABLE=${PYTHON3_EXE})
if(Debug)
	if(Android_Arm32_Clang)
		dk_configure		(${openssl} ${perl_exe} ../../Configure no-shared --debug android-arm CC=${ANDROID_CXX_COMPILER} -D__ANDROID_API__=${ANDROID_API})
	elseif(Android_Arm64_Clang)
		dk_configure		(${openssl} ${perl_exe} ../../Configure no-shared --debug android-arm64 CC=${ANDROID_CXX_COMPILER} -D__ANDROID_API__=${ANDROID_API})
	elseif(Emscripten)
		dk_configure		(${openssl} ${perl_exe} ../../Configure no-shared --debug linux-x32 -no-asm -static -no-sock -no-afalgeng -DOPENSSL_SYS_NETWARE -DSIG_DFL=0 -DSIG_IGN=0 -DHAVE_FORK=0 -DOPENSSL_NO_AFALGENG=1 -DOPENSSL_NO_SPEED=1)
	elseif(Ios_Arm64)
		dk_configure		(${openssl} ${perl_exe} ../../Configure no-shared --debug ios64-xcrun)
	elseif(Iossim)
		dk_configure		(${openssl} ${perl_exe} ../../Configure no-shared --debug iossimulator-xcrun)
	elseif(Linux_X86)
		dk_configure		(${openssl} ${perl_exe} ../../Configure no-shared --debug linux-x32)
	elseif(Linux_X86_64)
		dk_configure		(${openssl} ${perl_exe} ../../Configure no-shared --debug linux-x86_64-clang)
	elseif(Mac)
		dk_configure		(${openssl} ${perl_exe} ../../Configure no-shared --debug)
	elseif(Raspberry)
		dk_configure		(${openssl} ${perl_exe} ../../Configure no-shared --debug)
	elseif(Windows_X86_Clang)
		dk_prependEnvPath	(${msys2}/clang32/bin)
		dk_prependEnvPath	(${msys2}/usr/bin)
		dk_configure		(${openssl} ${perl_exe} ../../Configure no-shared --debug mingw CC=clang)
	elseif(Windows_X86_Gcc)
		dk_prependEnvPath	(${msys2}/mingw32/bin)
		dk_prependEnvPath	(${msys2}/usr/bin)
		dk_configure		(${openssl} ${perl_exe} ../../Configure no-shared --debug mingw CC=gcc)
	elseif(Windows_X86_Msvc)
		dk_depend(visualstudio)
		execute_process		(COMMAND cmd /c call ${VS_MAKE_VCVARSALL} "x64_x86")
		dk_configure		(${openssl} ${perl_exe} ../../Configure no-shared --debug VC-WIN32)
	elseif(Windows_X86_64_Clang)
		dk_prependEnvPath	(${msys2}/clang64/bin)
		dk_prependEnvPath	(${msys2}/usr/bin)
		dk_configure		(${openssl} ${perl_exe} ../../Configure no-shared --debug mingw64 CC=clang)
	elseif(Windows_X86_64_Gcc)
		dk_prependEnvPath	(${msys2}/mingw64/bin)
		dk_prependEnvPath	(${msys2}/usr/bin)
		dk_configure		(${openssl} ${perl_exe} ../../Configure no-shared --debug mingw64 CC=gcc)
	elseif(Windows_X86_64_Msvc)
		dk_configure		(${openssl} ${perl_exe} ../../Configure no-shared --debug VC-WIN64)
	endif()
endif()

if(Release)
	if(Android_Arm32_Clang)
		dk_configure		(${openssl} ${perl_exe} ../../Configure no-shared --release android-arm CC=clang++ -D__ANDROID_API__=${ANDROID_API})
	elseif(Android_Arm64_Clang)
		dk_validate(bash_exe "dk_bash_exe()")
		dk_exec(${bash_exe} -c "echo $PATH")
		dk_configure		(${openssl} ${perl_exe} ../../Configure no-shared --release android-arm64 CC=clang++ -D__ANDROID_API__=${ANDROID_API})
	elseif(Emscripten)
		dk_configure		(${openssl} ${perl_exe} ../../Configure no-shared --release linux-x32 -no-asm -static -no-sock -no-afalgeng -DOPENSSL_SYS_NETWARE -DSIG_DFL=0 -DSIG_IGN=0 -DHAVE_FORK=0 -DOPENSSL_NO_AFALGENG=1 -DOPENSSL_NO_SPEED=1)
	elseif(Ios_Arm64)
		dk_configure		(${openssl} ${perl_exe} ../../Configure no-shared --release ios64-xcrun)
	elseif(Iossim)
		dk_configure		(${openssl} ${perl_exe} ../../Configure no-shared --release iossimulator-xcrun)
	elseif(Linux_X86)
		dk_configure		(${openssl} ${perl_exe} ../../Configure no-shared --release linux-x32)
	elseif(Linux_X86_64)
		dk_configure		(${openssl} ${perl_exe} ../../Configure no-shared --release linux-x64)
	elseif(Mac)
		dk_configure		(${openssl} ${perl_exe} ../../Configure no-shared --release)
	elseif(Raspberry)
		dk_configure		(${openssl} ${perl_exe} ../../Configure no-shared --release)
	elseif(Windows_X86_Clang)
		dk_prependEnvPath	(${msys2}/clang32/bin)
		dk_prependEnvPath(${msys2}/usr/bin)
		dk_configure		(${openssl} ${perl_exe} ../../Configure no-shared --release mingw CC=clang)
	elseif(Windows_X86_Gcc)
		dk_prependEnvPath	(${msys2}/mingw32/bin)
		dk_prependEnvPath	(${msys2}/usr/bin)
		dk_configure		(${openssl} ${perl_exe} ../../Configure no-shared --release mingw CC=gcc)
	elseif(Windows_X86_Msvc)
		dk_configure		(${openssl} ${perl_exe} ../../Configure no-shared --release VC-WIN32)
	elseif(Windows_X86_64_Clang)
		dk_prependEnvPath	(${msys2}/clang64/bin)
		dk_prependEnvPath	(${msys2}/usr/bin)
		dk_configure		(${openssl} ${perl_exe} ../../Configure no-shared --release mingw64 CC=clang)
	elseif(Windows_X86_64_Gcc)
		dk_prependEnvPath	(${msys2}/mingw64/bin)
		dk_prependEnvPath	(${msys2}/usr/bin)
		dk_configure		(${openssl} ${perl_exe} ../../Configure no-shared --release mingw64 CC=gcc)
	elseif(Windows_X86_64_Msvc)
		dk_configure		(${openssl} ${perl_exe} ../../Configure no-shared --release VC-WIN64)
	endif()
endif()

dk_exec("${perl_exe}" configdata.pm --dump WORKING_DIRECTORY "${openssl_Config_Dir}")

dk_chdir("${OLDPWD}")
### COMPILE ###
dk_build()





####### openssl_binary ###############################################
# https://slproweb.com/products/Win32OpenSSL.html
# https://slproweb.com/download/Win64OpenSSL-3_0_4.exe
### INSTALL ###
# Windows_Host_dk_set(openssl_BINARY "${ProgramFiles}/OpenSSL-Win64")
# Windows_Host_dk_set(openssl_BINARY_EXE ${openssl_BINARY}/bin/openssl.exe)
# Mac_Host_dk_set(openssl_BINARY /usr/bin)
# Mac_Host_dk_set(openssl_BINARY_EXE ${openssl_BINARY}/openssl)
# Linux_Host_dk_set(openssl_BINARY /usr/bin)
# Linux_Host_dk_set(openssl_BINARY_EXE ${openssl_BINARY}/openssl)
# if(NOT EXISTS ${openssl_BINARY_EXE})
# 	dk_info("Installing openssl_binary")
# 	if(Windows_Host)	
# 		dk_download(https://slproweb.com/download/Win64OpenSSL-3_0_4.exe $ENV{DKDOWNLOAD_DIR}/Win64OpenSSL-3_0_4.exe)
# 		dk_exec($ENV{DKDOWNLOAD_DIR}/Win64OpenSSL-3_0_4.exe)
# 	endif()
# 	if(Mac_Host)
# 		dk_exec(brew install openssl)
# 	endif()
# 	if(Linux_Host)
#		dk_depend(sudo)
# 		dk_installPackage(openssl)
# 	endif()
# endif()
# if(NOT EXISTS "${openssl_BINARY_EXE}")
# 	dk_fatal("openssl_binary IS NOT FOUND OR INVALID")
# endif()
###################################################################
