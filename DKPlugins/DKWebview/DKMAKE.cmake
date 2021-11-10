IF(NOT ANDROID)
	RETURN()
ENDIF()

generateCmake(DKWebview)
DKASSETS(DKWebview)