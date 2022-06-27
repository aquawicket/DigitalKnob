include_guard()
# https://marketplace.visualstudio.com/items?itemName=VisualCPPTeam.JavaToolsForAndroidProjVS2019
#
# https://marketplace.visualstudio.com/_apis/public/gallery/publishers/VisualCPPTeam/vsextensions/JavaToolsForAndroidProjVS2019/2.8/vspackage
if(NOT WIN_HOST)
	return()
endif()

#dk_install(https://marketplace.visualstudio.com/_apis/public/gallery/publishers/VisualCPPTeam/vsextensions/JavaToolsForAndroidProjVS2019/2.8/vspackage ${3RDPARTY}/androoidjavatools-2.8)
dk_import(https://marketplace.visualstudio.com/_apis/public/gallery/publishers/VisualCPPTeam/vsextensions/JavaToolsForAndroidProjVS2019/2.8/vspackage)