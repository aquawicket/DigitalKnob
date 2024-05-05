# Secur32.Lib

if(NOT WIN)
	dk_undepend(secur32.lib)
	dk_return()
endif()

dk_findLibrary(Secur32.Lib)
