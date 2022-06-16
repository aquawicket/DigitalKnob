# https://marketplace.visualstudio.com/items?itemName=VisualCPPTeam.JavaToolsForAndroidProjVS2019
#
# https://marketplace.visualstudio.com/_apis/public/gallery/publishers/VisualCPPTeam/vsextensions/JavaToolsForAndroidProjVS2019/2.8/vspackage
if(NOT WIN_HOST)
	return()
endif()


DKIMPORT(https://marketplace.visualstudio.com/_apis/public/gallery/publishers/VisualCPPTeam/vsextensions/JavaToolsForAndroidProjVS2019/2.8/vspackage)


#DKSET(ANDROIDJAVA_VERSION 2.8)
#DKSET(ANDROIDJAVA_NAME androoidjavatools-${ANDROIDJAVA_VERSION})
#DKSET(ANDROIDJAVA_DL https://marketplace.visualstudio.com/_apis/public/gallery/publishers/VisualCPPTeam/vsextensions/JavaToolsForAndroidProjVS2019/2.8/vspackage)
#DKSET(ANDROIDJAVA ${3RDPARTY}/${ANDROIDJAVA_NAME})
#DKINSTALL(${ANDROIDJAVA_DL} android-java-tools ${ANDROIDJAVA})