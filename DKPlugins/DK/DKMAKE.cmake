if(WIN)
	DKDEFINE(_SILENCE_EXPERIMENTAL_FILESYSTEM_DEPRECATION_WARNING)
	LIST(APPEND WIN_LIBS Psapi.lib) # GetProcessMemoryInfo()
	LIST(APPEND WIN_LIBS pdh.lib)   # PdhOpenQueryA()
	LIST(APPEND WIN_LIBS Dxva2.dll) # GetNumberOfPhysicalMonitorsFromHMONITOR()
	#LIST(APPEND WIN_LIBS shell32.lib)
	#LIST(APPEND WIN_LIBS user32.lib)
	#LIST(APPEND WIN_LIBS gdi32.lib)
	#LIST(APPEND WIN_LIBS ole32.lib)
	#LIST(APPEND WIN_LIBS Comctl32.lib)
endif()

if(MAC)

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
endif()

if(RASPBERRY)
	DKDEPEND(mesa-common-dev)
	DKDEPEND(libgl1-mesa-dev)
	DKDEPEND(libxrandr-dev)
	DKDEPEND(libasound2-dev) ##TODO: Move to DKAudio
	DKDEPEND(libxtst-dev)
endif()

if(ANDROID)

endif()



DKPLUGIN(DK)
DKASSETS(DK)
