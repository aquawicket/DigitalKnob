include_guard()
# https://dl.google.com/android/repository/7c386a739f915f5bd60051f2572c24782388e807.cmake-3.18.1-windows.zip


dk_set(ANDROID-CMAKE_DL https://dl.google.com/android/repository/7c386a739f915f5bd60051f2572c24782388e807.cmake-3.18.1-windows.zip)
dk_set(ANDROID-CMAKE_NAME android-sdk/cmake)
dk_set(ANDROID-CMAKE ${3RDPARTY}/${ANDROID-CMAKE_NAME})
dk_install(${ANDROID-CMAKE_DL} ${ANDROID-CMAKE})
#dk_import(https://dl.google.com/android/repository/7c386a739f915f5bd60051f2572c24782388e807.cmake-3.18.1-windows.zip)
