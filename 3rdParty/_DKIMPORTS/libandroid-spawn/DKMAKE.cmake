include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://github.com/termux/termux-packages/blob/master/packages/libandroid-spawn/build.sh

ANDROID_HOST_dk_command(pkg install libandroid-spawn)