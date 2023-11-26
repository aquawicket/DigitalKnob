## dk_depend(DKRml)
## dk_depend(DKMySql)
## dk_depend(DKWindow)
## dk_depend(DKGui)
IF(HAVE_DKDuktape)
	dk_depend(DKDuktape)
ENDIF()
IF(HAVE_DKCef)
	dk_depend(DKCef)
ENDIF()


## dk_generateCmake(DKWidget)
## dk_assets(DKWidget)
