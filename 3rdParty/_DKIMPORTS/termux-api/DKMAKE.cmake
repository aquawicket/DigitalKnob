include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://github.com/termux/termux-api.git
# https://aktermux.in/adb-in-termux/#howto-step-1680021612068
# https://github.com/termux/termux-api/releases/download/v0.50.1/termux-api_v0.50.1+github-debug.apk

#dk_import(https://github.com/termux/termux-api.git)
dk_import(https://github.com/termux/termux-api/archive/refs/heads/master.zip)
