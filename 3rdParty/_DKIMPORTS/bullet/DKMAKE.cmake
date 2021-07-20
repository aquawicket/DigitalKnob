## https://github.com/bulletphysics/bullet3

### VERSION ###
DKSET(BULLET_VERSION 2.82-r2704)
DKSET(BULLET_NAME bullet-${BULLET_VERSION})
DKSET(BULLET ${3RDPARTY}/${BULLET_NAME})


### INSTALL ###
## FIXME
## DKINSTALL(www.internet.com/bullet-${BULLET_VERSION}.zip bullet bullet-${BULLET_NAME})


### DKPLUGINS LINK ###
DKINCLUDE(${BULLET}/src)
IF(BulletCollision)
	WIN_DEBUG_LIB(${BULLET}/${OS}/lib/Debug/BulletCollision_Debug.lib)
	WIN_RELEASE_LIB(${BULLET}/${OS}/lib/${RELEASE_DIR}/BulletCollision.lib)
	APPLE_DEBUG_LIB(${BULLET}/${OS}/src/BulletCollision/${DEBUG_DIR}/libBulletCollision.a)
	APPLE_RELEASE_LIB(${BULLET}/${OS}/src/BulletCollision/${RELEASE_DIR}/libBulletCollision.a)
	LINUX_DEBUG_LIB(${BULLET}/${OS}/Debug/src/BulletCollision/libBulletCollision.a)
	LINUX_RELEASE_LIB(${BULLET}/${OS}/${RELEASE_DIR}/src/BulletCollision/libBulletCollision.a)
	ANDROID_DEBUG_LIB(${BULLET}/${OS}/Debug/obj/local/armeabi-v7a/libBulletCollision.a)
	ANDROID_RELEASE_LIB(${BULLET}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libBulletCollision.a)
ENDIF(BulletCollision)
	
IF(BulletDynamics)
	WIN_DEBUG_LIB(${BULLET}/${OS}/lib/Debug/BulletDynamics_Debug.lib)
	WIN_RELEASE_LIB(${BULLET}/${OS}/lib/${RELEASE_DIR}/BulletDynamics.lib)
	APPLE_DEBUG_LIB(${BULLET}/${OS}/src/BulletDynamics/${DEBUG_DIR}/libBulletDynamics.a)
	APPLE_RELEASE_LIB(${BULLET}/${OS}/src/BulletDynamics/${RELEASE_DIR}/libBulletDynamics.a)
	LINUX_DEBUG_LIB(${BULLET}/${OS}/Debug/src/BulletDynamics/libBulletDynamics.a)
	LINUX_RELEASE_LIB(${BULLET}/${OS}/${RELEASE_DIR}/src/BulletDynamics/libBulletDynamics.a)
	ANDROID_DEBUG_LIB(${BULLET}/${OS}/Debug/obj/local/armeabi-v7a/libBulletDynamics.a)
	ANDROID_RELEASE_LIB(${BULLET}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libBulletDynamics.a)
ENDIF(BulletDynamics)
	
IF(BulletMultiThreaded)
	WIN_DEBUG_LIB(${BULLET}/${OS}/lib/Debug/BulletMultiThreaded_Debug.lib)
	WIN_RELEASE_LIB(${BULLET}/${OS}/lib/${RELEASE_DIR}/BulletMultiThreaded.lib)
	APPLE_DEBUG_LIB(${BULLET}/${OS}/src/BulletMultiThreaded/${DEBUG_DIR}/libBulletMultiThreaded.a)
	APPLE_RELEASE_LIB(${BULLET}/${OS}/src/BulletMultiThreaded/${RELEASE_DIR}/libBulletMultiThreaded.a)
	#LINUX_DEBUG_LIB(${BULLET}/${OS}/Debug/src/BulletMultiThreaded/libBulletMultiThreaded.a)
	#LINUX_RELEASE_LIB(${BULLET}/${OS}/${RELEASE_DIR}/src/BulletMultiThreaded/libBulletMultiThreaded.a)
	ANDROID_DEBUG_LIB(${BULLET}/${OS}/Debug/obj/local/armeabi-v7a/libBulletMultiThreaded.a)
	ANDROID_RELEASE_LIB(${BULLET}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libBulletMultiThreaded.a)
ENDIF(BulletMultiThreaded)
	
IF(BulletSoftBody)
	WIN_DEBUG_LIB(${BULLET}/${OS}/lib/Debug/BulletSoftBody_Debug.lib)
	WIN_RELEASE_LIB(${BULLET}/${OS}/lib/${RELEASE_DIR}/BulletSoftBody.lib)
	APPLE_DEBUG_LIB(${BULLET}/${OS}/src/BulletSoftBody/${DEBUG_DIR}/libBulletSoftBody.a)
	APPLE_RELEASE_LIB(${BULLET}/${OS}/src/BulletSoftBody/${RELEASE_DIR}/libBulletSoftBody.a)
	LINUX_DEBUG_LIB(${BULLET}/${OS}/Debug/src/BulletSoftBody/libBulletSoftBody.a)
	LINUX_RELEASE_LIB(${BULLET}/${OS}/${RELEASE_DIR}/src/BulletSoftBody/libBulletSoftBody.a)
	ANDROID_DEBUG_LIB(${BULLET}/${OS}/Debug/obj/local/armeabi-v7a/libBulletSoftBody.a)
	ANDROID_RELEASE_LIB(${BULLET}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libBulletSoftBody.a)
