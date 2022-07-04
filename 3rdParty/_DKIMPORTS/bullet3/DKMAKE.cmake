# https://github.com/bulletphysics/bullet3
# https://code.google.com/archive/p/bullet
# https://github.com/bulletphysics/bullet3/archive/refs/tags/2.82.zip
# https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/bullet/bullet-2.82-r2704.zip


#dk_import(https://github.com/bulletphysics/bullet3/archive/refs/tags/2.82.zip)
dk_import(https://github.com/bulletphysics/bullet3.git)


### LINK ###
dk_include(${BULLET3}/src)
IF(BulletCollision)
	WIN_dk_libDebug(${BULLET3}/${OS}/lib/Debug/BulletCollision_Debug.lib)
	WIN_dk_libRelease(${BULLET3}/${OS}/lib/${RELEASE_DIR}/BulletCollision.lib)
	APPLE_dk_libDebug(${BULLET3}/${OS}/src/BulletCollision/${DEBUG_DIR}/libBulletCollision.a)
	APPLE_dk_libRelease(${BULLET3}/${OS}/src/BulletCollision/${RELEASE_DIR}/libBulletCollision.a)
	LINUX_dk_libDebug(${BULLET3}/${OS}/Debug/src/BulletCollision/libBulletCollision.a)
	LINUX_dk_libRelease(${BULLET3}/${OS}/${RELEASE_DIR}/src/BulletCollision/libBulletCollision.a)
	ANDROID_dk_libDebug(${BULLET3}/${OS}/Debug/obj/local/armeabi-v7a/libBulletCollision.a)
	ANDROID_dk_libRelease(${BULLET3}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libBulletCollision.a)
ENDIF(BulletCollision)
	
IF(BulletDynamics)
	WIN_dk_libDebug(${BULLET3}/${OS}/lib/Debug/BulletDynamics_Debug.lib)
	WIN_dk_libRelease(${BULLET3}/${OS}/lib/${RELEASE_DIR}/BulletDynamics.lib)
	APPLE_dk_libDebug(${BULLET3}/${OS}/src/BulletDynamics/${DEBUG_DIR}/libBulletDynamics.a)
	APPLE_dk_libRelease(${BULLET3}/${OS}/src/BulletDynamics/${RELEASE_DIR}/libBulletDynamics.a)
	LINUX_dk_libDebug(${BULLET3}/${OS}/Debug/src/BulletDynamics/libBulletDynamics.a)
	LINUX_dk_libRelease(${BULLET3}/${OS}/${RELEASE_DIR}/src/BulletDynamics/libBulletDynamics.a)
	ANDROID_dk_libDebug(${BULLET3}/${OS}/Debug/obj/local/armeabi-v7a/libBulletDynamics.a)
	ANDROID_dk_libRelease(${BULLET3}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libBulletDynamics.a)
ENDIF(BulletDynamics)
	
IF(BulletMultiThreaded)
	WIN_dk_libDebug(${BULLET3}/${OS}/lib/Debug/BulletMultiThreaded_Debug.lib)
	WIN_dk_libRelease(${BULLET3}/${OS}/lib/${RELEASE_DIR}/BulletMultiThreaded.lib)
	APPLE_dk_libDebug(${BULLET3}/${OS}/src/BulletMultiThreaded/${DEBUG_DIR}/libBulletMultiThreaded.a)
	APPLE_dk_libRelease(${BULLET3}/${OS}/src/BulletMultiThreaded/${RELEASE_DIR}/libBulletMultiThreaded.a)
	LINUX_dk_libDebug(${BULLET3}/${OS}/Debug/src/BulletMultiThreaded/libBulletMultiThreaded.a)
	LINUX_dk_libRelease(${BULLET3}/${OS}/${RELEASE_DIR}/src/BulletMultiThreaded/libBulletMultiThreaded.a)
	ANDROID_dk_libDebug(${BULLET3}/${OS}/Debug/obj/local/armeabi-v7a/libBulletMultiThreaded.a)
	ANDROID_dk_libRelease(${BULLET3}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libBulletMultiThreaded.a)
ENDIF(BulletMultiThreaded)
	
IF(BulletSoftBody)
	WIN_dk_libDebug(${BULLET3}/${OS}/lib/Debug/BulletSoftBody_Debug.lib)
	WIN_dk_libRelease(${BULLET3}/${OS}/lib/${RELEASE_DIR}/BulletSoftBody.lib)
	APPLE_dk_libDebug(${BULLET3}/${OS}/src/BulletSoftBody/${DEBUG_DIR}/libBulletSoftBody.a)
	APPLE_dk_libRelease(${BULLET3}/${OS}/src/BulletSoftBody/${RELEASE_DIR}/libBulletSoftBody.a)
	LINUX_dk_libDebug(${BULLET3}/${OS}/Debug/src/BulletSoftBody/libBulletSoftBody.a)
	LINUX_dk_libRelease(${BULLET3}/${OS}/${RELEASE_DIR}/src/BulletSoftBody/libBulletSoftBody.a)
	ANDROID_dk_libDebug(${BULLET3}/${OS}/Debug/obj/local/armeabi-v7a/libBulletSoftBody.a)
	ANDROID_dk_libRelease(${BULLET3}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libBulletSoftBody.a)
ENDIF(BulletSoftBody)
	
IF(LinearMath)
	WIN_dk_libDebug(${BULLET3}/${OS}/lib/Debug/LinearMath_Debug.lib)
	WIN_dk_libRelease(${BULLET3}/${OS}/lib/${RELEASE_DIR}/LinearMath.lib)
	APPLE_dk_libDebug(${BULLET3}/${OS}/src/LinearMath/${DEBUG_DIR}/libLinearMath.a)
	APPLE_dk_libRelease(${BULLET3}/${OS}/src/LinearMath/${RELEASE_DIR}/libLinearMath.a)
	LINUX_dk_libDebug(${BULLET3}/${OS}/Debug/src/LinearMath/libLinearMath.a)
	LINUX_dk_libRelease(${BULLET3}/${OS}/${RELEASE_DIR}/src/LinearMath/libLinearMath.a)
	ANDROID_dk_libDebug(${BULLET3}/${OS}/Debug/obj/local/armeabi-v7a/libLinearMath.a)
	ANDROID_dk_libRelease(${BULLET3}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libLinearMath.a)
ENDIF(LinearMath)
	
IF(MiniCL)
	WIN_dk_libDebug(${BULLET3}/${OS}/lib/Debug/MiniCL_Debug.lib)
	WIN_dk_libRelease(${BULLET3}/${OS}/lib/${RELEASE_DIR}/MiniCL.lib)
	APPLE_dk_libDebug(${BULLET3}/${OS}/src/MiniCL/${DEBUG_DIR}/libMiniCL.a)
	APPLE_dk_libRelease(${BULLET3}/${OS}/src/MiniCL/${RELEASE_DIR}/libMiniCL.a)
	LINUX_dk_libDebug(${BULLET3}/${OS}/Debug/src/MiniCL/libMiniCL.a)
	LINUX_dk_libRelease(${BULLET3}/${OS}/${RELEASE_DIR}/src/MiniCL/libMiniCL.a)
	ANDROID_dk_libDebug(${BULLET3}/${OS}/Debug/obj/local/armeabi-v7a/libMiniCL.a)
	ANDROID_dk_libRelease(${BULLET3}/${OS}/${RELEASE_DIR}/obj/local/armeabi-v7a/libMiniCL.a)
ENDIF(MiniCL)


### GENERATE ###
dk_setPath(${BOXER}/${BUILD_DIR})
dk_queueCommand(${DKCMAKE_BUILD} -DBUILD_DEMOS=OFF -DBUILD_EXTRAS=OFF -DUSE_GLUT=OFF ${BULLET3})


### COMPILE ###
WIN_dk_visualStudio(${BULLET3_NAME})
#MAC_dk_xcode(${BULLET3_NAME})
#IOS_dk_xcode(${BULLET3_NAME})
#IOSSIM_dk_xcode(${BULLET3_NAME})
dk_xcode(${BULLET3_NAME})
LINUX_dk_queueCommand(make)
RASPBERRY_dk_queueCommand(make)
ANDROID_dk_ndk(${BULLET3_NAME})
