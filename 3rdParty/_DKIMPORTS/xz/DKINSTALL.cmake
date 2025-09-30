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


############ xz ############
# https://github.com/tukaani-project/xz.git
# https://github.com/tukaani-project/xz/releases/download/v5.4.6/xz-5.4.6.tar.gz
# https://sourceforge.net/projects/lzmautils/files/xz-5.4.6.tar.gz

#dk_validate(Target_Config  "dk_Target_Config()")

### IMPORT ###

#dk_import(https://github.com/tukaani-project/xz.git)
#dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
#dk_import("${xz_Import}")
dk_import()

#dk_fileReplace("${xz}/src/liblzma/api/lzma.h" "__declspec(dllimport)" "")
#dk_fileReplace("${xz}/src/liblzma/common/common.h" "__declspec(dllexport)" "")
#dk_fileReplace("${xz}/src/liblzma/api/lzma.h" "__cdecl" "")

### autotools ###
#dk_set(xz_VERSION 5.2.5)
#dk_set(xz_Import https://tukaani.org/xz/${xz_FOLDER}.tar.gz)
#dk_set(xz_NAME xz-${xz_VERSION})
#dk_validate(ENV{DK3RDPARTY_DIR} "dk_DK3RDPARTY_DIR()")
#dk_set(xz $ENV{DK3RDPARTY_DIR}/${xz_FOLDER})
#dk_import(${xz_Import} ${xz})


### LINK ###
dk_define			(LZMA_API_STATIC)
dk_include			(${xz}/src/liblzma/api 			LIBLZMA_INCLUDE_DIR)
if(MSVC)
	dk_libDebug		(${xz_Debug_Dir}/liblzma.lib	LIBLZMA_LIBRARY_DEBUG		LIBLZMA_LIBRARY)
	dk_libRelease	(${xz_Release_Dir}/liblzma.lib	LIBLZMA_LIBRARY_RELEASE		LIBLZMA_LIBRARY)
else()
	dk_libDebug		(${xz_Debug_Dir}/liblzma.a		LIBLZMA_LIBRARY_DEBUG		LIBLZMA_LIBRARY)
	dk_libRelease	(${xz_Release_Dir}/liblzma.a	LIBLZMA_LIBRARY_RELEASE		LIBLZMA_LIBRARY)
endif()


### 3RDPARTY LINK ###
if(MSVC)
	dk_set(xz_CMAKE 
		-DCMAKE_C_FLAGS=/DLZMA_API_STATIC 
		-DCMAKE_CXX_FLAGS=/DLZMA_API_STATIC 
		-DLIBLZMA_INCLUDE_DIR=${LIBLZMA_INCLUDE_DIR}
		-DLIBLZMA_LIBRARY_DEBUG=${LIBLZMA_LIBRARY_DEBUG} 
		-DLIBLZMA_LIBRARY_RELEASE=${LIBLZMA_LIBRARY_RELEASE})
else()
	dk_set(xz_CMAKE
		"-DCMAKE_C_FLAGS=-DLZMA_API_STATIC"
		"-DCMAKE_CXX_FLAGS=-DLZMA_API_STATIC"
		-DLIBLZMA_INCLUDE_DIR=${LIBLZMA_INCLUDE_DIR}
		-DLIBLZMA_LIBRARY=${LIBLZMA_LIBRARY}
		-DLIBLZMA_HAS_AUTO_DECODER=ON
		-DLIBLZMA_HAS_EASY_ENCODER=ON
		-DLIBLZMA_HAS_LZMA_PRESET=ON
		"-DCMAKE_EXE_LINKER_FLAGS=${LIBLZMA_LIBRARY}")
endif()

# TODO
# LIBLZMA_HAS_AUTO_DECODER
# LIBLZMA_HAS_EASY_ENCODER
# LIBLZMA_HAS_LZMA_PRESET
# ENABLE_SMALL "Reduce code size at expense of speed. This may be useful together with CMAKE_BUILD_TYPE=MinSizeRel."
# MICROLZMA_ENCODER "MicroLZMA encoder (needed by specific applications only)" ON
# MICROLZMA_DECODER "MicroLZMA decoder (needed by specific applications only)" ON
# LZIP_DECODER "Support lzip decoder" ON
# ALLOW_ATTR_IFUNC "Allow use of __attribute__((__ifunc__())) if supported by the system" ON
# CREATE_XZ_SYMLINKS "Create unxz and xzcat symlinks" ON
# CREATE_LZMA_SYMLINKS "Create lzma, unlzma, and lzcat symlinks" ON

### GENERATE ###
if(MSVC)
	dk_configure(${xz} "-DCMAKE_C_FLAGS=/DLZMA_API_STATIC" "-DCMAKE_CXX_FLAGS=/DLZMA_API_STATIC")
else()
	dk_configure(${xz} "-DCMAKE_C_FLAGS=-DLZMA_API_STATIC" "-DCMAKE_CXX_FLAGS=-DLZMA_API_STATIC")
endif()



### COMPILE ###
if(MSVC)
	list(APPEND DEBUG_LINK_FLAGS /ignore:4217)
	list(APPEND RELEASE_LINK_FLAGS /ignore:4217)
endif()
dk_build(${xz} liblzma)


#FIXME
dk_return()
#else()

