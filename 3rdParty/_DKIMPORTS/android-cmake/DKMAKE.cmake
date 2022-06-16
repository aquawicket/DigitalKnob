# https://dl.google.com/android/repository/7c386a739f915f5bd60051f2572c24782388e807.cmake-3.18.1-windows.zip


#DKIMPORT(https://dl.google.com/android/repository/7c386a739f915f5bd60051f2572c24782388e807.cmake-3.18.1-windows.zip)

WIN_DKSET(ANDROID_CMAKE_DL https://dl.google.com/android/repository/7c386a739f915f5bd60051f2572c24782388e807.cmake-3.18.1-windows.zip)
WIN_DKSET(ANDROID_CMAKE_NAME android-sdk/cmake)
WIN_DKSET(ANDROID_CMAKE ${3RDPARTY}/${ANDROID_CMAKE_NAME})
dk_makeDirectory(${ANDROID_CMAKE})
WIN_DKINSTALL(${ANDROID_CMAKE_DL} android-cmake ${ANDROID_CMAKE})
