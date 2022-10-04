# https://marketplace.visualstudio.com/items?itemName=VisualCPPTeam.JavaToolsForAndroidProjVS2019
# https://marketplace.visualstudio.com/_apis/public/gallery/publishers/VisualCPPTeam/vsextensions/JavaToolsForAndroidProjVS2019/2.8/vspackage
if(NOT ANDROID OR NOT WIN_HOST)
	dk_undepend(android-java-tools)
	return()
endif()


dk_depend(visualstudio)


dk_import(https://marketplace.visualstudio.com/_apis/public/gallery/publishers/VisualCPPTeam/vsextensions/JavaToolsForAndroidProjVS2019/2.8/vspackage PATH ${3RDPARTY}/androoidjavatools-2.8)
