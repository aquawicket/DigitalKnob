IF(ANDROID)
	RETURN()
ENDIF()
IF(IOS)
	RETURN()
ENDIF()
IF(IOSSIM)
	RETURN()
ENDIF()

dk_depend(rtmidi)
IF(HAVE_DKDuktape)
	dk_depend(DKDuktape)
ENDIF()
IF(HAVE_DKCef)
	dk_depend(DKCef)
ENDIF()


dk_generateCmake(DKMidi)
dk_assets(DKMidi)
