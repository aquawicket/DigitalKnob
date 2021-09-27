if(WIN)
	DKDEFINE(_SILENCE_EXPERIMENTAL_FILESYSTEM_DEPRECATION_WARNING)
	LIST(APPEND WIN_LIBS Psapi.lib) # GetProcessMemoryInfo()
	LIST(APPEND WIN_LIBS pdh.lib)   # PdhOpenQueryA()
	LIST(APPEND WIN_LIBS Dxva2.dll) # GetNumberOfPhysicalMonitorsFromHMONITOR()
	DKDEPEND(boxer)
endif()

if(MAC)
	DKDEPEND(boxer)
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
