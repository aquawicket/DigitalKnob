include_guard()

message(STATUS "##############################################################")
message(STATUS "################ android_arm32_toolchain.cmake ###############")
message(STATUS "##############################################################")

###### Get DKCMAKE_DIR ######
if(NOT DKCMAKE_DIR)
	get_filename_component(DKCMAKE_DIR ${CMAKE_CURRENT_LIST_DIR} DIRECTORY)
	get_filename_component(DKBRANCH_DIR ${DKCMAKE_DIR} DIRECTORY)
	set(DK3RDPARTY ${DKBRANCH_DIR}/3rdParty)
	set(DKIMPORTS_DIR ${DK3RDPARTY}/_DKIMPORTS)
endif()

include(${DKCMAKE_DIR}/functions/dk_load.cmake)
dk_load(${DKCMAKE_DIR}/DK.cmake)
dk_load(${DKIMPORTS_DIR}/android-ndk/DKMAKE.cmake)
dk_load(${ANDROID_TOOLCHAIN_FILE})



dk_load(dk_append)

dk_set(CMAKE_GENERATOR					${ANDROID_GENERATOR})
dk_set(CMAKE_TOOLCHAIN_FILE				${ANDROID_TOOLCHAIN_FILE})
dk_load(${ANDROID_TOOLCHAIN_FILE})
dk_set(ANDROID_PLATFORM					${ANDROID_API})
dk_set(CMAKE_MAKE_PROGRAM				${ANDROID_MAKE_PROGRAM})
dk_set(CMAKE_C_COMPILER					${ANDROID_C_COMPILER})
dk_set(CMAKE_CXX_COMPILER				${ANDROID_CXX_COMPILER})
dk_append(CMAKE_C_FLAGS					-DANDROID -DANDROID_ARM32 -std=c17)
dk_append(CMAKE_CXX_FLAGS				-DANDROID -DANDROID_ARM32 -std=c++1z)
dk_set(DKCONFIGURE_CC					${ANDROID_C_COMPILER})
dk_set(DKCONFIGURE_CXX					${ANDROID_CXX_COMPILER})
dk_append(DKCONFIGURE_CFLAGS			-DANDROID -DANDROID_ARM32 -std=c17)
dk_append(DKCONFIGURE_CXXFLAGS			-DANDROID -DANDROID_ARM32 -std=c++1z)
	
dk_append(DKCMAKE_FLAGS
	-DANDROID_ABI=armeabi-v7a
	"-DANDROID_CPP_FEATURES=rtti exceptions"
	-DANDROID_NATIVE_API_LEVEL=${ANDROID_API}
	-DANDROID_NDK=${ANDROID_NDK}
	-DANDROID_PLATFORM=${ANDROID_API}
	-DANDROID_STL=c++_static
	-DANDROID_STL_FORCE_FEATURES=1
	-DANDROID_TOOLCHAIN=clang
	-DCMAKE_ANDROID_STL_TYPE=c++_static
)

