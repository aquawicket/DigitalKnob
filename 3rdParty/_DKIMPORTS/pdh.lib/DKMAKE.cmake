if(NOT WIN)
	dk_undepend(pdh.lib)
	dk_return()
endif()

dk_findLibrary(pdh.lib)
