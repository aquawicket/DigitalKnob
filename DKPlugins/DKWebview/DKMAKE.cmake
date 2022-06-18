IF(NOT ANDROID)
	RETURN()
ENDIF()

dk_generateCmake(DKWebview)
dk_assets(DKWebview)