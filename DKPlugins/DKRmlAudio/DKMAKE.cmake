dk_depend(DKRml)
IF(HAVE_DKDuktape)
	dk_depend(DKDuktape)
ENDIF()

dk_generateCmake(DKRmlAudio)
dk_assets(DKRmlAudio)
