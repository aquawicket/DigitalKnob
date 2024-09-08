dk_depend(fmt)

dk_append(CMAKE_C_FLAGS "/utf-8")
dk_append(CMAKE_CXX_FLAGS "/utf-8")


if(HAVE_DKDuktape)
	dk_depend(DKDuktape)
endif()
if(HAVE_DKCef)
	dk_depend(DKCef)
endif()
dk_generateCmake(DKFmt)
dk_assets(DKFmt)