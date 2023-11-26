# vccorlib.lib

if(NOT WIN)
	dk_undepend(vccorlib.lib)
	dk_return()
endif()

dk_findLibrary(vccorlib.lib)
