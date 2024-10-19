#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


###### android-java-tools ######
# https://marketplace.visualstudio.com/items?itemName=VisualCPPTeam.JavaToolsForAndroidProjVS2019
# https://marketplace.visualstudio.com/_apis/public/gallery/publishers/VisualCPPTeam/vsextensions/JavaToolsForAndroidProjVS2019/2.8/vspackage
# https://visualcppteam.gallerycdn.vsassets.io/extensions/visualcppteam/javatoolsforandroidprojvs2019/2.8/1561139034309/AndroidJavaTools28.vsix
dk_depend(visualstudio)

#dk_getFileParam(${DKIMPORTS_DIR}/android-java-tools/android-java-tools.txt VERSION)

dk_validate(DK3RDPARTY_DIR "dk_DKBRANCH_DIR()")
#dk_import(https://marketplace.visualstudio.com/_apis/public/gallery/publishers/VisualCPPTeam/vsextensions/JavaToolsForAndroidProjVS2019/2.8/vspackage PATH ${DK3RDPARTY_DIR}/androoidjavatools-2.8)
dk_import(https://visualcppteam.gallerycdn.vsassets.io/extensions/visualcppteam/javatoolsforandroidprojvs2019/2.8/1561139034309/AndroidJavaTools28.vsix PATH ${DK3RDPARTY_DIR}/androoidjavatools-2.8)
