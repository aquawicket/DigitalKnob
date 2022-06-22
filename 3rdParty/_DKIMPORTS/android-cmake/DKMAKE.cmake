# https://dl.google.com/android/repository/7c386a739f915f5bd60051f2572c24782388e807.cmake-3.18.1-windows.zip


dk_set(ANDROID_CMAKE_DL https://dl.google.com/android/repository/7c386a739f915f5bd60051f2572c24782388e807.cmake-3.18.1-windows.zip)
dk_set(ANDROID_CMAKE_NAME android-sdk/cmake)
dk_set(ANDROID_CMAKE ${3RDPARTY}/${ANDROID_CMAKE_NAME})
dk_install(${ANDROID_CMAKE_DL} android-cmake ${ANDROID_CMAKE})
#dk_import(https://dl.google.com/android/repository/7c386a739f915f5bd60051f2572c24782388e807.cmake-3.18.1-windows.zip)
