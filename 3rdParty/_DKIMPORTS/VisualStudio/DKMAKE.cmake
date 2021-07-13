if(NOT CMAKE_HOST_WIN32)
	return()
endif()

### VERSION ###
DKSET(VISUALSTUDIO_VERSION 2019)
DKSET(VC_EXE "C:/Program Files (x86)/Microsoft Visual Studio/${VISUALSTUDIO_VERSION}/Community/MSBuild/Current/Bin/MSBuild.exe")
DKSET(GENERATOR "Visual Studio 16 ${VISUALSTUDIO_VERSION}")


### INSTALL ###
IF(NOT EXISTS "C:/Program Files (x86)/Microsoft Visual Studio/${VISUALSTUDIO_VERSION}/Community")
	MESSAGE(STATUS "Installing Visual Studio ${VISUALSTUDIO_VERSION}")
	DKSETPATH(${DIGITALKNOB}/Download)
	## https://download.visualstudio.microsoft.com/download/pr/5e397ebe-38b2-4e18-a187-ac313d07332a/169156e6e9a005d49b357c42240184dc1e3ccc28ebc777e70d49257c074f77e8/vs_Community.exe
	DKDOWNLOAD(https://download.visualstudio.microsoft.com/download/pr/5e397ebe-38b2-4e18-a187-ac313d07332a/169156e6e9a005d49b357c42240184dc1e3ccc28ebc777e70d49257c074f77e8/vs_Community.exe)
	DKSET(QUEUE_BUILD ON)
	WIN32_COMMAND(${DIGITALKNOB}/Download/vs_Community.exe)
ENDIF()
