dk_depend(DKRml)
if(HAVE_DKDuktape)
	dk_depend(DKDuktape)
endif()

dk_generateCmake(DKRmlAudio)
dk_assets(DKRmlAudio)
