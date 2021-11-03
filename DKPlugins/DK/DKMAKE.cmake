if(WIN)
	DKDEFINE(_SILENCE_EXPERIMENTAL_FILESYSTEM_DEPRECATION_WARNING)
	WIN_LIB(Psapi.lib) # GetProcessMemoryInfo()
	WIN_LIB(pdh.lib)   # PdhOpenQueryA()
	WIN_LIB(Dxva2.dll) # GetNumberOfPhysicalMonitorsFromHMONITOR()
	DKDEPEND(boxer)
endif()

if(MAC)
	DKDEPEND(boxer)
	DKDEPEND(core_foundation)
	DKDEPEND(core_graphics)
	DKDEPEND(carbon) #for DKOSinfo.cpp Gestalt()
	DKDEPEND(iokit) #for DKMac.cpp IO*() and kIO*()
endif()

if(IOS OR IOSSIM)
	LIST(APPEND DK_SRC DK/DKiPhone.mm)
endif()

if(LINUX)
	DKDEPEND(mesa-common-dev)
	DKDEPEND(libgl1-mesa-dev)
	DKDEPEND(libxrandr-dev)
	DKDEPEND(libasound2-dev) ##TODO: Move to DKAudio
	DKDEPEND(libxtst-dev)
	DKDEPEND(simple-getch)
	DKDEPEND(boxer)
endif()

if(RASPBERRY)
	DKDEPEND(mesa-common-dev)
	DKDEPEND(libgl1-mesa-dev)
	DKDEPEND(libxrandr-dev)
	DKDEPEND(libasound2-dev) ##TODO: Move to DKAudio
	DKDEPEND(libxtst-dev)
	DKDEPEND(simple-getch)
	DKDEPEND(boxer)
endif()

if(ANDROID)

endif()


DKPLUGIN(DK)
DKASSETS(DK)
