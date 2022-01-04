# https://marketplace.visualstudio.com/items?itemName=VisualCPPTeam.JavaToolsForAndroidProjVS2019
#
# https://marketplace.visualstudio.com/_apis/public/gallery/publishers/VisualCPPTeam/vsextensions/JavaToolsForAndroidProjVS2019/2.8/vspackage
if(NOT WIN_HOST)
	return()
endif()


### VERSION ####
DKSET(ANDROID_CMAKE_VERSION 3.18.1)
DKSET(ANDROID_CMAKE_DL  https://marketplace.visualstudio.com/_apis/public/gallery/publishers/VisualCPPTeam/vsextensions/JavaToolsForAndroidProjVS2019/2.8/vspackage)



### INSTALL ###
DKSET(ANDROID_CMAKE_NAME android_cmake-${ANDROID_CMAKE_VERSION})
DKSET(ANDROID_CMAKE ${3RDPARTY}/android-sdk/cmake/${ANDROID_CMAKE_VERSION})
DKINSTALL(${ANDROID_CMAKE_DL} android-java-tools ${ANDROID_CMAKE})

