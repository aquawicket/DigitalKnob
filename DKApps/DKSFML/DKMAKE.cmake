#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)

dk_depend(sfml)
#dk_depend(sfml_ttf)
dk_depend(DK)
dk_depend(DKAssets)
dk_depend(DKDuktape)
#dk_depend(DKDuktapeDom)
dk_depend(DKFile)
dk_depend(DKSFMLWindow)
dk_depend(DKWindow)
#dk_depend(DKSFMLText)
