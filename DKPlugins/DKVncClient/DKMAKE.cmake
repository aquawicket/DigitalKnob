dk_depend(libvncserver-master)
dk_depend(DKSDLWindow)
IF(HAVE_DKDuktape)
	dk_depend(DKDuktape)
ENDIF()
IF(HAVE_DKCef)
	dk_depend(DKCef)
ENDIF()


generateCmake(DKVncClient)