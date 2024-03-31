#if(NOT HAVE_DKCef)
#	RETURN()
#endif()

dk_depend(DKRml)
if(HAVE_DKDuktape)
	dk_depend(DKDuktape)
endif()
if(HAVE_DKCef)
	dk_depend(DKCef)
endif()

dk_generateCmake(DKRmlIframe)
dk_assets(DKRmlIframe)
