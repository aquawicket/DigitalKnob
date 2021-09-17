### DEPENDS ###
DKDEPEND(openscenegraph)


### VERSION ###
DKSET(OSGWORKS_VERSION master)
DKSET(OSGWORKS_NAME osgworks-${OSGWORKS_VERSION})
DKSET(OSGWORKS_DL http://digitalknob.com/Download/Libs/osgworks-master.zip )
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
	WIN_DEBUG_LIB(${OSGWORKS}/${OS}/lib/Debug/osgdb_osgobjectsd.lib)
	WIN_RELEASE_LIB(${OSGWORKS}/${OS}/lib/${RELEASE}/osgdb_osgobjects.lib)
	APPLE_DEBUG_LIB(${OSGWORKS}/${OS}/lib/${DEBUG}/osgdb_osgobjects.a)
	APPLE_RELEASE_LIB(${OSGWORKS}/${OS}/lib/${RELEASE}/osgdb_osgobjects.a)
	LINUX_DEBUG_LIB(${OSGWORKS}/${OS}/Debug/lib/osgdb_osgobjects.a)
	LINUX_RELEASE_LIB(${OSGWORKS}/${OS}/Release/lib/osgdb_osgobjects.a)
	ANDROID_DEBUG_LIB(${OSGWORKS}/${OS}/Debug/obj/local/armeabi-v7a/libosgdb_osgobjects.a)
	ANDROID_RELEASE_LIB(${OSGWORKS}/${OS}/Release/obj/local/armeabi-v7a/libosgdb_osgobjects.a)
ENDIF(osgdb_osgobjects)
	
IF(osgdb_osgwTools)
	WIN_DEBUG_LIB(${OSGWORKS}/${OS}/lib/Debug/osgdb_osgwToolsd.lib)
	WIN_RELEASE_LIB(${OSGWORKS}/${OS}/lib/Release/osgdb_osgwTools.lib)
	APPLE_DEBUG_LIB(${OSGWORKS}/${OS}/lib/${DEBUG}/osgdb_osgwTools.a)
	APPLE_RELEASE_LIB(${OSGWORKS}/${OS}/lib/${RELEASE}/osgdb_osgwTools.a)
	LINUX_DEBUG_LIB(${OSGWORKS}/${OS}/Debug/lib/osgdb_osgwTools.a)
	LINUX_RELEASE_LIB(${OSGWORKS}/${OS}/Release/lib/osgdb_osgwTools.a)
	ANDROID_DEBUG_LIB(${OSGWORKS}/${OS}/Debug/obj/local/armeabi-v7a/libosgdb_osgwTools.a)
	ANDROID_RELEASE_LIB(${OSGWORKS}/${OS}/Release/obj/local/armeabi-v7a/libosgdb_osgwTools.a)
ENDIF(osgdb_osgwTools)
	
IF(osgdb_skeleton)
	WIN_DEBUG_LIB(${OSGWORKS}/${OS}/lib/Debug/osgdb_skeletond.lib)
	WIN_RELEASE_LIB(${OSGWORKS}/${OS}/lib/Release/osgdb_skeleton.lib)
	APPLE_DEBUG_LIB(${OSGWORKS}/${OS}/lib/${DEBUG}/osgdb_skeleton.a)
	APPLE_RELEASE_LIB(${OSGWORKS}/${OS}/lib/${RELEASE}/osgdb_skeleton.a)
	LINUX_DEBUG_LIB(${OSGWORKS}/${OS}/Debug/lib/osgdb_skeleton.a)
	LINUX_RELEASE_LIB(${OSGWORKS}/${OS}/Release/lib/osgdb_skeleton.a)
	ANDROID_DEBUG_LIB(${OSGWORKS}/${OS}/Debug/obj/local/armeabi-v7a/libosgdb_skeleton.a)
	ANDROID_RELEASE_LIB(${OSGWORKS}/${OS}/Release/obj/local/armeabi-v7a/libosgdb_skeleton.a)
ENDIF(osgdb_skeleton)
	
IF(osgwControls)
	WIN_DEBUG_LIB(${OSGWORKS}/${OS}/lib/Debug/osgwControlsd.lib)
	WIN_RELEASE_LIB(${OSGWORKS}/${OS}/lib/Release/osgwControls.lib)
	APPLE_DEBUG_LIB(${OSGWORKS}/${OS}/lib/${DEBUG}/libosgwControls.a)
	APPLE_RELEASE_LIB(${OSGWORKS}/${OS}/lib/${RELEASE}/libosgwControls.a)
	LINUX_DEBUG_LIB(${OSGWORKS}/${OS}/Debug/lib/libosgwControls.a)
	LINUX_RELEASE_LIB(${OSGWORKS}/${OS}/Release/lib/libosgwControls.a)
	ANDROID_DEBUG_LIB(${OSGWORKS}/${OS}/Debug/obj/local/armeabi-v7a/libosgwControls.a)
	ANDROID_RELEASE_LIB(${OSGWORKS}/${OS}/Release/obj/local/armeabi-v7a/libosgwControls.a)
ENDIF(osgwControls)
	
IF(osgwMx)
	WIN_DEBUG_LIB(${OSGWORKS}/${OS}/lib/Debug/osgwMxd.lib)
	WIN_RELEASE_LIB(${OSGWORKS}/${OS}/lib/Release/osgwMx.lib)
	APPLE_DEBUG_LIB(${OSGWORKS}/${OS}/lib/${DEBUG}/libosgwMx.a)
	APPLE_RELEASE_LIB(${OSGWORKS}/${OS}/lib/${RELEASE}/libosgwMx.a)
	LINUX_DEBUG_LIB(${OSGWORKS}/${OS}/Debug/lib/libosgwMx.a)
	LINUX_RELEASE_LIB(${OSGWORKS}/${OS}/Release/lib/libosgwMx.a)
	ANDROID_DEBUG_LIB(${OSGWORKS}/${OS}/Debug/obj/local/armeabi-v7a/libosgwMx.a)
	ANDROID_RELEASE_LIB(${OSGWORKS}/${OS}/Release/obj/local/armeabi-v7a/libosgwMx.a)
ENDIF(osgwMx)
	
IF(osgwQuery)
	WIN_DEBUG_LIB(${OSGWORKS}/${OS}/lib/Debug/osgwQueryd.lib)
	WIN_RELEASE_LIB(${OSGWORKS}/${OS}/lib/Release/osgwQuery.lib)
	APPLE_DEBUG_LIB(${OSGWORKS}/${OS}/lib/${DEBUG}/libosgwQuery.a)
	APPLE_RELEASE_LIB(${OSGWORKS}/${OS}/lib/${RELEASE}/libosgwQuery.a)
	LINUX_DEBUG_LIB(${OSGWORKS}/${OS}/Debug/lib/libosgwQuery.a)
	LINUX_RELEASE_LIB(${OSGWORKS}/${OS}/Release/lib/libosgwQuery.a)
	ANDROID_DEBUG_LIB(${OSGWORKS}/${OS}/Debug/obj/local/armeabi-v7a/libosgwQuery.a)
	ANDROID_RELEASE_LIB(${OSGWORKS}/${OS}/Release/obj/local/armeabi-v7a/libosgwQuery.a)
ENDIF(osgwQuery)
	
IF(osgwTools)
	WIN_DEBUG_LIB(${OSGWORKS}/${OS}/lib/Debug/osgwToolsd.lib)
	WIN_RELEASE_LIB(${OSGWORKS}/${OS}/lib/Release/osgwTools.lib)
	APPLE_DEBUG_LIB(${OSGWORKS}/${OS}/lib/${DEBUG}/libosgwTools.a)
	APPLE_RELEASE_LIB(${OSGWORKS}/${OS}/lib/${RELEASE}/libosgwTools.a)
	LINUX_DEBUG_LIB(${OSGWORKS}/${OS}/Debug/lib/libosgwTools.a)
	LINUX_RELEASE_LIB(${OSGWORKS}/${OS}/Release/lib/libosgwTools.a)
	ANDROID_DEBUG_LIB(${OSGWORKS}/${OS}/Debug/obj/local/armeabi-v7a/libosgwTools.a)
	ANDROID_RELEASE_LIB(${OSGWORKS}/${OS}/Release/obj/local/armeabi-v7a/libosgwTools.a)
ENDIF(osgwTools)


### COMPILE ###
WIN_PATH(${OSGWORKS}/${OS})
WIN32_COMMAND(${CMAKE_EXE} -G ${GENERATOR} "-DCMAKE_CXX_FLAGS=/DWIN32 /D_WINDOWS /W3 /nologo /GR /EHsc /DOSG_LIBRARY_STATIC" "-DCMAKE_CXX_FLAGS_DEBUG=/MTd /Od /Ob0 /Zi /RTC1 /DDEBUG /D_DEBUG" "-DCMAKE_CXX_FLAGS_RELEASE=/MT /O2 /Ob2 /DNDEBUG" "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/${OS} -DOSGSourceRoot=${OSG} -DBUILD_SHARED_LIBS=OFF -DOSGWORKS_BUILD_APPS=OFF -DOSGWORKS_INSTALL_DATA=OFF -DDIRECTINPUT_ARCH_x64=OFF -DBoost_INCLUDE_DIR=OFF ${OSGWORKS})
WIN32_VS(osgworks-master osgWorks.sln)

DKSETPATH(${OSGWORKS}/${OS})
WIN64_COMMAND(${CMAKE_EXE} -G ${X64GENERATOR} "-DCMAKE_CXX_FLAGS=/DWIN32 /D_WINDOWS /W3 /nologo /GR /EHsc /DOSG_LIBRARY_STATIC" "-DCMAKE_CXX_FLAGS_DEBUG=/MTd /Od /Ob0 /Zi /RTC1 /DDEBUG /D_DEBUG" "-DCMAKE_CXX_FLAGS_RELEASE=/MT /O2 /Ob2 /DNDEBUG" "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/${OS} -DOSGSourceRoot=${OSG} -DBUILD_SHARED_LIBS=OFF -DOSGWORKS_BUILD_APPS=OFF -DOSGWORKS_INSTALL_DATA=OFF -DDIRECTINPUT_ARCH_x64=OFF -DBoost_INCLUDE_DIR=OFF ${OSGWORKS})
WIN64_VS(osgworks-master osgWorks.sln)

DKSETPATH(${OSGWORKS}/${OS})
MAC_COMMAND(${CMAKE_EXE} -G "Xcode" -DCMAKE_OSX_ARCHITECTURES=x86_64 "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/${OS} -DOSGSourceRoot=${OSG} -DBUILD_SHARED_LIBS=OFF -DOSGWORKS_BUILD_APPS=OFF -DOSGWORKS_INSTALL_DATA=OFF -DDIRECTINPUT_ARCH_x64=OFF -DBoost_INCLUDE_DIR=OFF ${OSGWORKS})
MAC_XCODE_DEBUG(osgworks-master)


DKSETPATH(${OSGWORKS}/${OS})
IOS_COMMAND(${CMAKE_EXE} -G "Xcode" -DCMAKE_TOOLCHAIN_FILE=${DKCMAKE}/iOS.cmake -DIOS_PLATFORM=OS "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/${OS} -DOSGSourceRoot=${OSG} -DBUILD_SHARED_LIBS=OFF -DOSGWORKS_BUILD_APPS=OFF -DOSGWORKS_INSTALL_DATA=OFF -DDIRECTINPUT_ARCH_x64=OFF -DBoost_INCLUDE_DIR=OFF ${OSGWORKS})
IOS_XCODE_DEBUG(osgworks-master)


DKSETPATH(${OSGWORKS}/${OS})
IOSSIM_COMMAND(${CMAKE_EXE} -G "Xcode" -DCMAKE_TOOLCHAIN_FILE=${DKCMAKE}/iOS.cmake -DIOS_PLATFORM=SIMULATOR "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/${OS} -DOSGSourceRoot=${OSG} -DBUILD_SHARED_LIBS=OFF -DOSGWORKS_BUILD_APPS=OFF -DOSGWORKS_INSTALL_DATA=OFF -DDIRECTINPUT_ARCH_x64=OFF -DBoost_INCLUDE_DIR=OFF ${OSGWORKS})
IOSSIM_XCODE_DEBUG(osgworks-master)



DKSETPATH(${OSGWORKS}/${OS}/Debug)
LINUX_DEBUG_COMMAND(${CMAKE_EXE} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=DEBUG "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/${OS}/Debug -DOSGSourceRoot=${OSG} -DBUILD_SHARED_LIBS=OFF -DOSGWORKS_BUILD_APPS=OFF -DOSGWORKS_INSTALL_DATA=OFF -DDIRECTINPUT_ARCH_x64=OFF -DBoost_INCLUDE_DIR=OFF ${OSGWORKS})
LINUX_DEBUG_COMMAND(make)

LINUX_PATH_RELEASE(${OSGWORKS}/${OS}/Release)
LINUX_RELEASE_COMMAND(${CMAKE_EXE} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=RELEASE "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OSG}/${OS}/Release -DOSGSourceRoot=${OSG} -DBUILD_SHARED_LIBS=OFF -DOSGWORKS_BUILD_APPS=OFF -DOSGWORKS_INSTALL_DATA=OFF -DDIRECTINPUT_ARCH_x64=OFF -DBoost_INCLUDE_DIR=OFF ${OSGWORKS})
LINUX_RELEASE_COMMAND(make)


ANDROID_NDK_DEBUG(${OSGWORKS_NAME})
