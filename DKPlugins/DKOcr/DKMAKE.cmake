dk_depend(tesseract)
dk_depend(DKImageMagick)
##dk_depend(podofo)
if(HAVE_DKDuktape)
	dk_depend(DKDuktape)
endif()
if(HAVE_DKCef)
	dk_depend(DKCef)
endif()


dk_generateCmake(DKOcr)
dk_assets(DKOcr)
