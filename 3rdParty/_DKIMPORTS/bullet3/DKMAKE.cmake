# https://code.google.com/archive/p/bullet/
# https://github.com/bulletphysics/bullet3
#
# https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/bullet/bullet-2.82-r2704.zip

### IMPORT ###
DKIMPORT(https://github.com/bulletphysics/bullet3.git)
#DKIMPORT(https://github.com/bulletphysics/bullet3/archive/refs/tags/2.82.zip)

### VERSION ###
#DKSET(BULLET3_VERSION 2.82-r2704)
#DKSET(BULLET3_NAME bullet-${BULLET3_VERSION})
#DKSET(BULLET3_DL https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/bullet/${BULLET3_NAME}.zip)
#DKSET(BULLET3 ${3RDPARTY}/${BULLET3_NAME})
#DKINSTALL(${BULLET3_DL} bullet ${BULLET3})


### DKPLUGINS LINK ###
DKINCLUDE(${BULLET3}/src)
IF(BulletCollision)
	WIN_DEBUG_DKLIB(${BULLET3}/${OS}/lib/Debug/BulletCollision_Debug.lib)
	WIN_RELEASE_DKLIB(${BULLET3}/${OS}/lib/${RELEASE_DIR}/BulletCollision.lib)
	APPLE_DEBUG_DKLIB(${BULLET3}/${OS}/src/BulletCollision/${DEBUG_DIR}/libBulletCollision.a)
	APPLE_RELEASE_DKLIB(${BULLET3}/${OS}/src/BulletCollision/${RELEASE_DIR}/libBulletCollision.a)
	LINUX_DEBUG_DKLIB(${BULLET3}/${OS}/Debug/src/BulletCollision/libBulletCollision.a)
	LINUX_RELEASE_DKLIB(${BULLET3}/${OS}/${RELEASE_DIR}/src/BulletCollision/libBulletCollision.a)
	ANDROID_DEBUG_DKLIB(${BULLET3}/${OS}/Debug/obj/local/armeabi-v7a/libBulletCollision.a)
	ANDROID_RELEASE_DKLIB(${BULLET3}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libBulletCollision.a)
ENDIF(BulletCollision)
	
IF(BulletDynamics)
	WIN_DEBUG_DKLIB(${BULLET3}/${OS}/lib/Debug/BulletDynamics_Debug.lib)
	WIN_RELEASE_DKLIB(${BULLET3}/${OS}/lib/${RELEASE_DIR}/BulletDynamics.lib)
	APPLE_DEBUG_DKLIB(${BULLET3}/${OS}/src/BulletDynamics/${DEBUG_DIR}/libBulletDynamics.a)
	APPLE_RELEASE_DKLIB(${BULLET3}/${OS}/src/BulletDynamics/${RELEASE_DIR}/libBulletDynamics.a)
	LINUX_DEBUG_DKLIB(${BULLET3}/${OS}/Debug/src/BulletDynamics/libBulletDynamics.a)
	LINUX_RELEASE_DKLIB(${BULLET3}/${OS}/${RELEASE_DIR}/src/BulletDynamics/libBulletDynamics.a)
	ANDROID_DEBUG_DKLIB(${BULLET3}/${OS}/Debug/obj/local/armeabi-v7a/libBulletDynamics.a)
	ANDROID_RELEASE_DKLIB(${BULLET3}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libBulletDynamics.a)
ENDIF(BulletDynamics)
	
IF(BulletMultiThreaded)
	WIN_DEBUG_DKLIB(${BULLET3}/${OS}/lib/Debug/BulletMultiThreaded_Debug.lib)
	WIN_RELEASE_DKLIB(${BULLET3}/${OS}/lib/${RELEASE_DIR}/BulletMultiThreaded.lib)
	APPLE_DEBUG_DKLIB(${BULLET3}/${OS}/src/BulletMultiThreaded/${DEBUG_DIR}/libBulletMultiThreaded.a)
	APPLE_RELEASE_DKLIB(${BULLET3}/${OS}/src/BulletMultiThreaded/${RELEASE_DIR}/libBulletMultiThreaded.a)
	LINUX_DEBUG_DKLIB(${BULLET3}/${OS}/Debug/src/BulletMultiThreaded/libBulletMultiThreaded.a)
	LINUX_RELEASE_DKLIB(${BULLET3}/${OS}/${RELEASE_DIR}/src/BulletMultiThreaded/libBulletMultiThreaded.a)
	ANDROID_DEBUG_DKLIB(${BULLET3}/${OS}/Debug/obj/local/armeabi-v7a/libBulletMultiThreaded.a)
	ANDROID_RELEASE_DKLIB(${BULLET3}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libBulletMultiThreaded.a)
ENDIF(BulletMultiThreaded)
	
IF(BulletSoftBody)
	WIN_DEBUG_DKLIB(${BULLET3}/${OS}/lib/Debug/BulletSoftBody_Debug.lib)
	WIN_RELEASE_DKLIB(${BULLET3}/${OS}/lib/${RELEASE_DIR}/BulletSoftBody.lib)
	APPLE_DEBUG_DKLIB(${BULLET3}/${OS}/src/BulletSoftBody/${DEBUG_DIR}/libBulletSoftBody.a)
	APPLE_RELEASE_DKLIB(${BULLET3}/${OS}/src/BulletSoftBody/${RELEASE_DIR}/libBulletSoftBody.a)
	LINUX_DEBUG_DKLIB(${BULLET3}/${OS}/Debug/src/BulletSoftBody/libBulletSoftBody.a)
	LINUX_RELEASE_DKLIB(${BULLET3}/${OS}/${RELEASE_DIR}/src/BulletSoftBody/libBulletSoftBody.a)
	ANDROID_DEBUG_DKLIB(${BULLET3}/${OS}/Debug/obj/local/armeabi-v7a/libBulletSoftBody.a)
	ANDROID_RELEASE_DKLIB(${BULLET3}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libBulletSoftBody.a)
ENDIF(BulletSoftBody)
	
IF(LinearMath)
	WIN_DEBUG_DKLIB(${BULLET3}/${OS}/lib/Debug/LinearMath_Debug.lib)
	WIN_RELEASE_DKLIB(${BULLET3}/${OS}/lib/${RELEASE_DIR}/LinearMath.lib)
	APPLE_DEBUG_DKLIB(${BULLET3}/${OS}/src/LinearMath/${DEBUG_DIR}/libLinearMath.a)
	APPLE_RELEASE_DKLIB(${BULLET3}/${OS}/src/LinearMath/${RELEASE_DIR}/libLinearMath.a)
	LINUX_DEBUG_DKLIB(${BULLET3}/${OS}/Debug/src/LinearMath/libLinearMath.a)
	LINUX_RELEASE_DKLIB(${BULLET3}/${OS}/${RELEASE_DIR}/src/LinearMath/libLinearMath.a)
	ANDROID_DEBUG_DKLIB(${BULLET3}/${OS}/Debug/obj/local/armeabi-v7a/libLinearMath.a)
	ANDROID_RELEASE_DKLIB(${BULLET3}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libLinearMath.a)
ENDIF(LinearMath)
	
IF(MiniCL)
	WIN_DEBUG_DKLIB(${BULLET3}/${OS}/lib/Debug/MiniCL_Debug.lib)
	WIN_RELEASE_DKLIB(${BULLET3}/${OS}/lib/${RELEASE_DIR}/MiniCL.lib)
	APPLE_DEBUG_DKLIB(${BULLET3}/${OS}/src/MiniCL/${DEBUG_DIR}/libMiniCL.a)
	APPLE_RELEASE_DKLIB(${BULLET3}/${OS}/src/MiniCL/${RELEASE_DIR}/libMiniCL.a)
	LINUX_DEBUG_DKLIB(${BULLET3}/${OS}/Debug/src/MiniCL/libMiniCL.a)
	LINUX_RELEASE_DKLIB(${BULLET3}/${OS}/${RELEASE_DIR}/src/MiniCL/libMiniCL.a)
	ANDROID_DEBUG_DKLIB(${BULLET3}/${OS}/Debug/obj/local/armeabi-v7a/libMiniCL.a)
	ANDROID_RELEASE_DKLIB(${BULLET3}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libMiniCL.a)
ENDIF(MiniCL)


### COMPILE ###
DKSETPATH(${BOXER}/${BUILD_DIR})

WIN_DKQCOMMAND(${DKCMAKE_BUILD} -DBUILD_DEMOS=OFF -DBUILD_EXTRAS=OFF -DUSE_GLUT=OFF ${BULLET3})
WIN_VS(${BULLET3_NAME} BULLET3_PHYSICS.sln)


MAC_DKQCOMMAND(${DKCMAKE_BUILD} -DBUILD_DEMOS=OFF -DBUILD_EXTRAS=OFF -DUSE_GLUT=OFF ${BULLET3})
MAC_XCODE(${BULLET3_NAME})


IOS64_DKQCOMMAND(${DKCMAKE_BUILD} -DBUILD_DEMOS=OFF -DBUILD_EXTRAS=OFF -DUSE_GLUT=OFF ${BULLET3})
IOS_XCODE(${BULLET3_NAME})


IOSSIM64_DKQCOMMAND(${DKCMAKE_BUILD} -DBUILD_DEMOS=OFF -DBUILD_EXTRAS=OFF -DUSE_GLUT=OFF ${BULLET3})
IOSSIM_XCODE(${BULLET3_NAME})


LINUX_DKQCOMMAND(${DKCMAKE_BUILD} -DBUILD_DEMOS=OFF -DBUILD_EXTRAS=OFF -DUSE_GLUT=OFF ${BULLET3})
LINUX_DKQCOMMAND(make)


RASPBERRY_DKQCOMMAND(${DKCMAKE_BUILD} -DBUILD_DEMOS=OFF -DBUILD_EXTRAS=OFF -DUSE_GLUT=OFF ${BULLET3})
RASPBERRY_DKQCOMMAND(make)


ANDROID_NDK(${BULLET3_NAME})
