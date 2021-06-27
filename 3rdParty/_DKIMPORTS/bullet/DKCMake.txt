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
	WIN_RELEASE_LIB(${BULLET}/${OS}/lib/Release/BulletCollision.lib)
	APPLE_DEBUG_LIB(${BULLET}/${OS}/src/BulletCollision/${DEBUG}/libBulletCollision.a)
	APPLE_RELEASE_LIB(${BULLET}/${OS}/src/BulletCollision/${RELEASE}/libBulletCollision.a)
	LINUX_DEBUG_LIB(${BULLET}/${OS}/Debug/src/BulletCollision/libBulletCollision.a)
	LINUX_RELEASE_LIB(${BULLET}/${OS}/Release/src/BulletCollision/libBulletCollision.a)
	ANDROID_DEBUG_LIB(${BULLET}/${OS}/Debug/obj/local/armeabi-v7a/libBulletCollision.a)
	ANDROID_RELEASE_LIB(${BULLET}/${OS}/Release/obj/local/armeabi-v7a/libBulletCollision.a)
ENDIF(BulletCollision)
	
IF(BulletDynamics)
	WIN_DEBUG_LIB(${BULLET}/${OS}/lib/Debug/BulletDynamics_Debug.lib)
	WIN_RELEASE_LIB(${BULLET}/${OS}/lib/Release/BulletDynamics.lib)
	APPLE_DEBUG_LIB(${BULLET}/${OS}/src/BulletDynamics/${DEBUG}/libBulletDynamics.a)
	APPLE_RELEASE_LIB(${BULLET}/${OS}/src/BulletDynamics/${RELEASE}/libBulletDynamics.a)
	LINUX_DEBUG_LIB(${BULLET}/${OS}/Debug/src/BulletDynamics/libBulletDynamics.a)
	LINUX_RELEASE_LIB(${BULLET}/${OS}/Release/src/BulletDynamics/libBulletDynamics.a)
	ANDROID_DEBUG_LIB(${BULLET}/${OS}/Debug/obj/local/armeabi-v7a/libBulletDynamics.a)
	ANDROID_RELEASE_LIB(${BULLET}/${OS}/Release/obj/local/armeabi-v7a/libBulletDynamics.a)
ENDIF(BulletDynamics)
	
IF(BulletMultiThreaded)
	WIN_DEBUG_LIB(${BULLET}/${OS}/lib/Debug/BulletMultiThreaded_Debug.lib)
	WIN_RELEASE_LIB(${BULLET}/${OS}/lib/Release/BulletMultiThreaded.lib)
	APPLE_DEBUG_LIB(${BULLET}/${OS}/src/BulletMultiThreaded/${DEBUG}/libBulletMultiThreaded.a)
	APPLE_RELEASE_LIB(${BULLET}/${OS}/src/BulletMultiThreaded/${RELEASE}/libBulletMultiThreaded.a)
	#LINUX_DEBUG_LIB(${BULLET}/${OS}/Debug/src/BulletMultiThreaded/libBulletMultiThreaded.a)
	#LINUX_RELEASE_LIB(${BULLET}/${OS}/Release/src/BulletMultiThreaded/libBulletMultiThreaded.a)
	ANDROID_DEBUG_LIB(${BULLET}/${OS}/Debug/obj/local/armeabi-v7a/libBulletMultiThreaded.a)
	ANDROID_RELEASE_LIB(${BULLET}/${OS}/Release/obj/local/armeabi-v7a/libBulletMultiThreaded.a)
ENDIF(BulletMultiThreaded)
	
IF(BulletSoftBody)
	WIN_DEBUG_LIB(${BULLET}/${OS}/lib/Debug/BulletSoftBody_Debug.lib)
	WIN_RELEASE_LIB(${BULLET}/${OS}/lib/Release/BulletSoftBody.lib)
	APPLE_DEBUG_LIB(${BULLET}/${OS}/src/BulletSoftBody/${DEBUG}/libBulletSoftBody.a)
	APPLE_RELEASE_LIB(${BULLET}/${OS}/src/BulletSoftBody/${RELEASE}/libBulletSoftBody.a)
	LINUX_DEBUG_LIB(${BULLET}/${OS}/Debug/src/BulletSoftBody/libBulletSoftBody.a)
	LINUX_RELEASE_LIB(${BULLET}/${OS}/Release/src/BulletSoftBody/libBulletSoftBody.a)
	ANDROID_DEBUG_LIB(${BULLET}/${OS}/Debug/obj/local/armeabi-v7a/libBulletSoftBody.a)
	ANDROID_RELEASE_LIB(${BULLET}/${OS}/Release/obj/local/armeabi-v7a/libBulletSoftBody.a)
ENDIF(BulletSoftBody)
	
IF(LinearMath)
	WIN_DEBUG_LIB(${BULLET}/${OS}/lib/Debug/LinearMath_Debug.lib)
	WIN_RELEASE_LIB(${BULLET}/${OS}/lib/Release/LinearMath.lib)
	APPLE_DEBUG_LIB(${BULLET}/${OS}/src/LinearMath/${DEBUG}/libLinearMath.a)
	APPLE_RELEASE_LIB(${BULLET}/${OS}/src/LinearMath/${RELEASE}/libLinearMath.a)
	LINUX_DEBUG_LIB(${BULLET}/${OS}/Debug/src/LinearMath/libLinearMath.a)
	LINUX_RELEASE_LIB(${BULLET}/${OS}/Release/src/LinearMath/libLinearMath.a)
	ANDROID_DEBUG_LIB(${BULLET}/${OS}/Debug/obj/local/armeabi-v7a/libLinearMath.a)
	ANDROID_RELEASE_LIB(${BULLET}/${OS}/Release/obj/local/armeabi-v7a/libLinearMath.a)
