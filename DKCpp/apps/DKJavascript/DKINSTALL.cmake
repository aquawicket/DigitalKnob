#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
dk_validate(CONFIG_PATH  "dk_CONFIG_PATH()")

dk_depend(DK)
dk_depend(DKDuktape)
dk_depend(DKDuktapeDebugger)
dk_depend(DKArchive)
dk_depend(DKAssets)
dk_depend(DKFmt)
