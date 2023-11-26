#dk_depend(libvncserver-master)
dk_depend(libvncserver)
dk_depend(DKSDLWindow)
IF(HAVE_DKDuktape)
	dk_depend(DKDuktape)
ENDIF()
IF(HAVE_DKCef)
	dk_depend(DKCef)
ENDIF()


dk_generateCmake(DKVncClient)