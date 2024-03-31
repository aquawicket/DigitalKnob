## dk_depend(DKRml)
## dk_depend(DKMySql)
## dk_depend(DKWindow)
## dk_depend(DKGui)
if(HAVE_DKDuktape)
	dk_depend(DKDuktape)
endif()
if(HAVE_DKCef)
	dk_depend(DKCef)
endif()


## dk_generateCmake(DKWidget)
## dk_assets(DKWidget)