ENDIF(LinearMath)
	
IF(MiniCL)
	WIN_DEBUG_LIB(${BULLET}/${OS}/lib/Debug/MiniCL_Debug.lib)
	WIN_RELEASE_LIB(${BULLET}/${OS}/lib/Release/MiniCL.lib)
	APPLE_DEBUG_LIB(${BULLET}/${OS}/src/MiniCL/${DEBUG}/libMiniCL.a)
	APPLE_RELEASE_LIB(${BULLET}/${OS}/src/MiniCL/${RELEASE}/libMiniCL.a)
	#LINUX_DEBUG_LIB(${BULLET}/${OS}/Debug/src/MiniCL/libMiniCL.a)
	#LINUX_RELEASE_LIB(${BULLET}/${OS}/${RELEASE}/src/MiniCL/libMiniCL.a)
	ANDROID_DEBUG_LIB(${BULLET}/${OS}/Debug/obj/local/armeabi-v7a/libMiniCL.a)
	ANDROID_RELEASE_LIB(${BULLET}/${OS}/Release/obj/local/armeabi-v7a/libMiniCL.a)
ENDIF(MiniCL)


### COMPILE ###
DKSETPATH(${BULLET}/${OS})
WIN32_COMMAND(${CMAKE_COMMAND} -G ${GENERATOR} -A Win32 "-DCMAKE_CXX_FLAGS=/DWIN32 /D_WINDOWS /W3 /nologo /GR /EHsc" "-DCMAKE_CXX_FLAGS_DEBUG=/MTd /Od /Ob0 /Zi /RTC1 /DDEBUG /D_DEBUG" "-DCMAKE_CXX_FLAGS_RELEASE=/MT /O2 /Ob2 /DNDEBUG" -DBUILD_DEMOS=OFF -DBUILD_EXTRAS=OFF -DUSE_GLUT=OFF ${BULLET})
WIN32_VS_DEBUG(${BULLET_NAME} BULLET_PHYSICS.sln)
WIN32_VS_RELEASE(${BULLET_NAME} BULLET_PHYSICS.sln)

DKSETPATH(${BULLET}/${OS})
WIN64_COMMAND(${CMAKE_COMMAND} -G ${GENERATOR} -A x64 "-DCMAKE_CXX_FLAGS=/DWIN32 /D_WINDOWS /W3 /nologo /GR /EHsc" "-DCMAKE_CXX_FLAGS_DEBUG=/MTd /Od /Ob0 /Zi /RTC1 /DDEBUG /D_DEBUG" "-DCMAKE_CXX_FLAGS_RELEASE=/MT /O2 /Ob2 /DNDEBUG" -DBUILD_DEMOS=OFF -DBUILD_EXTRAS=OFF -DUSE_GLUT=OFF ${BULLET})
WIN64_VS_DEBUG(${BULLET_NAME} BULLET_PHYSICS.sln)
WIN64_VS_RELEASE(${BULLET_NAME} BULLET_PHYSICS.sln)

DKSETPATH(${BULLET}/${OS})
MAC_COMMAND(${CMAKE_COMMAND} -G "Xcode" -DCMAKE_OSX_ARCHITECTURES=x86_64 -DBUILD_DEMOS=OFF -DBUILD_EXTRAS=OFF -DUSE_GLUT=OFF ${BULLET})
MAC_XCODE_DEBUG(${BULLET_NAME})
MAC_XCODE_RELEASE(${BULLET_NAME})

DKSETPATH(${BULLET}/ios)
IOS_COMMAND(${CMAKE_COMMAND} -G "Xcode" -DCMAKE_TOOLCHAIN_FILE=${DKCMAKE}/iOS.cmake -DIOS_PLATFORM=OS -DBUILD_DEMOS=OFF -DBUILD_EXTRAS=OFF -DUSE_GLUT=OFF ${BULLET})
IOS_XCODE_DEBUG(${BULLET_NAME})
IOS_XCODE_RELEASE(${BULLET_NAME})

DKSETPATH(${BULLET}/ios-simulator)
IOSSIM_COMMAND(${CMAKE_COMMAND} -G "Xcode" -DCMAKE_TOOLCHAIN_FILE=${DKCMAKE}/iOS.cmake -DIOS_PLATFORM=SIMULATOR -DBUILD_DEMOS=OFF -DBUILD_EXTRAS=OFF -DUSE_GLUT=OFF ${BULLET})
IOSSIM_XCODE_DEBUG(${BULLET_NAME})
IOSSIM_XCODE_RELEASE(${BULLET_NAME})

DKSETPATH(${BULLET}/${OS}/Debug)
LINUX_DEBUG_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=DEBUG -DBUILD_DEMOS=OFF -DBUILD_EXTRAS=OFF -DUSE_GLUT=OFF ${BULLET})
LINUX_DEBUG_COMMAND(make)

DKSETPATH(${BULLET}/${OS}/Release)
LINUX_RELEASE_COMMAND(${CMAKE_COMMAND} -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=RELEASE -DBUILD_DEMOS=OFF -DBUILD_EXTRAS=OFF -DUSE_GLUT=OFF ${BULLET})
LINUX_RELEASE_COMMAND(make)

ANDROID_NDK_DEBUG(${BULLET_NAME})
ANDROID_NDK_RELEASE(${BULLET_NAME})