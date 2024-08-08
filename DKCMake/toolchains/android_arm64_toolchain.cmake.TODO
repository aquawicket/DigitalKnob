include_guard()

message(STATUS "##############################################################")
message(STATUS "################# android_arm64_toolchain.cmake ##############")
message(STATUS "##############################################################")

include($ENV{DKCMAKE_DIR}/functions/dk_load.cmake)
dk_load(dk_getHostTriple)
dk_getHostTriple()
dk_load(${DKIMPORTS_DIR}/android-ndk/DKMAKE.cmake)
dk_load(${ANDROID_TOOLCHAIN_FILE})