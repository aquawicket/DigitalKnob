# https://github.com/mccdo/osgworks


### DEPEND ###
dk_depend(openscenegraph)


### IMPORT ###
dk_import(https://github.com/mccdo/osgworks.git)


### LINK ###
dk_define(OSGWORKS_STATIC)
dk_include(${OSGWORKS}/include)

IF(osgdb_osgobjects)
	WIN_dk_libDebug(${OSGWORKS}/${OS}/lib/${DEBUG_DIR}/osgdb_osgobjectsd.lib)
	WIN_dk_libRelease(${OSGWORKS}/${OS}/lib/${RELEASE_DIR}/osgdb_osgobjects.lib)
	APPLE_dk_libDebug(${OSGWORKS}/${OS}/lib/${DEBUG_DIR}/osgdb_osgobjects.a)
	APPLE_dk_libRelease(${OSGWORKS}/${OS}/lib/${RELEASE_DIR}/osgdb_osgobjects.a)
	LINUX_dk_libDebug(${OSGWORKS}/${OS}/${DEBUG_DIR}/lib/osgdb_osgobjects.a)
	LINUX_dk_libRelease(${OSGWORKS}/${OS}/${RELEASE_DIR}/lib/osgdb_osgobjects.a)
	RASPBERRY_dk_libDebug(${OSGWORKS}/${OS}/${DEBUG_DIR}/lib/osgdb_osgobjects.a)
	RASPBERRY_dk_libRelease(${OSGWORKS}/${OS}/${RELEASE_DIR}/lib/osgdb_osgobjects.a)
	ANDROID_dk_libDebug(${OSGWORKS}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libosgdb_osgobjects.a)
	ANDROID_dk_libRelease(${OSGWORKS}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libosgdb_osgobjects.a)
ENDIF()
IF(osgdb_osgwTools)
	WIN_dk_libDebug(${OSGWORKS}/${OS}/lib/${DEBUG_DIR}/osgdb_osgwToolsd.lib)
	WIN_dk_libRelease(${OSGWORKS}/${OS}/lib/${RELEASE_DIR}/osgdb_osgwTools.lib)
	APPLE_dk_libDebug(${OSGWORKS}/${OS}/lib/${DEBUG_DIR}/osgdb_osgwTools.a)
	APPLE_dk_libRelease(${OSGWORKS}/${OS}/lib/${RELEASE_DIR}/osgdb_osgwTools.a)
	LINUX_dk_libDebug(${OSGWORKS}/${OS}/${DEBUG_DIR}/lib/osgdb_osgwTools.a)
	LINUX_dk_libRelease(${OSGWORKS}/${OS}/${RELEASE_DIR}/lib/osgdb_osgwTools.a)
	RASPBERRY_dk_libDebug(${OSGWORKS}/${OS}/${DEBUG_DIR}/lib/osgdb_osgwTools.a)
	RASPBERRY_dk_libRelease(${OSGWORKS}/${OS}/${RELEASE_DIR}/lib/osgdb_osgwTools.a)
	ANDROID_dk_libDebug(${OSGWORKS}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libosgdb_osgwTools.a)
	ANDROID_dk_libRelease(${OSGWORKS}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libosgdb_osgwTools.a)
ENDIF()
IF(osgdb_skeleton)
	WIN_dk_libDebug(${OSGWORKS}/${OS}/lib/${DEBUG_DIR}/osgdb_skeletond.lib)
	WIN_dk_libRelease(${OSGWORKS}/${OS}/lib/${RELEASE_DIR}/osgdb_skeleton.lib)
	APPLE_dk_libDebug(${OSGWORKS}/${OS}/lib/${DEBUG_DIR}/osgdb_skeleton.a)
	APPLE_dk_libRelease(${OSGWORKS}/${OS}/lib/${RELEASE_DIR}/osgdb_skeleton.a)
	LINUX_dk_libDebug(${OSGWORKS}/${OS}/${DEBUG_DIR}/lib/osgdb_skeleton.a)
	LINUX_dk_libRelease(${OSGWORKS}/${OS}/${RELEASE_DIR}/lib/osgdb_skeleton.a)
	RASPBERRY_dk_libDebug(${OSGWORKS}/${OS}/${DEBUG_DIR}/lib/osgdb_skeleton.a)
	RASPBERRY_dk_libRelease(${OSGWORKS}/${OS}/${RELEASE_DIR}/lib/osgdb_skeleton.a)
	ANDROID_dk_libDebug(${OSGWORKS}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libosgdb_skeleton.a)
	ANDROID_dk_libRelease(${OSGWORKS}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libosgdb_skeleton.a)
ENDIF()
IF(osgwControls)
	WIN_dk_libDebug(${OSGWORKS}/${OS}/lib/${DEBUG_DIR}/osgwControlsd.lib)
	WIN_dk_libRelease(${OSGWORKS}/${OS}/lib/${RELEASE_DIR}/osgwControls.lib)
	APPLE_dk_libDebug(${OSGWORKS}/${OS}/lib/${DEBUG_DIR}/libosgwControls.a)
	APPLE_dk_libRelease(${OSGWORKS}/${OS}/lib/${RELEASE_DIR}/libosgwControls.a)
	LINUX_dk_libDebug(${OSGWORKS}/${OS}/${DEBUG_DIR}/lib/libosgwControls.a)
	LINUX_dk_libRelease(${OSGWORKS}/${OS}/${RELEASE_DIR}/lib/libosgwControls.a)
	RASPBERRY_dk_libDebug(${OSGWORKS}/${OS}/${DEBUG_DIR}/lib/libosgwControls.a)
	RASPBERRY_dk_libRelease(${OSGWORKS}/${OS}/${RELEASE_DIR}/lib/libosgwControls.a)
	ANDROID_dk_libDebug(${OSGWORKS}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libosgwControls.a)
	ANDROID_dk_libRelease(${OSGWORKS}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libosgwControls.a)
ENDIF()
IF(osgwMx)
	WIN_dk_libDebug(${OSGWORKS}/${OS}/lib/${DEBUG_DIR}/osgwMxd.lib)
	WIN_dk_libRelease(${OSGWORKS}/${OS}/lib/${RELEASE_DIR}/osgwMx.lib)
	APPLE_dk_libDebug(${OSGWORKS}/${OS}/lib/${DEBUG_DIR}/libosgwMx.a)
	APPLE_dk_libRelease(${OSGWORKS}/${OS}/lib/${RELEASE_DIR}/libosgwMx.a)
	LINUX_dk_libDebug(${OSGWORKS}/${OS}/${DEBUG_DIR}/lib/libosgwMx.a)
	LINUX_dk_libRelease(${OSGWORKS}/${OS}/${RELEASE_DIR}/lib/libosgwMx.a)
	RASPBERRY_dk_libDebug(${OSGWORKS}/${OS}/${DEBUG_DIR}/lib/libosgwMx.a)
	RASPBERRY_dk_libRelease(${OSGWORKS}/${OS}/${RELEASE_DIR}/lib/libosgwMx.a)
	ANDROID_dk_libDebug(${OSGWORKS}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libosgwMx.a)
	ANDROID_dk_libRelease(${OSGWORKS}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libosgwMx.a)
ENDIF()
IF(osgwQuery)
	WIN_dk_libDebug(${OSGWORKS}/${OS}/lib/${DEBUG_DIR}/osgwQueryd.lib)
	WIN_dk_libRelease(${OSGWORKS}/${OS}/lib/${RELEASE_DIR}/osgwQuery.lib)
	APPLE_dk_libDebug(${OSGWORKS}/${OS}/lib/${DEBUG_DIR}/libosgwQuery.a)
	APPLE_dk_libRelease(${OSGWORKS}/${OS}/lib/${RELEASE_DIR}/libosgwQuery.a)
	LINUX_dk_libDebug(${OSGWORKS}/${OS}/${DEBUG_DIR}/lib/libosgwQuery.a)
	LINUX_dk_libRelease(${OSGWORKS}/${OS}/${RELEASE_DIR}/lib/libosgwQuery.a)
	RASPBERRY_dk_libDebug(${OSGWORKS}/${OS}/${DEBUG_DIR}/lib/libosgwQuery.a)
	RASPBERRY_dk_libRelease(${OSGWORKS}/${OS}/${RELEASE_DIR}/lib/libosgwQuery.a)
	ANDROID_dk_libDebug(${OSGWORKS}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libosgwQuery.a)
	ANDROID_dk_libRelease(${OSGWORKS}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libosgwQuery.a)
ENDIF()
IF(osgwTools)
	WIN_dk_libDebug(${OSGWORKS}/${OS}/lib/${DEBUG_DIR}/osgwToolsd.lib)
	WIN_dk_libRelease(${OSGWORKS}/${OS}/lib/${RELEASE_DIR}/osgwTools.lib)
	APPLE_dk_libDebug(${OSGWORKS}/${OS}/lib/${DEBUG_DIR}/libosgwTools.a)
	APPLE_dk_libRelease(${OSGWORKS}/${OS}/lib/${RELEASE_DIR}/libosgwTools.a)
	LINUX_dk_libDebug(${OSGWORKS}/${OS}/${DEBUG_DIR}/lib/libosgwTools.a)
	LINUX_dk_libRelease(${OSGWORKS}/${OS}/${RELEASE_DIR}/lib/libosgwTools.a)
	RASPBERRY_dk_libDebug(${OSGWORKS}/${OS}/${DEBUG_DIR}/lib/libosgwTools.a)
	RASPBERRY_dk_libRelease(${OSGWORKS}/${OS}/${RELEASE_DIR}/lib/libosgwTools.a)
	ANDROID_dk_libDebug(${OSGWORKS}/${OS}/${DEBUG_DIR}/obj/local/armeabi-v7a/libosgwTools.a)
	ANDROID_dk_libRelease(${OSGWORKS}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libosgwTools.a)
ENDIF()


### generate ###
dk_setPath(${OSGWORKS}/${BUILD_DIR})

WIN_dk_queueCommand(${DKCMAKE_BUILD} "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OPENSCENEGRAPH}/${OS} -DOSGSourceRoot=${OPENSCENEGRAPH} -DOSGWORKS_BUILD_APPS=OFF -DOSGWORKS_INSTALL_DATA=OFF -DDIRECTINPUT_ARCH_x64=OFF -DBoost_INCLUDE_DIR=OFF ${OSGWORKS})

#MAC_dk_queueCommand(${DKCMAKE_BUILD} "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OPENSCENEGRAPH}/${OS} -DOSGSourceRoot=${OPENSCENEGRAPH} -DOSGWORKS_BUILD_APPS=OFF -DOSGWORKS_INSTALL_DATA=OFF -DDIRECTINPUT_ARCH_x64=OFF -DBoost_INCLUDE_DIR=OFF ${OSGWORKS})
#IOS_dk_queueCommand(${DKCMAKE_BUILD} "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OPENSCENEGRAPH}/${OS} -DOSGSourceRoot=${OPENSCENEGRAPH} -DOSGWORKS_BUILD_APPS=OFF -DOSGWORKS_INSTALL_DATA=OFF -DDIRECTINPUT_ARCH_x64=OFF -DBoost_INCLUDE_DIR=OFF ${OSGWORKS})
#IOSSIM_dk_queueCommand(${DKCMAKE_BUILD} "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OPENSCENEGRAPH}/${OS} -DOSGSourceRoot=${OPENSCENEGRAPH} -DOSGWORKS_BUILD_APPS=OFF -DOSGWORKS_INSTALL_DATA=OFF -DDIRECTINPUT_ARCH_x64=OFF -DBoost_INCLUDE_DIR=OFF ${OSGWORKS})

APPLE_dk_queueCommand(${DKCMAKE_BUILD} "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OPENSCENEGRAPH}/${OS} -DOSGSourceRoot=${OPENSCENEGRAPH} -DOSGWORKS_BUILD_APPS=OFF -DOSGWORKS_INSTALL_DATA=OFF -DDIRECTINPUT_ARCH_x64=OFF -DBoost_INCLUDE_DIR=OFF ${OSGWORKS})

LINUX_DEBUG_dk_queueCommand(${DKCMAKE_BUILD} "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OPENSCENEGRAPH}/${OS}/${DEBUG_DIR} -DOSGSourceRoot=${OPENSCENEGRAPH} -DOSGWORKS_BUILD_APPS=OFF -DOSGWORKS_INSTALL_DATA=OFF -DDIRECTINPUT_ARCH_x64=OFF -DBoost_INCLUDE_DIR=OFF ${OSGWORKS})

LINUX_RELEASE_dk_queueCommand(${DKCMAKE_BUILD} "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OPENSCENEGRAPH}/${OS}/${RELEASE_DIR} -DOSGSourceRoot=${OPENSCENEGRAPH} -DOSGWORKS_BUILD_APPS=OFF -DOSGWORKS_INSTALL_DATA=OFF -DDIRECTINPUT_ARCH_x64=OFF -DBoost_INCLUDE_DIR=OFF ${OSGWORKS})

ANDROID_dk_queueCommand(${DKCMAKE_BUILD} "-DOSGInstallType=Source And Build Tree" -DOSGBuildRoot=${OPENSCENEGRAPH}/${OS} -DOSGSourceRoot=${OPENSCENEGRAPH} -DOSGWORKS_BUILD_APPS=OFF -DOSGWORKS_INSTALL_DATA=OFF -DDIRECTINPUT_ARCH_x64=OFF -DBoost_INCLUDE_DIR=OFF ${OSGWORKS})


### COMPILE ###
dk_visualStudio	(${OSGWORKS_FOLDER}) # windows, android
dk_xcode		(${OSGWORKS_FOLDER}) # mac, ios, iossim
dk_make			(${OSGWORKS_FOLDER}) # linux, raspberrry
