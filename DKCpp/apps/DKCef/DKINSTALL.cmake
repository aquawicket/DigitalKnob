#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
dk_validate(CONFIG_PATH  "dk_CONFIG_PATH()")

dk_enable(HAVE_DKCef) ##FIXME: Find a way to remove this requirement

dk_depend(DK)
dk_depend(DKArchive)
dk_depend(DKAssets)
## dk_depend(DKDebug)
dk_depend(DKDuktape)
#dk_depend(DKDuktapeDom)
dk_depend(DKCef)
dk_depend(DKCefChild)
dk_depend(DKFile)
dk_depend(DKGui)
