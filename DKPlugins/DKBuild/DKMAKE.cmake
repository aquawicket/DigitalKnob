dk_depend(DKCurl)
dk_depend(DKArchive)
if(WIN)
	dk_depend(imagemagick)
endif()

dk_assets(DKBuild)