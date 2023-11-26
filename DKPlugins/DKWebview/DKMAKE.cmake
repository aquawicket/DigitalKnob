if(NOT ANDROID)
	return()
endif()

dk_generateCmake(DKWebview)
dk_assets(DKWebview)
