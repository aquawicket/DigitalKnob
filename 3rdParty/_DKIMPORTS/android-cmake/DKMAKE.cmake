# https://dl.google.com/android/repository/7c386a739f915f5bd60051f2572c24782388e807.cmake-3.18.1-windows.zip

#dk_set(ANDROID-SDK ${3RDPARTY}/android-sdk)
#dk_makeDirectory(${ANDROID-SDK})
dk_depend(android-sdk)

dk_import(https://dl.google.com/android/repository/7c386a739f915f5bd60051f2572c24782388e807.cmake-3.18.1-windows.zip PATH ${ANDROID-SDK}/cmake)
