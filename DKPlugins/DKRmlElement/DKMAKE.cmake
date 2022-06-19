#IF(NOT HAVE_DKCef)
#	RETURN()
#ENDIF()

dk_depend(DKRml)
IF(HAVE_DKDuktape)
	dk_depend(DKDuktape)
ENDIF()
IF(HAVE_DKCef)
	dk_depend(DKCef)
ENDIF()

dk_generateCmake(DKRmlElement)
dk_assets(DKRmlElement)
