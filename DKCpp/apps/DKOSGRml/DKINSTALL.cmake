#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
dk_load(dk_builder)

dk_depend(openscenegraph)
dk_depend(DK)
dk_depend(DKArchive)
dk_depend(DKAssets)
dk_depend(DKDebug)
dk_depend(DKDom)
dk_depend(DKDuktape)
#dk_depend(DKDuktapeDom)
dk_depend(DKRmlElement)
dk_depend(DKRmlVideo)
#dk_depend(osg_gif)
dk_depend(rmlui)
dk_depend(DKOSGRml)
dk_depend(DKOSGWindow)
dk_depend(DKThread)
dk_depend(DKWebTest)
dk_depend(DKWindow)