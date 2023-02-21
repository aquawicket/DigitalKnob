#dk_depend(tray)
dk_depend(DKRml) # used for javascript events

if(HAVE_DKDuktape)
	dk_depend(DKDuktape)
endif()
if(HAVE_DKCef)
	dk_depend(DKCef)
endif()

dk_generateCmake(DKTray)
dk_assets(DKTray)