#if(WIN)
#	dk_depend(libvncserver-master-win)
#else()
#	dk_depend(libvncserver-master)
#endif()
dk_depend(libvncserver)

dk_generateCmake(DKVncServer)