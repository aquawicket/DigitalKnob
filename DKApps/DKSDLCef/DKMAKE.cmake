#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)

dk_enable(HAVE_DKCef) ##FIXME: Find a way to remove this requirement

dk_depend(DK)
dk_depend(DKAssets)
dk_depend(DKDebug)
dk_depend(DKDuktape)
#dk_depend(DKDuktapeDom)
dk_depend(DKFile)
dk_depend(DKGui)
dk_depend(DKSDLCef)
dk_depend(DKSDLText)
dk_depend(DKSDLWindow)
dk_depend(DKWindow)
