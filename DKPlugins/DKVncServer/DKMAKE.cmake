IF(WIN)
	dk_depend(libvncserver-master-win)
ELSE()
	dk_depend(libvncserver-master)
ENDIF()

dk_generateCmake(DKVncServer)