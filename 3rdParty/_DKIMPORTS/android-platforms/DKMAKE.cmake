include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://dl.google.com/android/repository/platform-26_r02.zip

if(NOT ANDROID)
	dk_undepend(android-platforms)
	dk_return()
endif()

dk_depend(android-sdk)

dk_makeDirectory(${ANDROID_SDK}/platforms)
dk_import(https://dl.google.com/android/repository/platform-26_r02.zip PATH ${ANDROID_SDK}/platforms/android-26)
