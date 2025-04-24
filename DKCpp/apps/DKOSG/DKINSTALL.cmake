#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
dk_load(dk_builder)

dk_depend(openscenegraph)
#dk_depend(osg_ttf)
dk_depend(DK)
dk_depend(DKAssets)
dk_depend(DKDuktape)
#dk_depend(DKDuktapeDom)
dk_depend(DKFile)
dk_depend(DKOSGWindow)
dk_depend(DKWindow)
#dk_depend(DKOSGText)
