### DKDEPENDS ###
#dk_depend(bullet)
dk_depend(bullet3)
dk_depend(osgworks)



#dk_import(http://TODO.com/osgbullet-master.zip)


dk_install(http://TODO.com/osgbullet-master.zip osgbullet-master)
dk_set(OSGBULLET ${3RDPARTY}/osgbullet-master)


### LINK ###
dk_set(OSGBULLET_GL2 ${3RDPARTY}/osgbullet-master-GL2)
IF(OpenGL2)
	dk_set(OSGBULLET OSGBULLET_GL2)
ENDIF(OpenGL2)

dk_include(${OSGBULLET}/include)
dk_define(OSGBULLET_STATIC)

IF(osgbCollision)
	dk_define(OSGBCOLLISION_LIBRARY)	
	WIN_DEBUG_DKLIB(${OSGBULLET}/${OS}/lib/Debug/osgbCollisiond.lib)
	WIN_RELEASE_DKLIB(${OSGBULLET}/${OS}/lib/Release/osgbCollision.lib)
	APPLE_DEBUG_DKLIB(${OSGBULLET}/${OS}/lib/${DEBUG}/libosgbCollision.a)
	APPLE_RELEASE_DKLIB(${OSGBULLET}/${OS}/lib/${RELEASE}/libosgbCollision.a)
	LINUX_DEBUG_DKLIB(${OSGBULLET}/${OS}/Debug/lib/libosgbCollision.a)
	LINUX_RELEASE_DKLIB(${OSGBULLET}/${OS}/Release/lib/libosgbCollision.a)
	ANDROID_DEBUG_DKLIB(${OSGBULLET}/${OS}/Debug/obj/local/armeabi-v7a/libosgbCollision.a)
	ANDROID_RELEASE_DKLIB(${OSGBULLET}/${OS}/Release/obj/local/armeabi-v7a/libosgbCollision.a)
ENDIF(osgbCollision)
	
IF(osgbDynamics)
	dk_define(OSGBDYNAMICS_LIBRARY)
	WIN_DEBUG_DKLIB(${OSGBULLET}/${OS}/lib/Debug/osgbDynamicsd.lib)
	WIN_RELEASE_DKLIB(${OSGBULLET}/${OS}/lib/Release/osgbDynamics.lib)
	APPLE_DEBUG_DKLIB(${OSGBULLET}/${OS}/lib/${DEBUG}/libosgbDynamics.a)
	APPLE_RELEASE_DKLIB(${OSGBULLET}/${OS}/lib/${RELEASE}/libosgbDynamics.a)
	LINUX_DEBUG_DKLIB(${OSGBULLET}/${OS}/Debug/lib/libosgbDynamics.a)
	LINUX_RELEASE_DKLIB(${OSGBULLET}/${OS}/Release/lib/libosgbDynamics.a)
	ANDROID_DEBUG_DKLIB(${OSGBULLET}/${OS}/Debug/obj/local/armeabi-v7a/libosgbDynamics.a)
	ANDROID_RELEASE_DKLIB(${OSGBULLET}/${OS}/Release/obj/local/armeabi-v7a/libosgbDynamics.a)
ENDIF(osgbDynamics)
	
IF(osgbInteraction)
	dk_define(OSGBINTERACTION_LIBRARY)
	WIN_DEBUG_DKLIB(${OSGBULLET}/${OS}/lib/Debug/osgbInteractiond.lib)
	WIN_RELEASE_DKLIB(${OSGBULLET}/${OS}/lib/Release/osgbInteraction.lib)
	APPLE_DEBUG_DKLIB(${OSGBULLET}/${OS}/lib/${DEBUG}/libosgbInteraction.a)
	APPLE_RELEASE_DKLIB(${OSGBULLET}/${OS}/lib/${RELEASE}/libosgbInteraction.a)
	LINUX_DEBUG_DKLIB(${OSGBULLET}/${OS}/Debug/lib/libosgbInteraction.a)
	LINUX_RELEASE_DKLIB(${OSGBULLET}/${OS}/Release/lib/libosgbInteraction.a)
	ANDROID_DEBUG_DKLIB(${OSGBULLET}/${OS}/Debug/obj/local/armeabi-v7a/libosgbInteraction.a)
	ANDROID_RELEASE_DKLIB(${OSGBULLET}/${OS}/Release/obj/local/armeabi-v7a/libosgbInteraction.a)
ENDIF(osgbInteraction)
	
IF(osgdb_osgbdynamics)
	WIN_DEBUG_DKLIB(${OSGBULLET}/${OS}/lib/Debug/osgdb_osgbdynamicsd.lib)
	WIN_RELEASE_DKLIB(${OSGBULLET}/${OS}/lib/Release/osgdb_osgbdynamics.lib)
	APPLE_DEBUG_DKLIB(${OSGBULLET}/${OS}/lib/${DEBUG}/osgdb_osgbdynamics.a)
	APPLE_RELEASE_DKLIB(${OSGBULLET}/${OS}/lib/${RELEASE}/osgdb_osgbdynamics.a)
	LINUX_DEBUG_DKLIB(${OSGBULLET}/${OS}/Debug/lib/osgdb_osgbdynamics.a)
	LINUX_RELEASE_DKLIB(${OSGBULLET}/${OS}/Release/lib/osgdb_osgbdynamics.a)
	ANDROID_DEBUG_DKLIB(${OSGBULLET}/${OS}/Debug/obj/local/armeabi-v7a/libosgdb_osgbdynamics.a)
	ANDROID_RELEASE_DKLIB(${OSGBULLET}/${OS}/Release/obj/local/armeabi-v7a/libosgdb_osgbdynamics.a)
ENDIF(osgdb_osgbdynamics)
	
IF(osgdb_sgb)
	WIN_DEBUG_DKLIB(${OSGBULLET}/${OS}/lib/Debug/osgdb_sgbd.lib)
	WIN_RELEASE_DKLIB(${OSGBULLET}/${OS}/lib/Release/osgdb_sgb.lib)
	APPLE_DEBUG_DKLIB(${OSGBULLET}/${OS}/lib/${DEBUG}/osgdb_sgb.a)
	APPLE_RELEASE_DKLIB(${OSGBULLET}/${OS}/lib/${RELEASE}/osgdb_sgb.a)
	LINUX_DEBUG_DKLIB(${OSGBULLET}/${OS}/Debug/lib/osgdb_sgb.a)
	LINUX_RELEASE_DKLIB(${OSGBULLET}/${OS}/Release/lib/osgdb_sgb.a)
	ANDROID_DEBUG_DKLIB(${OSGBULLET}/${OS}/Debug/obj/local/armeabi-v7a/libosgdb_sgb.a)
	ANDROID_RELEASE_DKLIB(${OSGBULLET}/${OS}/Release/obj/local/armeabi-v7a/libosgdb_sgb.a)
ENDIF(osgdb_sgb)


### COMPILE ###
dk_setPath(${OSGBULLET}/${BUILD_DIR})

WIN_DKQCOMMAND(${DKCMAKE_BUILD} "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/${OS} -DOSGSourceRoot=${OSG} "-DBulletInstallType=Source And Build Tree" -DBulletBuildRoot=${BULLET}/${OS} -DBulletSourceRoot=${BULLET} -DosgWorks_DIR=${OSGWORKS}/${OS}/lib -DOSGBULLET_BUILD_APPLICATIONS=OFF -DOSGBULLET_BUILD_EXAMPLES=OFF -DOSGBULLET_INSTALL_DATA=OFF ${OSGBULLET})
WIN_DEBUG_VS(osgbullet-master osgBullet.sln)
WIN_RELEASE_VS(osgbullet-master osgBullet.sln)


WIN_DKQCOMMAND(${DKCMAKE_BUILD} "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/${OS} -DOSGSourceRoot=${OSG} "-DBulletInstallType=Source And Build Tree" -DBulletBuildRoot=${BULLET}/${OS} -DBulletSourceRoot=${BULLET} -DosgWorks_DIR=${OSGWORKS}/${OS}/lib -DOSGBULLET_BUILD_APPLICATIONS=OFF -DOSGBULLET_BUILD_EXAMPLES=OFF -DOSGBULLET_INSTALL_DATA=OFF ${OSGBULLET})
WIN_DEBUG_VS(osgbullet-master osgBullet.sln)
WIN_RELEASE_VS(osgbullet-master osgBullet.sln)


MAC_DKQCOMMAND(${DKCMAKE_BUILD} "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/${OS} -DOSGSourceRoot=${OSG} "-DBulletInstallType=Source And Build Tree" -DBulletBuildRoot=${BULLET}/${OS} -DBulletSourceRoot=${BULLET} -DosgWorks_DIR=${OSGWORKS}/${OS}/lib -DOSGBULLET_BUILD_APPLICATIONS=OFF -DOSGBULLET_BUILD_EXAMPLES=OFF -DOSGBULLET_INSTALL_DATA=OF ${OSGBULLET})
MAC_DEBUG_XCODE(osgbullet-master)
MAC_RELEASE_XCODE(osgbullet-master)


IOS_DKQCOMMAND(${DKCMAKE_BUILD} "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/ios -DOSGSourceRoot=${OSG} "-DBulletInstallType=Source And Build Tree" -DBulletBuildRoot=${BULLET}/ios -DBulletSourceRoot=${BULLET} -DosgWorks_DIR=${OSGWORKS}/ios/lib -DOSGBULLET_BUILD_APPLICATIONS=OFF -DOSGBULLET_BUILD_EXAMPLES=OFF -DOSGBULLET_INSTALL_DATA=OF ${OSGBULLET})
IOS_DEBUG_XCODE(osgbullet-master)
IOS_RELEASE_XCODE(osgbullet-master)


IOSSIM_DKQCOMMAND(${DKCMAKE_BUILD} "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/ios-simulator -DOSGSourceRoot=${OSG} "-DBulletInstallType=Source And Build Tree" -DBulletBuildRoot=${BULLET}/ios-simulator -DBulletSourceRoot=${BULLET} -DosgWorks_DIR=${OSGWORKS}/ios-simulator/lib -DOSGBULLET_BUILD_APPLICATIONS=OFF -DOSGBULLET_BUILD_EXAMPLES=OFF -DOSGBULLET_INSTALL_DATA=OF ${OSGBULLET})
IOSSIM_DEBUG_XCODE(osgbullet-master)
IOSSIM_RELEASE_XCODE(osgbullet-master)


LINUX_DEBUG_DKQCOMMAND(${DKCMAKE_BUILD} "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/${OS}/Debug -DOSGSourceRoot=${OSG} "-DBulletInstallType=Source And Build Tree" -DBulletBuildRoot=${BULLET}/${OS}/Debug -DBulletSourceRoot=${BULLET} -DosgWorks_DIR=${OSGWORKS}/${OS}/Debug/lib/x86_64-linux-gnu -DOSGBULLET_BUILD_APPLICATIONS=OFF -DOSGBULLET_BUILD_EXAMPLES=OFF -DOSGBULLET_INSTALL_DATA=OFF ${OSGBULLET})
LINUX_DEBUG_DKQCOMMAND(make)
LINUX_RELEASE_DKQCOMMAND(${DKCMAKE_BUILD} "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/${OS}/Release -DOSGSourceRoot=${OSG} "-DBulletInstallType=Source And Build Tree" -DBulletBuildRoot=${BULLET}/${OS}/Release -DBulletSourceRoot=${BULLET} -DosgWorks_DIR=${OSGWORKS}/${OS}/Release/lib/x86_64-linux-gnu -DOSGBULLET_BUILD_APPLICATIONS=OFF -DOSGBULLET_BUILD_EXAMPLES=OFF -DOSGBULLET_INSTALL_DATA=OFF ${OSGBULLET})
LINUX_RELEASE_DKQCOMMAND(make)



ANDROID_DKQCOMMAND(${DKCMAKE_BUILD} "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/${OS} -DOSGSourceRoot=${OSG} "-DBulletInstallType=Source And Build Tree" -DBulletBuildRoot=${BULLET}/${OS} -DBulletSourceRoot=${BULLET} -DosgWorks_DIR=${OSGWORKS}/${OS}/lib -DOSGBULLET_BUILD_APPLICATIONS=OFF -DOSGBULLET_BUILD_EXAMPLES=OFF -DOSGBULLET_INSTALL_DATA=OFF ${OSGBULLET})
ANDROID_DEBUG_VS(osgbullet-master osgBullet.sln)
ANDROID_RELEASE_VS(osgbullet-master osgBullet.sln)
