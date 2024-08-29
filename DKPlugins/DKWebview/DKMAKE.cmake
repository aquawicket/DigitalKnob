if(NOT ANDROID_TARGET)
	return()
endif()

dk_generateCmake(DKWebview)
dk_assets(DKWebview)
