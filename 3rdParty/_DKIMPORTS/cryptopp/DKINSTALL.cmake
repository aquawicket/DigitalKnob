#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


############ cryptopp ############
# https://www.cryptopp.com/
# https://github.com/weidai11/cryptopp

#if(Ios OR Iossim)
	#dk_depend(libmd)
	#dk_depend(macports)
#endif()

if(Unix)
	dk_import	(${cryptopp_Unix_Import} PATCH)
elseif(MINGW)
	dk_import	(${cryptopp_Unix_Import} PATCH)
elseif(Windows)
	dk_import	(${cryptopp_Windows_Import})
endif()


### LINK ###
if(Android)
	dk_libDebug		(${cryptopp_Debug_Dir}/libcryptopp.a)
	dk_libRelease	(${cryptopp_Release_Dir}/libcryptopp.a)
elseif(Apple)
	dk_libDebug		(${cryptopp_Tuple_Dir}/cryptopp.build/${Debug_Dir}/cryptopp-object.build/libcryptopp-object.a)
	dk_libRelease	(${cryptopp_Tuple_Dir}/cryptopp.build/${Release_Dir}/cryptopp-object.build/libcryptopp-object.a)
elseif(Emscripten)
	dk_libDebug		(${cryptopp_Debug_Dir}/libcryptopp.a)
	dk_libRelease	(${cryptopp_Release_Dir}/libcryptopp.a)
elseif(Linux)
	dk_libDebug		(${cryptopp_Debug_Dir}/libcryptopp.a)
	dk_libRelease	(${cryptopp_Release_Dir}/libcryptopp.a)
elseif(Raspberry)
	dk_libDebug		(${cryptopp_Debug_Dir}/libcryptopp.a)
	dk_libRelease	(${cryptopp_Release_Dir}/libcryptopp.a)
elseif(MSVC)
	dk_libDebug		(${cryptopp_Debug_Dir}/cryptopp-static.lib)
	dk_libRelease	(${cryptopp_Release_Dir}/cryptopp-static.lib)
elseif(Windows)
	dk_libDebug		(${cryptopp_Debug_Dir}/libcryptopp.a)
	dk_libRelease	(${cryptopp_Release_Dir}/libcryptopp.a)
endif()


### GENERATE ###
if(Android OR Mac)
	dk_validate(DKCMAKE_BUILD "dk_load(${DKCMAKE_DIR}/DKBuildFlags.cmake)")
	string(REPLACE "-DANDROID_CPP_FEATURES=\"rtti exceptions\""	"" DKCMAKE_BUILD "${DKCMAKE_BUILD}")
	string(REPLACE "-std=c++1z" "" 	DKCMAKE_BUILD "${DKCMAKE_BUILD}")
	string(REPLACE "-DMAC " " " 	DKCMAKE_BUILD "${DKCMAKE_BUILD}") #fix for class named Mac in cryptopp
	string(REPLACE "  " 		" " DKCMAKE_BUILD "${DKCMAKE_BUILD}")
endif()

if(Android)
	dk_configure	(${cryptopp} -DBUILD_STATIC=${BUILD_STATIC_LIBS} -DBUILD_SHARED=${BUILD_SHARED_LIBS} "-DCMAKE_CXX_FLAGS=/I${android-ndk}/sources/android/cpufeatures" )
elseif(Emscripten)
	dk_configure	(${cryptopp} -DBUILD_STATIC=${BUILD_STATIC_LIBS} -DBUILD_SHARED=${BUILD_SHARED_LIBS})
elseif(Ios)
	dk_configure	(${cryptopp} -DBUILD_STATIC=${BUILD_STATIC_LIBS} -DBUILD_SHARED=${BUILD_SHARED_LIBS} ${LIBMD_CMAKE})
elseif(Iossim)
	dk_configure	(${cryptopp} -DBUILD_STATIC=${BUILD_STATIC_LIBS} -DBUILD_SHARED=${BUILD_SHARED_LIBS} ${LIBMD_CMAKE})
elseif(Linux)	
	dk_configure	(${cryptopp} -DBUILD_STATIC=${BUILD_STATIC_LIBS} -DBUILD_SHARED=${BUILD_SHARED_LIBS})
elseif(Mac)
	dk_configure	(${cryptopp} -DBUILD_STATIC=${BUILD_STATIC_LIBS} -DBUILD_SHARED=${BUILD_SHARED_LIBS} -DCRYPTOPP_DISABLE_MIXED_ASM=ON)
elseif(Raspberry)
	dk_configure	(${cryptopp} -DBUILD_STATIC=${BUILD_STATIC_LIBS} -DBUILD_SHARED=${BUILD_SHARED_LIBS})
elseif(Windows)
	dk_configure	(${cryptopp} -DBUILD_STATIC=${BUILD_STATIC_LIBS} -DBUILD_SHARED=${BUILD_SHARED_LIBS})
endif()

### COMPILE ###
dk_build(${cryptopp} cryptopp-static)
