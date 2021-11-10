IF(USE_DKDuktape)
	DKDEPEND(DKDuktape)
ENDIF()
IF(USE_DKCef)
	DKDEPEND(DKCef)
ENDIF()

generateCmake(DKAudio)
DKASSETS(DKAudio)
