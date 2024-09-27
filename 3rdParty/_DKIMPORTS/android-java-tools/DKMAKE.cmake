#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://marketplace.visualstudio.com/items?itemName=VisualCPPTeam.JavaToolsForAndroidProjVS2019
# https://marketplace.visualstudio.com/_apis/public/gallery/publishers/VisualCPPTeam/vsextensions/JavaToolsForAndroidProjVS2019/2.8/vspackage
# https://visualcppteam.gallerycdn.vsassets.io/extensions/visualcppteam/javatoolsforandroidprojvs2019/2.8/1561139034309/AndroidJavaTools28.vsix
if(NOT ANDROID OR NOT WIN_HOST)
	dk_undepend(android-java-tools)
	dk_return()
endif()


dk_depend(visualstudio)


#dk_import(https://marketplace.visualstudio.com/_apis/public/gallery/publishers/VisualCPPTeam/vsextensions/JavaToolsForAndroidProjVS2019/2.8/vspackage PATH ${DK3RDPARTY_DIR}/androoidjavatools-2.8)
dk_import(https://visualcppteam.gallerycdn.vsassets.io/extensions/visualcppteam/javatoolsforandroidprojvs2019/2.8/1561139034309/AndroidJavaTools28.vsix PATH ${DK3RDPARTY_DIR}/androoidjavatools-2.8)