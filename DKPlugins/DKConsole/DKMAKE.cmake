IF(HAVE_DKDuktape)
	dk_depend(DKDuktape)
ENDIF()
IF(HAVE_DKCef)
	dk_depend(DKCef)
ENDIF()

dk_depend(DKInterface)

dk_generateCmake(DKConsole)
dk_assets(DKConsole)