DKDEPEND(libvncserver-master)
DKDEPEND(DKSDLWindow)
IF(HAVE_DKDuktape)
	DKDEPEND(DKDuktape)
ENDIF()
IF(HAVE_DKCef)
	DKDEPEND(DKCef)
ENDIF()


generateCmake(DKVncClient)