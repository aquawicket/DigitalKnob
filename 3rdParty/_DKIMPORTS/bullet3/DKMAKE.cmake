# https://github.com/bulletphysics/bullet3
# https://code.google.com/archive/p/bullet
# https://github.com/bulletphysics/bullet3/archive/refs/tags/2.82.zip
# https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/bullet/bullet-2.82-r2704.zip


### IMPORT ###
#dk_import(https://github.com/bulletphysics/bullet3/archive/refs/tags/2.82.zip)
dk_import(https://github.com/bulletphysics/bullet3.git)


dk_set(BulletCollision ON)
dk_set(BulletDynamics ON)
dk_set(BulletMultiThreaded ON)
dk_set(BulletSoftBody ON)
dk_set(LinearMath ON)
dk_set(MiniCL ON)
### LINK ###
dk_include					(${BULLET3}/src)
if(BulletCollision)
	WIN_dk_libDebug			(${BULLET3}/${OS}/lib/${DEBUG_DIR}/BulletCollision_Debug.lib)
	WIN_dk_libRelease		(${BULLET3}/${OS}/lib/${RELEASE_DIR}/BulletCollision.lib)
	APPLE_dk_libDebug		(${BULLET3}/${OS}/src/BulletCollision/${DEBUG_DIR}/libBulletCollision.a)
	APPLE_dk_libRelease		(${BULLET3}/${OS}/src/BulletCollision/${RELEASE_DIR}/libBulletCollision.a)
	LINUX_dk_libDebug		(${BULLET3}/${OS}/${DEBUG_DIR}/src/BulletCollision/libBulletCollision.a)
	LINUX_dk_libRelease		(${BULLET3}/${OS}/${RELEASE_DIR}/src/BulletCollision/libBulletCollision.a)
	ANDROID_dk_libDebug		(${BULLET3}/${OS}/src/Bullet3Collision/${DEBUG_DIR}//libBulletCollision.a)
	ANDROID_dk_libRelease	(${BULLET3}/${OS}/src/Bullet3Collision/${RELEASE_DIR}/libBulletCollision.a)
endif()

if(BulletCommon)
	WIN_dk_libDebug			(${BULLET3}/${OS}/lib/${DEBUG_DIR}/BulletCollision_Debug.lib)
	WIN_dk_libRelease		(${BULLET3}/${OS}/lib/${RELEASE_DIR}/BulletCollision.lib)
	APPLE_dk_libDebug		(${BULLET3}/${OS}/src/BulletCollision/${DEBUG_DIR}/libBulletCollision.a)
	APPLE_dk_libRelease		(${BULLET3}/${OS}/src/BulletCollision/${RELEASE_DIR}/libBulletCollision.a)
	LINUX_dk_libDebug		(${BULLET3}/${OS}/${DEBUG_DIR}/src/BulletCollision/libBulletCollision.a)
	LINUX_dk_libRelease		(${BULLET3}/${OS}/${RELEASE_DIR}/src/BulletCollision/libBulletCollision.a)
	ANDROID_dk_libDebug		(${BULLET3}/${OS}/src/Bullet3Collision/${DEBUG_DIR}//libBulletCollision.a)
	ANDROID_dk_libRelease	(${BULLET3}/${OS}/src/Bullet3Collision/${RELEASE_DIR}/libBulletCollision.a)
endif()
	
if(BulletDynamics)
	WIN_dk_libDebug			(${BULLET3}/${OS}/lib/${DEBUG_DIR}/BulletDynamics_Debug.lib)
	WIN_dk_libRelease		(${BULLET3}/${OS}/lib/${RELEASE_DIR}/BulletDynamics.lib)
	APPLE_dk_libDebug		(${BULLET3}/${OS}/src/BulletDynamics/${DEBUG_DIR}/libBulletDynamics.a)
	APPLE_dk_libRelease		(${BULLET3}/${OS}/src/BulletDynamics/${RELEASE_DIR}/libBulletDynamics.a)
	LINUX_dk_libDebug		(${BULLET3}/${OS}/${DEBUG_DIR}/src/BulletDynamics/libBulletDynamics.a)
	LINUX_dk_libRelease		(${BULLET3}/${OS}/${RELEASE_DIR}/src/BulletDynamics/libBulletDynamics.a)
	ANDROID_dk_libDebug		(${BULLET3}/${OS}/src/BulletDynamics/${DEBUG_DIR}/libBulletDynamics.a)
	ANDROID_dk_libRelease	(${BULLET3}/${OS}/src/BulletDynamics/${RELEASE_DIR}/libBulletDynamics.a)
endif()
	
if(BulletMultiThreaded)
	WIN_dk_libDebug			(${BULLET3}/${OS}/lib/${DEBUG_DIR}/BulletMultiThreaded_Debug.lib)
	WIN_dk_libRelease		(${BULLET3}/${OS}/lib/${RELEASE_DIR}/BulletMultiThreaded.lib)
	APPLE_dk_libDebug		(${BULLET3}/${OS}/src/BulletMultiThreaded/${DEBUG_DIR}/libBulletMultiThreaded.a)
	APPLE_dk_libRelease		(${BULLET3}/${OS}/src/BulletMultiThreaded/${RELEASE_DIR}/libBulletMultiThreaded.a)
	LINUX_dk_libDebug		(${BULLET3}/${OS}/${DEBUG_DIR}/src/BulletMultiThreaded/libBulletMultiThreaded.a)
	LINUX_dk_libRelease		(${BULLET3}/${OS}/${RELEASE_DIR}/src/BulletMultiThreaded/libBulletMultiThreaded.a)
	ANDROID_dk_libDebug		(${BULLET3}/${OS}/src/BulletMultiThreaded/${DEBUG_DIR}/libBulletMultiThreaded.a)
	ANDROID_dk_libRelease	(${BULLET3}/${OS}/src/BulletMultiThreaded/${RELEASE_DIR}/libBulletMultiThreaded.a)
endif()
	
if(BulletSoftBody)
	WIN_dk_libDebug			(${BULLET3}/${OS}/lib/${DEBUG_DIR}/BulletSoftBody_Debug.lib)
	WIN_dk_libRelease		(${BULLET3}/${OS}/lib/${RELEASE_DIR}/BulletSoftBody.lib)
	APPLE_dk_libDebug		(${BULLET3}/${OS}/src/BulletSoftBody/${DEBUG_DIR}/libBulletSoftBody.a)
	APPLE_dk_libRelease		(${BULLET3}/${OS}/src/BulletSoftBody/${RELEASE_DIR}/libBulletSoftBody.a)
	LINUX_dk_libDebug		(${BULLET3}/${OS}/${DEBUG_DIR}/src/BulletSoftBody/libBulletSoftBody.a)
	LINUX_dk_libRelease		(${BULLET3}/${OS}/${RELEASE_DIR}/src/BulletSoftBody/libBulletSoftBody.a)
	ANDROID_dk_libDebug		(${BULLET3}/${OS}/src/BulletSoftBody/${DEBUG_DIR}/libBulletSoftBody.a)
	ANDROID_dk_libRelease	(${BULLET3}/${OS}/src/BulletSoftBody/${RELEASE_DIR}/libBulletSoftBody.a)
endif()
	
if(LinearMath)
	WIN_dk_libDebug			(${BULLET3}/${OS}/lib/${DEBUG_DIR}/LinearMath_Debug.lib)
	WIN_dk_libRelease		(${BULLET3}/${OS}/lib/${RELEASE_DIR}/LinearMath.lib)
	APPLE_dk_libDebug		(${BULLET3}/${OS}/src/LinearMath/${DEBUG_DIR}/libLinearMath.a)
	APPLE_dk_libRelease		(${BULLET3}/${OS}/src/LinearMath/${RELEASE_DIR}/libLinearMath.a)
	LINUX_dk_libDebug		(${BULLET3}/${OS}/${DEBUG_DIR}/src/LinearMath/libLinearMath.a)
	LINUX_dk_libRelease		(${BULLET3}/${OS}/${RELEASE_DIR}/src/LinearMath/libLinearMath.a)
	ANDROID_dk_libDebug		(${BULLET3}/${OS}/src/LinearMath/${DEBUG_DIR}/libLinearMath.a)
	ANDROID_dk_libRelease	(${BULLET3}/${OS}/src/LinearMath/${RELEASE_DIR}/libLinearMath.a)
endif(LinearMath)
	
if(MiniCL)
	WIN_dk_libDebug			(${BULLET3}/${OS}/lib/${DEBUG_DIR}/MiniCL_Debug.lib)
	WIN_dk_libRelease		(${BULLET3}/${OS}/lib/${RELEASE_DIR}/MiniCL.lib)
	APPLE_dk_libDebug		(${BULLET3}/${OS}/src/MiniCL/${DEBUG_DIR}/libMiniCL.a)
	APPLE_dk_libRelease		(${BULLET3}/${OS}/src/MiniCL/${RELEASE_DIR}/libMiniCL.a)
	LINUX_dk_libDebug		(${BULLET3}/${OS}/${DEBUG_DIR}/src/MiniCL/libMiniCL.a)
	LINUX_dk_libRelease		(${BULLET3}/${OS}/${RELEASE_DIR}/src/MiniCL/libMiniCL.a)
	ANDROID_dk_libDebug		(${BULLET3}/${OS}/src/MiniCL/${DEBUG_DIR}/libMiniCL.a)
	ANDROID_dk_libRelease	(${BULLET3}/${OS}/src/MiniCL/${RELEASE_DIR}/libMiniCL.a)
endif(MiniCL)


### GENERATE ###
dk_setPath(${BULLET3}/${BUILD_DIR})
dk_queueCommand(${DKCMAKE_BUILD} -DBUILD_DEMOS=OFF -DBUILD_EXTRAS=OFF -DUSE_GLUT=OFF ${BULLET3})


### COMPILE ###
dk_visualStudio		(${BULLET3_FOLDER}) # windows, android
dk_xcode			(${BULLET3_FOLDER}) # mac, ios, iossim
dk_make				(${BULLET3_FOLDER}) # linux, raspberry
