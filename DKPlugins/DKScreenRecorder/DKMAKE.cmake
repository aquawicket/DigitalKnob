dk_depend(core_graphics)
dk_depend(opencv)
if(HAVE_DKDuktape)
	dk_depend(DKDuktape)
endif()
if(HAVE_DKCef)
	dk_depend(DKCef)
endif()


dk_generateCmake(DKScreenRecorder)