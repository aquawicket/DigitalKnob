#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
dk_load(dk_builder)

dk_depend(DK)
dk_depend(DKArchive)
dk_depend(DKAssets)
dk_depend(DKBuild)
dk_depend(DKDebug)
#dk_depend(DKDukDebugger)
dk_depend(DKDuktape)
dk_depend(DKDuktapeDom)
dk_depend(DKFile)
dk_depend(DKGit)
