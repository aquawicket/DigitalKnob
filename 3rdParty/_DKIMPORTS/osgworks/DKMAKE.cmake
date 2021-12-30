### DEPENDS ###
DKDEPEND(openscenegraph)


### VERSION ###
DKSET(OSGWORKS_VERSION master)
DKSET(OSGWORKS_NAME osgworks-${OSGWORKS_VERSION})
DKSET(OSGWORKS_DL http://TODO.com/osgworks-master.zip )
DKSET(OSGWORKS ${3RDPARTY}/${OSGWORKS_NAME})
DKSET(OSGWORKS_GL2 ${3RDPARTY}/${OSGWORKS_NAME}-GL2)
IF(OpenGL2)
	DKSET(OSGWORKS OSGWORKS_GL2)
ENDIF(OpenGL2)


### INSTALL ###
DKINSTALL(${OSGWORKS_DL} osgworks ${OSGWORKS})



### LINK ###
DKINCLUDE(${OSGWORKS}/include)
DKDEFINE(OSGWORKS_STATIC)

IF(osgdb_osgobjects)
	WIN_DEBUG_DKLIB(${OSGWORKS}/${OS}/lib/Debug/osgdb_osgobjectsd.lib)
	WIN_RELEASE_DKLIB(${OSGWORKS}/${OS}/lib/${RELEASE}/osgdb_osgobjects.lib)
	APPLE_DEBUG_DKLIB(${OSGWORKS}/${OS}/lib/${DEBUG}/osgdb_osgobjects.a)
	APPLE_RELEASE_DKLIB(${OSGWORKS}/${OS}/lib/${RELEASE}/osgdb_osgobjects.a)
	LINUX_DEBUG_DKLIB(${OSGWORKS}/${OS}/Debug/lib/osgdb_osgobjects.a)
	LINUX_RELEASE_DKLIB(${OSGWORKS}/${OS}/Release/lib/osgdb_osgobjects.a)
	ANDROID_DEBUG_DKLIB(${OSGWORKS}/${OS}/Debug/obj/local/armeabi-v7a/libosgdb_osgobjects.a)
	ANDROID_RELEASE_DKLIB(${OSGWORKS}/${OS}/Release/obj/local/armeabi-v7a/libosgdb_osgobjects.a)
ENDIF(osgdb_osgobjects)
	
IF(osgdb_osgwTools)
	WIN_DEBUG_DKLIB(${OSGWORKS}/${OS}/lib/Debug/osgdb_osgwToolsd.lib)
	WIN_RELEASE_DKLIB(${OSGWORKS}/${OS}/lib/Release/osgdb_osgwTools.lib)
	APPLE_DEBUG_DKLIB(${OSGWORKS}/${OS}/lib/${DEBUG}/osgdb_osgwTools.a)
	APPLE_RELEASE_DKLIB(${OSGWORKS}/${OS}/lib/${RELEASE}/osgdb_osgwTools.a)
	LINUX_DEBUG_DKLIB(${OSGWORKS}/${OS}/Debug/lib/osgdb_osgwTools.a)
	LINUX_RELEASE_DKLIB(${OSGWORKS}/${OS}/Release/lib/osgdb_osgwTools.a)
	ANDROID_DEBUG_DKLIB(${OSGWORKS}/${OS}/Debug/obj/local/armeabi-v7a/libosgdb_osgwTools.a)
	ANDROID_RELEASE_DKLIB(${OSGWORKS}/${OS}/Release/obj/local/armeabi-v7a/libosgdb_osgwTools.a)
ENDIF(osgdb_osgwTools)
	
IF(osgdb_skeleton)
	WIN_DEBUG_DKLIB(${OSGWORKS}/${OS}/lib/Debug/osgdb_skeletond.lib)
	WIN_RELEASE_DKLIB(${OSGWORKS}/${OS}/lib/Release/osgdb_skeleton.lib)
	APPLE_DEBUG_DKLIB(${OSGWORKS}/${OS}/lib/${DEBUG}/osgdb_skeleton.a)
	APPLE_RELEASE_DKLIB(${OSGWORKS}/${OS}/lib/${RELEASE}/osgdb_skeleton.a)
	LINUX_DEBUG_DKLIB(${OSGWORKS}/${OS}/Debug/lib/osgdb_skeleton.a)
	LINUX_RELEASE_DKLIB(${OSGWORKS}/${OS}/Release/lib/osgdb_skeleton.a)
	ANDROID_DEBUG_DKLIB(${OSGWORKS}/${OS}/Debug/obj/local/armeabi-v7a/libosgdb_skeleton.a)
	ANDROID_RELEASE_DKLIB(${OSGWORKS}/${OS}/Release/obj/local/armeabi-v7a/libosgdb_skeleton.a)
ENDIF(osgdb_skeleton)
	
IF(osgwControls)
	WIN_DEBUG_DKLIB(${OSGWORKS}/${OS}/lib/Debug/osgwControlsd.lib)
	WIN_RELEASE_DKLIB(${OSGWORKS}/${OS}/lib/Release/osgwControls.lib)
	APPLE_DEBUG_DKLIB(${OSGWORKS}/${OS}/lib/${DEBUG}/libosgwControls.a)
	APPLE_RELEASE_DKLIB(${OSGWORKS}/${OS}/lib/${RELEASE}/libosgwControls.a)
	LINUX_DEBUG_DKLIB(${OSGWORKS}/${OS}/Debug/lib/libosgwControls.a)
	LINUX_RELEASE_DKLIB(${OSGWORKS}/${OS}/Release/lib/libosgwControls.a)
	ANDROID_DEBUG_DKLIB(${OSGWORKS}/${OS}/Debug/obj/local/armeabi-v7a/libosgwControls.a)
	ANDROID_RELEASE_DKLIB(${OSGWORKS}/${OS}/Release/obj/local/armeabi-v7a/libosgwControls.a)
ENDIF(osgwControls)
	
IF(osgwMx)
	WIN_DEBUG_DKLIB(${OSGWORKS}/${OS}/lib/Debug/osgwMxd.lib)
	WIN_RELEASE_DKLIB(${OSGWORKS}/${OS}/lib/Release/osgwMx.lib)
	APPLE_DEBUG_DKLIB(${OSGWORKS}/${OS}/lib/${DEBUG}/libosgwMx.a)
	APPLE_RELEASE_DKLIB(${OSGWORKS}/${OS}/lib/${RELEASE}/libosgwMx.a)
	LINUX_DEBUG_DKLIB(${OSGWORKS}/${OS}/Debug/lib/libosgwMx.a)
	LINUX_RELEASE_DKLIB(${OSGWORKS}/${OS}/Release/lib/libosgwMx.a)
	ANDROID_DEBUG_DKLIB(${OSGWORKS}/${OS}/Debug/obj/local/armeabi-v7a/libosgwMx.a)
	ANDROID_RELEASE_DKLIB(${OSGWORKS}/${OS}/Release/obj/local/armeabi-v7a/libosgwMx.a)
ENDIF(osgwMx)
	
IF(osgwQuery)
	WIN_DEBUG_DKLIB(${OSGWORKS}/${OS}/lib/Debug/osgwQueryd.lib)
	WIN_RELEASE_DKLIB(${OSGWORKS}/${OS}/lib/Release/osgwQuery.lib)
	APPLE_DEBUG_DKLIB(${OSGWORKS}/${OS}/lib/${DEBUG}/libosgwQuery.a)
	APPLE_RELEASE_DKLIB(${OSGWORKS}/${OS}/lib/${RELEASE}/libosgwQuery.a)
	LINUX_DEBUG_DKLIB(${OSGWORKS}/${OS}/Debug/lib/libosgwQuery.a)
	LINUX_RELEASE_DKLIB(${OSGWORKS}/${OS}/Release/lib/libosgwQuery.a)
	ANDROID_DEBUG_DKLIB(${OSGWORKS}/${OS}/Debug/obj/local/armeabi-v7a/libosgwQuery.a)
	ANDROID_RELEASE_DKLIB(${OSGWORKS}/${OS}/Release/obj/local/armeabi-v7a/libosgwQuery.a)
ENDIF(osgwQuery)
	
IF(osgwTools)
	WIN_DEBUG_DKLIB(${OSGWORKS}/${OS}/lib/Debug/osgwToolsd.lib)
	WIN_RELEASE_DKLIB(${OSGWORKS}/${OS}/lib/Release/osgwTools.lib)
	APPLE_DEBUG_DKLIB(${OSGWORKS}/${OS}/lib/${DEBUG}/libosgwTools.a)
	APPLE_RELEASE_DKLIB(${OSGWORKS}/${OS}/lib/${RELEASE}/libosgwTools.a)
	LINUX_DEBUG_DKLIB(${OSGWORKS}/${OS}/Debug/lib/libosgwTools.a)
	LINUX_RELEASE_DKLIB(${OSGWORKS}/${OS}/Release/lib/libosgwTools.a)
	ANDROID_DEBUG_DKLIB(${OSGWORKS}/${OS}/Debug/obj/local/armeabi-v7a/libosgwTools.a)
	ANDROID_RELEASE_DKLIB(${OSGWORKS}/${OS}/Release/obj/local/armeabi-v7a/libosgwTools.a)
ENDIF(osgwTools)


### COMPILE ###
DKSETPATH(${OSGWORKS}/${BUILD_DIR})

WIN_DKQCOMMAND(${DKCMAKE_BUILD} "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/${OS} -DOSGSourceRoot=${OSG} -DOSGWORKS_BUILD_APPS=OFF -DOSGWORKS_INSTALL_DATA=OFF -DDIRECTINPUT_ARCH_x64=OFF -DBoost_INCLUDE_DIR=OFF ${OSGWORKS})
WIN_VS(osgworks-master osgWorks.sln)


MAC_DKQCOMMAND(${DKCMAKE_BUILD} "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/${OS} -DOSGSourceRoot=${OSG} -DOSGWORKS_BUILD_APPS=OFF -DOSGWORKS_INSTALL_DATA=OFF -DDIRECTINPUT_ARCH_x64=OFF -DBoost_INCLUDE_DIR=OFF ${OSGWORKS})
MAC_DEBUG_XCODE(osgworks-master)


IOS_DKQCOMMAND(${DKCMAKE_BUILD} "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/${OS} -DOSGSourceRoot=${OSG} -DOSGWORKS_BUILD_APPS=OFF -DOSGWORKS_INSTALL_DATA=OFF -DDIRECTINPUT_ARCH_x64=OFF -DBoost_INCLUDE_DIR=OFF ${OSGWORKS})
IOS_DEBUG_XCODE(osgworks-master)


IOSSIM_DKQCOMMAND(${DKCMAKE_BUILD} "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/${OS} -DOSGSourceRoot=${OSG} -DOSGWORKS_BUILD_APPS=OFF -DOSGWORKS_INSTALL_DATA=OFF -DDIRECTINPUT_ARCH_x64=OFF -DBoost_INCLUDE_DIR=OFF ${OSGWORKS})
IOSSIM_DEBUG_XCODE(osgworks-master)


LINUX_DEBUG_DKQCOMMAND(${DKCMAKE_BUILD} "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/${OS}/Debug -DOSGSourceRoot=${OSG} -DOSGWORKS_BUILD_APPS=OFF -DOSGWORKS_INSTALL_DATA=OFF -DDIRECTINPUT_ARCH_x64=OFF -DBoost_INCLUDE_DIR=OFF ${OSGWORKS})
LINUX_DEBUG_DKQCOMMAND(make)


LINUX_RELEASE_DKQCOMMAND(${DKCMAKE_BUILD} "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/${OS}/Release -DOSGSourceRoot=${OSG} -DOSGWORKS_BUILD_APPS=OFF -DOSGWORKS_INSTALL_DATA=OFF -DDIRECTINPUT_ARCH_x64=OFF -DBoost_INCLUDE_DIR=OFF ${OSGWORKS})
LINUX_RELEASE_DKQCOMMAND(make)


ANDROID_DKQCOMMAND(${DKCMAKE_BUILD} "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/${OS} -DOSGSourceRoot=${OSG} -DOSGWORKS_BUILD_APPS=OFF -DOSGWORKS_INSTALL_DATA=OFF -DDIRECTINPUT_ARCH_x64=OFF -DBoost_INCLUDE_DIR=OFF ${OSGWORKS})
ANDROID_VS(osgworks-master osgWorks.sln)
