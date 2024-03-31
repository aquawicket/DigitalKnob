dk_depend(DKRml)
#if(HAVE_DKDuktape)
#	dk_depend(DKDuktape)
#endif()

dk_generateCmake(DKRmlTestElements)
dk_assets(DKRmlTestElements)
