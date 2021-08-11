DKDEPEND(bullet)
DKDEPEND(osgworks)

### INSTALL ###
DKINSTALL(http://digitalknob.com/Download/Libs/osgbullet-master.zip osgbullet-master)
DKSET(OSGBULLET ${3RDPARTY}/osgbullet-master)


### LINK ###
DKSET(OSGBULLET_GL2 ${3RDPARTY}/osgbullet-master-GL2)
IF(OpenGL2)
	DKSET(OSGBULLET OSGBULLET_GL2)
ENDIF(OpenGL2)

DKINCLUDE(${OSGBULLET}/include)
DKDEFINE(OSGBULLET_STATIC)

IF(osgbCollision)
	DKDEFINE(OSGBCOLLISION_LIBRARY)	
	WIN_DEBUG_LIB(${OSGBULLET}/${OS}/lib/Debug/osgbCollisiond.lib)
	WIN_RELEASE_LIB(${OSGBULLET}/${OS}/lib/Release/osgbCollision.lib)
	APPLE_DEBUG_LIB(${OSGBULLET}/${OS}/lib/${DEBUG}/libosgbCollision.a)
	APPLE_RELEASE_LIB(${OSGBULLET}/${OS}/lib/${RELEASE}/libosgbCollision.a)
	LINUX_DEBUG_LIB(${OSGBULLET}/${OS}/Debug/lib/libosgbCollision.a)
	LINUX_RELEASE_LIB(${OSGBULLET}/${OS}/Release/lib/libosgbCollision.a)
	ANDROID_DEBUG_LIB(${OSGBULLET}/${OS}/Debug/obj/local/armeabi-v7a/libosgbCollision.a)
	ANDROID_RELEASE_LIB(${OSGBULLET}/${OS}/Release/obj/local/armeabi-v7a/libosgbCollision.a)
ENDIF(osgbCollision)
	
IF(osgbDynamics)
	DKDEFINE(OSGBDYNAMICS_LIBRARY)
	WIN_DEBUG_LIB(${OSGBULLET}/${OS}/lib/Debug/osgbDynamicsd.lib)
	WIN_RELEASE_LIB(${OSGBULLET}/${OS}/lib/Release/osgbDynamics.lib)
	APPLE_DEBUG_LIB(${OSGBULLET}/${OS}/lib/${DEBUG}/libosgbDynamics.a)
	APPLE_RELEASE_LIB(${OSGBULLET}/${OS}/lib/${RELEASE}/libosgbDynamics.a)
	LINUX_DEBUG_LIB(${OSGBULLET}/${OS}/Debug/lib/libosgbDynamics.a)
	LINUX_RELEASE_LIB(${OSGBULLET}/${OS}/Release/lib/libosgbDynamics.a)
	ANDROID_DEBUG_LIB(${OSGBULLET}/${OS}/Debug/obj/local/armeabi-v7a/libosgbDynamics.a)
	ANDROID_RELEASE_LIB(${OSGBULLET}/${OS}/Release/obj/local/armeabi-v7a/libosgbDynamics.a)
ENDIF(osgbDynamics)
	
IF(osgbInteraction)
	DKDEFINE(OSGBINTERACTION_LIBRARY)
	WIN_DEBUG_LIB(${OSGBULLET}/${OS}/lib/Debug/osgbInteractiond.lib)
	WIN_RELEASE_LIB(${OSGBULLET}/${OS}/lib/Release/osgbInteraction.lib)
	APPLE_DEBUG_LIB(${OSGBULLET}/${OS}/lib/${DEBUG}/libosgbInteraction.a)
	APPLE_RELEASE_LIB(${OSGBULLET}/${OS}/lib/${RELEASE}/libosgbInteraction.a)
	LINUX_DEBUG_LIB(${OSGBULLET}/${OS}/Debug/lib/libosgbInteraction.a)
	LINUX_RELEASE_LIB(${OSGBULLET}/${OS}/Release/lib/libosgbInteraction.a)
	ANDROID_DEBUG_LIB(${OSGBULLET}/${OS}/Debug/obj/local/armeabi-v7a/libosgbInteraction.a)
	ANDROID_RELEASE_LIB(${OSGBULLET}/${OS}/Release/obj/local/armeabi-v7a/libosgbInteraction.a)
ENDIF(osgbInteraction)
	
IF(osgdb_osgbdynamics)
	WIN_DEBUG_LIB(${OSGBULLET}/${OS}/lib/Debug/osgdb_osgbdynamicsd.lib)
	WIN_RELEASE_LIB(${OSGBULLET}/${OS}/lib/Release/osgdb_osgbdynamics.lib)
	APPLE_DEBUG_LIB(${OSGBULLET}/${OS}/lib/${DEBUG}/osgdb_osgbdynamics.a)
	APPLE_RELEASE_LIB(${OSGBULLET}/${OS}/lib/${RELEASE}/osgdb_osgbdynamics.a)
	LINUX_DEBUG_LIB(${OSGBULLET}/${OS}/Debug/lib/osgdb_osgbdynamics.a)
	LINUX_RELEASE_LIB(${OSGBULLET}/${OS}/Release/lib/osgdb_osgbdynamics.a)
	ANDROID_DEBUG_LIB(${OSGBULLET}/${OS}/Debug/obj/local/armeabi-v7a/libosgdb_osgbdynamics.a)
	ANDROID_RELEASE_LIB(${OSGBULLET}/${OS}/Release/obj/local/armeabi-v7a/libosgdb_osgbdynamics.a)
ENDIF(osgdb_osgbdynamics)
	
IF(osgdb_sgb)
	WIN_DEBUG_LIB(${OSGBULLET}/${OS}/lib/Debug/osgdb_sgbd.lib)
	WIN_RELEASE_LIB(${OSGBULLET}/${OS}/lib/Release/osgdb_sgb.lib)
	APPLE_DEBUG_LIB(${OSGBULLET}/${OS}/lib/${DEBUG}/osgdb_sgb.a)
	APPLE_RELEASE_LIB(${OSGBULLET}/${OS}/lib/${RELEASE}/osgdb_sgb.a)
	LINUX_DEBUG_LIB(${OSGBULLET}/${OS}/Debug/lib/osgdb_sgb.a)
	LINUX_RELEASE_LIB(${OSGBULLET}/${OS}/Release/lib/osgdb_sgb.a)
	ANDROID_DEBUG_LIB(${OSGBULLET}/${OS}/Debug/obj/local/armeabi-v7a/libosgdb_sgb.a)
	ANDROID_RELEASE_LIB(${OSGBULLET}/${OS}/Release/obj/local/armeabi-v7a/libosgdb_sgb.a)
ENDIF(osgdb_sgb)


### COMPILE ###
DKSETPATH(${OSGBULLET}/${OS})
WIN32_COMMAND(${CMAKE_EXE} -G ${GENERATOR} "-DCMAKE_CXX_FLAGS=/DWIN32 /D_WINDOWS /W3 /nologo /GR /EHsc /DOSG_LIBRARY_STATIC /DOSGWORKS_STATIC" "-DCMAKE_CXX_FLAGS_DEBUG=/MTd /Od /Ob0 /Zi /RTC1 /DDEBUG /D_DEBUG" "-DCMAKE_CXX_FLAGS_RELEASE=/MT /O2 /Ob2 /DNDEBUG" "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/${OS} -DOSGSourceRoot=${OSG} "-DBulletInstallType=Source And Build Tree" -DBulletBuildRoot=${BULLET}/${OS} -DBulletSourceRoot=${BULLET} -DosgWorks_DIR=${OSGWORKS}/${OS}/lib -DBUILD_SHARED_LIBS=OFF -DOSGBULLET_BUILD_APPLICATIONS=OFF -DOSGBULLET_BUILD_EXAMPLES=OFF -DOSGBULLET_INSTALL_DATA=OFF ${OSGBULLET})
WIN32_VS_DEBUG(osgbullet-master osgBullet.sln)
WIN32_VS_RELEASE(osgbullet-master osgBullet.sln)

DKSETPATH(${OSGBULLET}/${OS})
WIN64_COMMAND(${CMAKE_EXE} -G ${X64GENERATOR} "-DCMAKE_CXX_FLAGS=/DWIN32 /D_WINDOWS /W3 /nologo /GR /EHsc /DOSG_LIBRARY_STATIC /DOSGWORKS_STATIC" "-DCMAKE_CXX_FLAGS_DEBUG=/MTd /Od /Ob0 /Zi /RTC1 /DDEBUG /D_DEBUG" "-DCMAKE_CXX_FLAGS_RELEASE=/MT /O2 /Ob2 /DNDEBUG" "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/${OS} -DOSGSourceRoot=${OSG} "-DBulletInstallType=Source And Build Tree" -DBulletBuildRoot=${BULLET}/${OS} -DBulletSourceRoot=${BULLET} -DosgWorks_DIR=${OSGWORKS}/${OS}/lib -DBUILD_SHARED_LIBS=OFF -DOSGBULLET_BUILD_APPLICATIONS=OFF -DOSGBULLET_BUILD_EXAMPLES=OFF -DOSGBULLET_INSTALL_DATA=OFF ${OSGBULLET})
WIN64_VS_DEBUG(osgbullet-master osgBullet.sln)
WIN64_VS_RELEASE(osgbullet-master osgBullet.sln)

DKSETPATH(${OSGBULLET}/${OS})
MAC_COMMAND(${CMAKE_EXE} -G "Xcode" -DCMAKE_OSX_ARCHITECTURES=x86_64 "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/${OS} -DOSGSourceRoot=${OSG} "-DBulletInstallType=Source And Build Tree" -DBulletBuildRoot=${BULLET}/${OS} -DBulletSourceRoot=${BULLET} -DosgWorks_DIR=${OSGWORKS}/${OS}/lib -DBUILD_SHARED_LIBS=OFF -DOSGBULLET_BUILD_APPLICATIONS=OFF -DOSGBULLET_BUILD_EXAMPLES=OFF -DOSGBULLET_INSTALL_DATA=OF ${OSGBULLET})
MAC_XCODE_DEBUG(osgbullet-master)
MAC_XCODE_RELEASE(osgbullet-master)

DKSETPATH(${OSGBULLET}/ios)
IOS_COMMAND(${CMAKE_EXE} -G "Xcode" -DCMAKE_TOOLCHAIN_FILE=${DKCMAKE}/iOS.cmake -DIOS_PLATFORM=OS "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/ios -DOSGSourceRoot=${OSG} "-DBulletInstallType=Source And Build Tree" -DBulletBuildRoot=${BULLET}/ios -DBulletSourceRoot=${BULLET} -DosgWorks_DIR=${OSGWORKS}/ios/lib -DBUILD_SHARED_LIBS=OFF -DOSGBULLET_BUILD_APPLICATIONS=OFF -DOSGBULLET_BUILD_EXAMPLES=OFF -DOSGBULLET_INSTALL_DATA=OF ${OSGBULLET})
IOS_XCODE_DEBUG(osgbullet-master)
IOS_XCODE_RELEASE(osgbullet-master)

DKSETPATH(${OSGBULLET}/ios-simulator)
IOSSIM_COMMAND(${CMAKE_EXE} -G "Xcode" -DCMAKE_TOOLCHAIN_FILE=${DKCMAKE}/iOS.cmake -DIOS_PLATFORM=SIMULATOR "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/ios-simulator -DOSGSourceRoot=${OSG} "-DBulletInstallType=Source And Build Tree" -DBulletBuildRoot=${BULLET}/ios-simulator -DBulletSourceRoot=${BULLET} -DosgWorks_DIR=${OSGWORKS}/ios-simulator/lib -DBUILD_SHARED_LIBS=OFF -DOSGBULLET_BUILD_APPLICATIONS=OFF -DOSGBULLET_BUILD_EXAMPLES=OFF -DOSGBULLET_INSTALL_DATA=OF ${OSGBULLET})
IOSSIM_XCODE_DEBUG(osgbullet-master)
IOSSIM_XCODE_RELEASE(osgbullet-master)


DKSETPATH(${OSGBULLET}/${OS}/Debug)
LINUX_DEBUG_COMMAND(${CMAKE_EXE} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=DEBUG "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/${OS}/Debug -DOSGSourceRoot=${OSG} "-DBulletInstallType=Source And Build Tree" -DBulletBuildRoot=${BULLET}/${OS}/Debug -DBulletSourceRoot=${BULLET} -DosgWorks_DIR=${OSGWORKS}/${OS}/Debug/lib/x86_64-linux-gnu -DBUILD_SHARED_LIBS=OFF -DOSGBULLET_BUILD_APPLICATIONS=OFF -DOSGBULLET_BUILD_EXAMPLES=OFF -DOSGBULLET_INSTALL_DATA=OFF ${OSGBULLET})
LINUX_DEBUG_COMMAND(make)

DKSETPATH(${OSGBULLET}/${OS}/Release)
LINUX_RELEASE_COMMAND(${CMAKE_EXE} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=RELEASE "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/${OS}/Release -DOSGSourceRoot=${OSG} "-DBulletInstallType=Source And Build Tree" -DBulletBuildRoot=${BULLET}/${OS}/Release -DBulletSourceRoot=${BULLET} -DosgWorks_DIR=${OSGWORKS}/${OS}/Release/lib/x86_64-linux-gnu -DBUILD_SHARED_LIBS=OFF -DOSGBULLET_BUILD_APPLICATIONS=OFF -DOSGBULLET_BUILD_EXAMPLES=OFF -DOSGBULLET_INSTALL_DATA=OFF ${OSGBULLET})
LINUX_RELEASE_COMMAND(make)


ANDROID_NDK_DEBUG(osgbullet-master)
ANDROID_NDK_RELEASE(osgbullet-master)
