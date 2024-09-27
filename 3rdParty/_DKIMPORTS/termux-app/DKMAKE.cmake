#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://github.com/termux/termux-app.git
# https://www.macrodroidforum.com/index.php?threads/guide-setting-up-and-using-adb-commands-with-termux.5640/

#dk_import(https://github.com/termux/termux-app.git)
dk_import(https://github.com/termux/termux-app/archive/refs/heads/master.zip)
