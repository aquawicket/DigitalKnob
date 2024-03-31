#dk_depend(libvncserver-master)
dk_depend(libvncserver)
dk_depend(DKSDLWindow)
if(HAVE_DKDuktape)
	dk_depend(DKDuktape)
endif()
if(HAVE_DKCef)
	dk_depend(DKCef)
endif()


dk_generateCmake(DKVncClient)