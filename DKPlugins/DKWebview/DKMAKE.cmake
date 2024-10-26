if(NOT ANDROID)
	dk_return()
endif()

dk_generateCmake(DKWebview)
dk_assets(DKWebview)
