DKDEPEND(DKCurl)
DKDEPEND(DKArchive)
IF(USE_DKDuktape)
	DKDEPEND(DKDuktape)
ENDIF()
IF(USE_DKDuktape)
	DKDEPEND(DKDuktape)
ENDIF()
IF(USE_DKCef)
	DKDEPEND(DKCef)
ENDIF()


generateCmake(DKUpdate)
