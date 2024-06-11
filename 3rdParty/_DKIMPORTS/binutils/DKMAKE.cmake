include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# binutils

# https://wiki.termux.com/wiki/ASM
if(ANDROID_HOST)
	dk_command(pkg install binutils)
endif()