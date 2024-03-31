if(HAVE_DKDuktape)
	dk_depend(DKDuktape)
endif()
if(HAVE_DKCef)
	dk_depend(DKCef)
endif()

dk_generateCmake(DKAudio)
dk_assets(DKAudio)
