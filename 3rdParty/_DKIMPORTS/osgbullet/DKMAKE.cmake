# osgbullet

#dk_depend(bullet)
dk_depend(bullet3)
dk_depend(osgworks)


#dk_install(http://TODO.com/osgbullet-master.zip osgbullet-master)
#dk_set(OSGBULLET ${3RDPARTY}/osgbullet-master)
dk_import(http://TODO.com/osgbullet-master.zip)

dk_set(OSGBULLET_GL2 ${3RDPARTY}/osgbullet-master-GL2)
if(OpenGL2)
	dk_set(OSGBULLET OSGBULLET_GL2)
endif(OpenGL2)


### LINK ###
dk_include(${OSGBULLET}/include)
dk_define(OSGBULLET_STATIC)
if(osgbCollision)
	dk_define(OSGBCOLLISION_LIBRARY)	
	WIN_dk_libDebug(${OSGBULLET}/${OS}/lib/Debug/osgbCollisiond.lib)
	WIN_dk_libRelease(${OSGBULLET}/${OS}/lib/Release/osgbCollision.lib)
	APPLE_dk_libDebug(${OSGBULLET}/${OS}/lib/${DEBUG}/libosgbCollision.a)
	APPLE_dk_libRelease(${OSGBULLET}/${OS}/lib/${RELEASE}/libosgbCollision.a)
	LINUX_dk_libDebug(${OSGBULLET}/${OS}/Debug/lib/libosgbCollision.a)
	LINUX_dk_libRelease(${OSGBULLET}/${OS}/Release/lib/libosgbCollision.a)
	ANDROID_dk_libDebug(${OSGBULLET}/${OS}/Debug/obj/local/armeabi-v7a/libosgbCollision.a)
	ANDROID_dk_libRelease(${OSGBULLET}/${OS}/Release/obj/local/armeabi-v7a/libosgbCollision.a)
endif()
	
if(osgbDynamics)
	dk_define(OSGBDYNAMICS_LIBRARY)
	WIN_dk_libDebug(${OSGBULLET}/${OS}/lib/Debug/osgbDynamicsd.lib)
	WIN_dk_libRelease(${OSGBULLET}/${OS}/lib/Release/osgbDynamics.lib)
	APPLE_dk_libDebug(${OSGBULLET}/${OS}/lib/${DEBUG}/libosgbDynamics.a)
	APPLE_dk_libRelease(${OSGBULLET}/${OS}/lib/${RELEASE}/libosgbDynamics.a)
	LINUX_dk_libDebug(${OSGBULLET}/${OS}/Debug/lib/libosgbDynamics.a)
	LINUX_dk_libRelease(${OSGBULLET}/${OS}/Release/lib/libosgbDynamics.a)
	ANDROID_dk_libDebug(${OSGBULLET}/${OS}/Debug/obj/local/armeabi-v7a/libosgbDynamics.a)
	ANDROID_dk_libRelease(${OSGBULLET}/${OS}/Release/obj/local/armeabi-v7a/libosgbDynamics.a)
endif()
	
if(osgbInteraction)
	dk_define(OSGBINTERACTION_LIBRARY)
	WIN_dk_libDebug(${OSGBULLET}/${OS}/lib/Debug/osgbInteractiond.lib)
	WIN_dk_libRelease(${OSGBULLET}/${OS}/lib/Release/osgbInteraction.lib)
	APPLE_dk_libDebug(${OSGBULLET}/${OS}/lib/${DEBUG}/libosgbInteraction.a)
	APPLE_dk_libRelease(${OSGBULLET}/${OS}/lib/${RELEASE}/libosgbInteraction.a)
	LINUX_dk_libDebug(${OSGBULLET}/${OS}/Debug/lib/libosgbInteraction.a)
	LINUX_dk_libRelease(${OSGBULLET}/${OS}/Release/lib/libosgbInteraction.a)
	ANDROID_dk_libDebug(${OSGBULLET}/${OS}/Debug/obj/local/armeabi-v7a/libosgbInteraction.a)
	ANDROID_dk_libRelease(${OSGBULLET}/${OS}/Release/obj/local/armeabi-v7a/libosgbInteraction.a)
endif()
	
if(osgdb_osgbdynamics)
	WIN_dk_libDebug(${OSGBULLET}/${OS}/lib/Debug/osgdb_osgbdynamicsd.lib)
	WIN_dk_libRelease(${OSGBULLET}/${OS}/lib/Release/osgdb_osgbdynamics.lib)
	APPLE_dk_libDebug(${OSGBULLET}/${OS}/lib/${DEBUG}/osgdb_osgbdynamics.a)
	APPLE_dk_libRelease(${OSGBULLET}/${OS}/lib/${RELEASE}/osgdb_osgbdynamics.a)
	LINUX_dk_libDebug(${OSGBULLET}/${OS}/Debug/lib/osgdb_osgbdynamics.a)
	LINUX_dk_libRelease(${OSGBULLET}/${OS}/Release/lib/osgdb_osgbdynamics.a)
	ANDROID_dk_libDebug(${OSGBULLET}/${OS}/Debug/obj/local/armeabi-v7a/libosgdb_osgbdynamics.a)
	ANDROID_dk_libRelease(${OSGBULLET}/${OS}/Release/obj/local/armeabi-v7a/libosgdb_osgbdynamics.a)
endif()
	
if(osgdb_sgb)
	WIN_dk_libDebug(${OSGBULLET}/${OS}/lib/Debug/osgdb_sgbd.lib)
	WIN_dk_libRelease(${OSGBULLET}/${OS}/lib/Release/osgdb_sgb.lib)
	APPLE_dk_libDebug(${OSGBULLET}/${OS}/lib/${DEBUG}/osgdb_sgb.a)
	APPLE_dk_libRelease(${OSGBULLET}/${OS}/lib/${RELEASE}/osgdb_sgb.a)
	LINUX_dk_libDebug(${OSGBULLET}/${OS}/Debug/lib/osgdb_sgb.a)
	LINUX_dk_libRelease(${OSGBULLET}/${OS}/Release/lib/osgdb_sgb.a)
	ANDROID_dk_libDebug(${OSGBULLET}/${OS}/Debug/obj/local/armeabi-v7a/libosgdb_sgb.a)
	ANDROID_dk_libRelease(${OSGBULLET}/${OS}/Release/obj/local/armeabi-v7a/libosgdb_sgb.a)
endif()


### GENERATE ###
dk_setPath(${OSGBULLET}/${BUILD_DIR})

WIN_dk_queueCommand(${DKCMAKE_BUILD} "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/${OS} -DOSGSourceRoot=${OSG} "-DBulletInstallType=Source And Build Tree" -DBulletBuildRoot=${BULLET}/${OS} -DBulletSourceRoot=${BULLET} -DosgWorks_DIR=${OSGWORKS}/${OS}/lib -DOSGBULLET_BUILD_APPLICATIONS=OFF -DOSGBULLET_BUILD_EXAMPLES=OFF -DOSGBULLET_INSTALL_DATA=OFF ${OSGBULLET})

MAC_dk_queueCommand(${DKCMAKE_BUILD} "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/${OS} -DOSGSourceRoot=${OSG} "-DBulletInstallType=Source And Build Tree" -DBulletBuildRoot=${BULLET}/${OS} -DBulletSourceRoot=${BULLET} -DosgWorks_DIR=${OSGWORKS}/${OS}/lib -DOSGBULLET_BUILD_APPLICATIONS=OFF -DOSGBULLET_BUILD_EXAMPLES=OFF -DOSGBULLET_INSTALL_DATA=OF ${OSGBULLET})

IOS_dk_queueCommand(${DKCMAKE_BUILD} "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/ios -DOSGSourceRoot=${OSG} "-DBulletInstallType=Source And Build Tree" -DBulletBuildRoot=${BULLET}/ios -DBulletSourceRoot=${BULLET} -DosgWorks_DIR=${OSGWORKS}/ios/lib -DOSGBULLET_BUILD_APPLICATIONS=OFF -DOSGBULLET_BUILD_EXAMPLES=OFF -DOSGBULLET_INSTALL_DATA=OF ${OSGBULLET})

IOSSIM_dk_queueCommand(${DKCMAKE_BUILD} "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/ios-simulator -DOSGSourceRoot=${OSG} "-DBulletInstallType=Source And Build Tree" -DBulletBuildRoot=${BULLET}/ios-simulator -DBulletSourceRoot=${BULLET} -DosgWorks_DIR=${OSGWORKS}/ios-simulator/lib -DOSGBULLET_BUILD_APPLICATIONS=OFF -DOSGBULLET_BUILD_EXAMPLES=OFF -DOSGBULLET_INSTALL_DATA=OF ${OSGBULLET})

LINUX_DEBUG_dk_queueCommand(${DKCMAKE_BUILD} "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/${OS}/Debug -DOSGSourceRoot=${OSG} "-DBulletInstallType=Source And Build Tree" -DBulletBuildRoot=${BULLET}/${OS}/Debug -DBulletSourceRoot=${BULLET} -DosgWorks_DIR=${OSGWORKS}/${OS}/Debug/lib/x86_64-linux-gnu -DOSGBULLET_BUILD_APPLICATIONS=OFF -DOSGBULLET_BUILD_EXAMPLES=OFF -DOSGBULLET_INSTALL_DATA=OFF ${OSGBULLET})

LINUX_RELEASE_dk_queueCommand(${DKCMAKE_BUILD} "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/${OS}/Release -DOSGSourceRoot=${OSG} "-DBulletInstallType=Source And Build Tree" -DBulletBuildRoot=${BULLET}/${OS}/Release -DBulletSourceRoot=${BULLET} -DosgWorks_DIR=${OSGWORKS}/${OS}/Release/lib/x86_64-linux-gnu -DOSGBULLET_BUILD_APPLICATIONS=OFF -DOSGBULLET_BUILD_EXAMPLES=OFF -DOSGBULLET_INSTALL_DATA=OFF ${OSGBULLET})

ANDROID_dk_queueCommand(${DKCMAKE_BUILD} "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/${OS} -DOSGSourceRoot=${OSG} "-DBulletInstallType=Source And Build Tree" -DBulletBuildRoot=${BULLET}/${OS} -DBulletSourceRoot=${BULLET} -DosgWorks_DIR=${OSGWORKS}/${OS}/lib -DOSGBULLET_BUILD_APPLICATIONS=OFF -DOSGBULLET_BUILD_EXAMPLES=OFF -DOSGBULLET_INSTALL_DATA=OFF ${OSGBULLET})


### COMPILE ###
WIN_dk_visualStudioDebug(osgbullet-master osgBullet.sln)
WIN_dk_visualStudioRelease(osgbullet-master osgBullet.sln)
MAC_dk_xcodeDebug(osgbullet-master)
MAC_dk_xcodeRelease(osgbullet-master)
IOS_dk_xcodeDebug(osgbullet-master)
IOS_dk_xcodeRelease(osgbullet-master)
IOSSIM_dk_xcodeDebug(osgbullet-master)
IOSSIM_dk_xcodeRelease(osgbullet-master)
LINUX_DEBUG_dk_queueCommand(make)
LINUX_RELEASE_dk_queueCommand(make)
ANDROID_dk_visualStudioDebug(osgbullet-master osgBullet.sln)
ANDROID_dk_visualStudioRelease(osgbullet-master osgBullet.sln)
