## DKDEPEND(DKRml)
## DKDEPEND(DKMySql)
## DKDEPEND(DKWindow)
## DKDEPEND(DKGui)
IF(USE_DKDuktape)
	DKDEPEND(DKDuktape)
ENDIF()
IF(USE_DKCef)
	DKDEPEND(DKCef)
ENDIF()


## generateCmake(DKWidget)
## DKASSETS(DKWidget)
