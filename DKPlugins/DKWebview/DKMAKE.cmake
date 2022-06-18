IF(NOT ANDROID)
	RETURN()
ENDIF()

generateCmake(DKWebview)
dk_assets(DKWebview)