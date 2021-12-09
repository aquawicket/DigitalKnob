## DKDEPEND(DKRml)
## DKDEPEND(DKMySql)
## DKDEPEND(DKWindow)
## DKDEPEND(DKGui)
IF(HAVE_DKDuktape)
	DKDEPEND(DKDuktape)
ENDIF()
IF(HAVE_DKCef)
	DKDEPEND(DKCef)
ENDIF()


## generateCmake(DKWidget)
## DKASSETS(DKWidget)
