#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
dk_load(dk_builder)

dk_depend(DK)
dk_depend(DKAssets)
dk_depend(DKDebug)
dk_depend(DKDuktape)
dk_depend(DKFile)
dk_depend(DKSDLOsg)
dk_depend(DKSDLText)
dk_depend(DKSDLWindow)
dk_depend(DKWindow)