ENDIF(BulletSoftBody)
	
IF(LinearMath)
	WIN_DEBUG_LIB(${BULLET}/${OS}/lib/Debug/LinearMath_Debug.lib)
	WIN_RELEASE_LIB(${BULLET}/${OS}/lib/${RELEASE_DIR}/LinearMath.lib)
	APPLE_DEBUG_LIB(${BULLET}/${OS}/src/LinearMath/${DEBUG_DIR}/libLinearMath.a)
	APPLE_RELEASE_LIB(${BULLET}/${OS}/src/LinearMath/${RELEASE_DIR}/libLinearMath.a)
	LINUX_DEBUG_LIB(${BULLET}/${OS}/Debug/src/LinearMath/libLinearMath.a)
	LINUX_RELEASE_LIB(${BULLET}/${OS}/${RELEASE_DIR}/src/LinearMath/libLinearMath.a)
	ANDROID_DEBUG_LIB(${BULLET}/${OS}/Debug/obj/local/armeabi-v7a/libLinearMath.a)
	ANDROID_RELEASE_LIB(${BULLET}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libLinearMath.a)
ENDIF(LinearMath)
	
IF(MiniCL)
	WIN_DEBUG_LIB(${BULLET}/${OS}/lib/Debug/MiniCL_Debug.lib)
	WIN_RELEASE_LIB(${BULLET}/${OS}/lib/${RELEASE_DIR}/MiniCL.lib)
	APPLE_DEBUG_LIB(${BULLET}/${OS}/src/MiniCL/${DEBUG_DIR}/libMiniCL.a)
	APPLE_RELEASE_LIB(${BULLET}/${OS}/src/MiniCL/${RELEASE_DIR}/libMiniCL.a)
	#LINUX_DEBUG_LIB(${BULLET}/${OS}/Debug/src/MiniCL/libMiniCL.a)
	#LINUX_RELEASE_LIB(${BULLET}/${OS}/${RELEASE_DIR}/src/MiniCL/libMiniCL.a)
	ANDROID_DEBUG_LIB(${BULLET}/${OS}/Debug/obj/local/armeabi-v7a/libMiniCL.a)
	ANDROID_RELEASE_LIB(${BULLET}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libMiniCL.a)
ENDIF(MiniCL)


### COMPILE ###
WIN_PATH(${BULLET}/${OS})
WIN32_COMMAND(${DKCMAKE_WIN32} -DBUILD_DEMOS=OFF -DBUILD_EXTRAS=OFF -DUSE_GLUT=OFF ${BULLET})
WIN64_COMMAND(${DKCMAKE_WIN64} -DBUILD_DEMOS=OFF -DBUILD_EXTRAS=OFF -DUSE_GLUT=OFF ${BULLET})
WIN_VS(${BULLET_NAME} BULLET_PHYSICS.sln)


MAC_PATH(${BULLET}/${OS})
MAC64_COMMAND(${DKCMAKE_MAC64} -DBUILD_DEMOS=OFF -DBUILD_EXTRAS=OFF -DUSE_GLUT=OFF ${BULLET})
MAC_XCODE(${BULLET_NAME})


IOS_PATH(${BULLET}/ios)
IOS64_COMMAND(${DKCMAKE_IOS64} -DBUILD_DEMOS=OFF -DBUILD_EXTRAS=OFF -DUSE_GLUT=OFF ${BULLET})
IOS_XCODE(${BULLET_NAME})


IOSSIM_PATH(${BULLET}/ios-simulator)
IOSSIM64_COMMAND(${DKCMAKE_IOSSIM64} -DBUILD_DEMOS=OFF -DBUILD_EXTRAS=OFF -DUSE_GLUT=OFF ${BULLET})
IOSSIM_XCODE(${BULLET_NAME})


LINUX_DEBUG_PATH(${BULLET}/${OS}/${DEBUG_DIR})
LINUX_DEBUG_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=DEBUG -DBUILD_DEMOS=OFF -DBUILD_EXTRAS=OFF -DUSE_GLUT=OFF ${BULLET})
LINUX_DEBUG_COMMAND(make)

LINUX_RELEASE_PATH(${BULLET}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=RELEASE -DBUILD_DEMOS=OFF -DBUILD_EXTRAS=OFF -DUSE_GLUT=OFF ${BULLET})
LINUX_RELEASE_COMMAND(make)


RASPBERRY_DEBUG_PATH(${BULLET}/${OS}/${DEBUG_DIR})
RASPBERRY_DEBUG_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=DEBUG -DBUILD_DEMOS=OFF -DBUILD_EXTRAS=OFF -DUSE_GLUT=OFF ${BULLET})
RASPBERRY_DEBUG_COMMAND(make)

RASPBERRY_RELEASE_PATH(${BULLET}/${OS}/${RELEASE_DIR})
RASPBERRY_RELEASE_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=RELEASE -DBUILD_DEMOS=OFF -DBUILD_EXTRAS=OFF -DUSE_GLUT=OFF ${BULLET})
RASPBERRY_RELEASE_COMMAND(make)


ANDROID_NDK(${BULLET_NAME})
