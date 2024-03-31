if(HAVE_DKDuktape)
	dk_depend(DKDuktape)
endif()
if(HAVE_DKCef)
	dk_depend(DKCef)
endif()

dk_depend(DKInterface)

dk_generateCmake(DKConsole)
dk_assets(DKConsole)