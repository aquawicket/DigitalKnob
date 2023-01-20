# vfw32.lib

if(NOT WIN)
	dk_undepend(vfw32.lib)
	dk_return()
endif()

dk_findLibrary(vfw32.lib)
