dk_depend(DKRml)
#IF(HAVE_DKDuktape)
#	dk_depend(DKDuktape)
#ENDIF()

dk_generateCmake(DKRmlTestElements)
dk_assets(DKRmlTestElements)
