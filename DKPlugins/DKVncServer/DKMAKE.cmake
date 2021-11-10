IF(WIN)
	DKDEPEND(libvncserver-master-win)
ELSE()
	DKDEPEND(libvncserver-master)
ENDIF()

generateCmake(DKVncServer)