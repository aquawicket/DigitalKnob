# https://marketplace.visualstudio.com/items?itemName=VisualCPPTeam.JavaToolsForAndroidProjVS2019
#
# https://marketplace.visualstudio.com/_apis/public/gallery/publishers/VisualCPPTeam/vsextensions/JavaToolsForAndroidProjVS2019/2.8/vspackage
if(NOT WIN_HOST)
	return()
endif()


dk_import(https://marketplace.visualstudio.com/_apis/public/gallery/publishers/VisualCPPTeam/vsextensions/JavaToolsForAndroidProjVS2019/2.8/vspackage)


#dk_set(ANDROID-JAVA-TOOLS_VERSION 2.8)
#dk_set(ANDROID-JAVA-TOOLS_NAME androoidjavatools-${ANDROID-JAVA-TOOLS_VERSION})
#dk_set(ANDROID-JAVA-TOOLS_DL https://marketplace.visualstudio.com/_apis/public/gallery/publishers/VisualCPPTeam/vsextensions/JavaToolsForAndroidProjVS2019/2.8/vspackage)
#dk_set(ANDROID-JAVA-TOOLS ${3RDPARTY}/${ANDROID-JAVA-TOOLS_NAME})
#dk_install(${ANDROID-JAVA-TOOLS_DL} android-java-tools ${ANDROID-JAVA-TOOLS})