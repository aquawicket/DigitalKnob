# strmiids.lib

if(NOT WIN)
	dk_undepend(strmiids.lib)
	dk_return()
endif()

dk_findLibrary(strmiids.lib)
