IF(NOT WIN)
	RETURN()
ENDIF()
IF(HAVE_DKDuktape)
	dk_depend(DKDuktape)
ENDIF()
IF(HAVE_DKCef)
	dk_depend(DKCef)
ENDIF()


generateCmake(DKHandles)
dk_assets(DKHandles)