################## autotools #################################################
#Windows_dk_libDebug(${xz_Debug_Dir}/src/liblzma/.libs/liblzma.a)
#Windows_dk_libRelease(${xz_Release_Dir}/src/liblzma/.libs/liblzma.a)
#Mac_dk_libDebug(${xz_Debug_Dir}/src/liblzma/.libs/liblzma.a)
#Mac_dk_libRelease(${xz_Release_Dir}/src/liblzma/.libs/liblzma.a)
#Ios_dk_libDebug(${xz_Debug_Dir}/src/liblzma/.libs/liblzma.a)
#Ios_dk_libRelease(${xz_Release_Dir}/src/liblzma/.libs/liblzma.a)
#Iossim_dk_libDebug(${xz_Debug_Dir}/src/liblzma/.libs/liblzma.a)
#Iossim_dk_libRelease(${xz_Release_Dir}/src/liblzma/.libs/liblzma.a)
#Linux_dk_libDebug(${xz_Debug_Dir}/src/liblzma/.libs/liblzma.a)
#Linux_dk_libRelease(${xz_Release_Dir}/src/liblzma/.libs/liblzma.a)
#Raspberry_dk_libDebug(${xz_Debug_Dir}/src/liblzma/.libs/liblzma.a)
#Raspberry_dk_libRelease(${xz_Release_Dir}/src/liblzma/.libs/liblzma.a)
#Android_dk_libDebug(${xz}/${Target_Tuple}/obj/local/armeabi-v7a/liblzma.a)
#Android_dk_libRelease(${xz}/${Target_Tuple}/obj/local/armeabi-v7a/liblzma.a)

### 3RDPARTY LINK ###
Android_dk_set	(xz_CMAKE -DCMAKE_C_FLAGS=-DLZMA_API_STATIC -DCMAKE_CXX_FLAGS=-DLZMA_API_STATIC -DLIBLZMA_INCLUDE_DIR=${xz}/src/liblzma/api -DLIBLZMA_LIBRARY_DEBUG=${xz}/${Target_Tuple}/obj/local/armeabi-v7a/liblzma.a -DLIBLZMA_LIBRARY_RELEASE=${xz}/${Target_Tuple}/obj/local/armeabi-v7a/liblzma.a)
Apple_dk_set	(xz_CMAKE -DCMAKE_C_FLAGS=-DLZMA_API_STATIC -DCMAKE_CXX_FLAGS=-DLZMA_API_STATIC -DLIBLZMA_INCLUDE_DIR=${xz}/src/liblzma/api -DLIBLZMA_LIBRARY_DEBUG=${xz_Debug_Dir}/src/liblzma/.libs/liblzma.a -DLIBLZMA_LIBRARY_RELEASE=${xz_Release_Dir}/src/liblzma/.libs/liblzma.a)
Linux_dk_set	(xz_CMAKE -DCMAKE_C_FLAGS=-DLZMA_API_STATIC -DCMAKE_CXX_FLAGS=-DLZMA_API_STATIC -DLIBLZMA_INCLUDE_DIR=${xz}/src/liblzma/api -DLIBLZMA_LIBRARY_DEBUG=${xz_Debug_Dir}/src/liblzma/.libs/liblzma.a -DLIBLZMA_LIBRARY_RELEASE=${xz_Release_Dir}/src/liblzma/.libs/liblzma.a)
Raspberry_dk_set(xz_CMAKE -DCMAKE_C_FLAGS=-DLZMA_API_STATIC -DCMAKE_CXX_FLAGS=-DLZMA_API_STATIC -DLIBLZMA_INCLUDE_DIR=${xz}/src/liblzma/api -DLIBLZMA_LIBRARY_DEBUG=${xz_Debug_Dir}/src/liblzma/.libs/liblzma.a -DLIBLZMA_LIBRARY_RELEASE=${xz_Release_Dir}/src/liblzma/.libs/liblzma.a)
Windows_dk_set	(xz_CMAKE -DCMAKE_C_FLAGS=/DLZMA_API_STATIC -DCMAKE_CXX_FLAGS=/DLZMA_API_STATIC -DLIBLZMA_INCLUDE_DIR=${xz}/src/liblzma/api -DLIBLZMA_LIBRARY_DEBUG=${xz_Debug_Dir}/src/liblzma/.libs/liblzma.a -DLIBLZMA_LIBRARY_RELEASE=${xz_Release_Dir}/src/liblzma/.libs/liblzma.a)


### GENERATE / COMPILE ###
Android_dk_chdir				(${xz}/${Target_Tuple})
Android_dk_exec					(${DKCMAKE_BUILD} ${xz})
Android_dk_visualStudio			(${xz} liblzma)

dk_chdir						(${xz})
dk_exec							(autoreconf -f -i)
		
Unix_Debug_dk_chdir				(${xz_Debug_Dir})
Unix_Debug_dk_exec				(${DKCONFIGURE_BUILD})

Unix_Release_dk_chdir			(${xz_Release_Dir})
Unix_Release_dk_exec			(${DKCONFIGURE_BUILD})

Unix_dk_build					(${xz})


Windows_X86_Debug_dk_chdir		(${xz_Debug_Dir})
Windows_X86_Debug_dk_exec		(${DKCONFIGURE_BUILD})

Windows_X86_Release_dk_chdir	(${xz_Release_Dir})
Windows_X86_Release_dk_exec		(${DKCONFIGURE_BUILD})

Windows_X86_dk_build			(${xz})

# look at xz/windows/build.bash for details
Windows_X86_64_Debug_dk_chdir	(${xz_Debug_Dir})
Windows_X86_64_Debug_dk_exec(${DKCONFIGURE_BUILD} --prefix= --enable-silent-rules --disable-dependency-tracking --disable-nls --disable-scripts)

Windows_X86_64_Release_dk_chdir	(${xz_Release_Dir})
Windows_X86_64_Debug_dk_exec(${DKCONFIGURE_BUILD}  --prefix= --enable-silent-rules --disable-dependency-tracking --disable-nls --disable-scripts)

Windows_X86_64_dk_build			(${xz})

#endif()