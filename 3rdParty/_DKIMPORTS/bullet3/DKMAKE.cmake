# https://github.com/bulletphysics/bullet3
# https://code.google.com/archive/p/bullet
# https://github.com/bulletphysics/bullet3/archive/refs/tags/2.82.zip
# https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/bullet/bullet-2.82-r2704.zip


### IMPORT ###
#dk_import(https://github.com/bulletphysics/bullet3/archive/refs/tags/2.82.zip)
dk_import(https://github.com/bulletphysics/bullet3.git)


### LINK ###
dk_enable(ALL_LIBS)
if(ALL_LIBS)
	dk_enable(Bullet3Collision)
	dk_enable(Bullet3Common)
	dk_enable(Bullet3Dynamics)
	dk_enable(Bullet3Geometry)
	dk_enable(Bullet3OpenCL)
	dk_enable(Bullet3Serialize)
	dk_enable(BulletCollision)
	dk_enable(BulletDynamics)
	dk_enable(BulletInverseDynamics)
	dk_enable(BulletSoftBody)
	dk_enable(LinearMath)
endif(ALL_LIBS)


### LINK ###
dk_include					(${BULLET3}/src)

if(Bullet3Collision)
	WIN_dk_libDebug			(${BULLET3}/${OS}/lib/${DEBUG_DIR}/Bullet3Collision_Debug.lib)
	WIN_dk_libRelease		(${BULLET3}/${OS}/lib/${RELEASE_DIR}/Bullet3Collision.lib)
	APPLE_dk_libDebug		(${BULLET3}/${OS}/src/Bullet3Collision/${DEBUG_DIR}/libBullet3Collision.a)
	APPLE_dk_libRelease		(${BULLET3}/${OS}/src/Bullet3Collision/${RELEASE_DIR}/libBullet3Collision.a)
	LINUX_dk_libDebug		(${BULLET3}/${OS}/${DEBUG_DIR}/src/Bullet3Collision/libBullet3Collision.a)
	LINUX_dk_libRelease		(${BULLET3}/${OS}/${RELEASE_DIR}/src/Bullet3Collision/libBullet3Collision.a)
	ANDROID_dk_libDebug		(${BULLET3}/${OS}/src/Bullet3Collision/${DEBUG_DIR}//libBullet3Collision.a)
	ANDROID_dk_libRelease	(${BULLET3}/${OS}/src/Bullet3Collision/${RELEASE_DIR}/libBullet3Collision.a)
	EMSCRIPTEN_dk_libDebug	(${BULLET3}/${OS}/${DEBUG_DIR}/src/Bullet3Collision/libBullet3Collision.a)
	EMSCRIPTEN_dk_libRelease(${BULLET3}/${OS}/${RELEASE_DIR}/src/Bullet3Collision/libBullet3Collision.a)
endif()
if(Bullet3Common)
	WIN_dk_libDebug			(${BULLET3}/${OS}/lib/${DEBUG_DIR}/Bullet3Common_Debug.lib)
	WIN_dk_libRelease		(${BULLET3}/${OS}/lib/${RELEASE_DIR}/Bullet3Common.lib)
	APPLE_dk_libDebug		(${BULLET3}/${OS}/src/Bullet3Common/${DEBUG_DIR}/libBullet3Common.a)
	APPLE_dk_libRelease		(${BULLET3}/${OS}/src/Bullet3Common/${RELEASE_DIR}/libBullet3Common.a)
	LINUX_dk_libDebug		(${BULLET3}/${OS}/${DEBUG_DIR}/src/Bullet3Common/libBullet3Common.a)
	LINUX_dk_libRelease		(${BULLET3}/${OS}/${RELEASE_DIR}/src/Bullet3Common/libBullet3Common.a)
	ANDROID_dk_libDebug		(${BULLET3}/${OS}/src/Bullet3Common/${DEBUG_DIR}//libBullet3Common.a)
	ANDROID_dk_libRelease	(${BULLET3}/${OS}/src/Bullet3Common/${RELEASE_DIR}/libBullet3Common.a)
	EMSCRIPTEN_dk_libDebug	(${BULLET3}/${OS}/${DEBUG_DIR}/src/Bullet3Common/libBullet3Common.a)
	EMSCRIPTEN_dk_libRelease(${BULLET3}/${OS}/${RELEASE_DIR}/src/Bullet3Common/libBullet3Common.a)
endif()
if(Bullet3Dynamics)
	WIN_dk_libDebug			(${BULLET3}/${OS}/lib/${DEBUG_DIR}/Bullet3Dynamics_Debug.lib)
	WIN_dk_libRelease		(${BULLET3}/${OS}/lib/${RELEASE_DIR}/Bullet3Dynamics.lib)
	APPLE_dk_libDebug		(${BULLET3}/${OS}/src/Bullet3Dynamics/${DEBUG_DIR}/libBullet3Dynamics.a)
	APPLE_dk_libRelease		(${BULLET3}/${OS}/src/Bullet3Dynamics/${RELEASE_DIR}/libBullet3Dynamics.a)
	LINUX_dk_libDebug		(${BULLET3}/${OS}/${DEBUG_DIR}/src/Bullet3Dynamics/libBullet3Dynamics.a)
	LINUX_dk_libRelease		(${BULLET3}/${OS}/${RELEASE_DIR}/src/Bullet3Dynamics/libBullet3Dynamics.a)
	ANDROID_dk_libDebug		(${BULLET3}/${OS}/src/Bullet3Dynamics/${DEBUG_DIR}//libBullet3Dynamics.a)
	ANDROID_dk_libRelease	(${BULLET3}/${OS}/src/Bullet3Dynamics/${RELEASE_DIR}/libBullet3Dynamics.a)
	EMSCRIPTEN_dk_libDebug	(${BULLET3}/${OS}/${DEBUG_DIR}/src/Bullet3Dynamics/libBullet3Dynamics.a)
	EMSCRIPTEN_dk_libRelease(${BULLET3}/${OS}/${RELEASE_DIR}/src/Bullet3Dynamics/libBullet3Dynamics.a)
endif()
if(Bullet3Geometry)
	WIN_dk_libDebug			(${BULLET3}/${OS}/lib/${DEBUG_DIR}/Bullet3Geometry_Debug.lib)
	WIN_dk_libRelease		(${BULLET3}/${OS}/lib/${RELEASE_DIR}/Bullet3Geometry.lib)
	APPLE_dk_libDebug		(${BULLET3}/${OS}/src/Bullet3Geometry/${DEBUG_DIR}/libBullet3Geometry.a)
	APPLE_dk_libRelease		(${BULLET3}/${OS}/src/Bullet3Geometry/${RELEASE_DIR}/libBullet3Geometry.a)
	LINUX_dk_libDebug		(${BULLET3}/${OS}/${DEBUG_DIR}/src/Bullet3Geometry/libBullet3Geometry.a)
	LINUX_dk_libRelease		(${BULLET3}/${OS}/${RELEASE_DIR}/src/Bullet3Geometry/libBullet3Geometry.a)
	ANDROID_dk_libDebug		(${BULLET3}/${OS}/src/Bullet3Geometry/${DEBUG_DIR}//libBullet3Geometry.a)
	ANDROID_dk_libRelease	(${BULLET3}/${OS}/src/Bullet3Geometry/${RELEASE_DIR}/libBullet3Geometry.a)
	EMSCRIPTEN_dk_libDebug	(${BULLET3}/${OS}/${DEBUG_DIR}/src/Bullet3Geometry/libBullet3Geometry.a)
	EMSCRIPTEN_dk_libRelease(${BULLET3}/${OS}/${RELEASE_DIR}/src/Bullet3Geometry/libBullet3Geometry.a)
endif()
if(Bullet3OpenCL)
	WIN_dk_libDebug			(${BULLET3}/${OS}/lib/${DEBUG_DIR}/Bullet3OpenCL_clew_Debug.lib)
	WIN_dk_libRelease		(${BULLET3}/${OS}/lib/${RELEASE_DIR}/Bullet3OpenCL_clew.lib)
	APPLE_dk_libDebug		(${BULLET3}/${OS}/src/Bullet3OpenCL/${DEBUG_DIR}/libBullet3OpenCL_clew.a)
	APPLE_dk_libRelease		(${BULLET3}/${OS}/src/Bullet3OpenCL/${RELEASE_DIR}/libBullet3OpenCL_clew.a)
	LINUX_dk_libDebug		(${BULLET3}/${OS}/${DEBUG_DIR}/src/Bullet3OpenCL/libBullet3OpenCL_clew.a)
	LINUX_dk_libRelease		(${BULLET3}/${OS}/${RELEASE_DIR}/src/Bullet3OpenCL/libBullet3OpenCL_clew.a)
	ANDROID_dk_libDebug		(${BULLET3}/${OS}/src/Bullet3OpenCL/${DEBUG_DIR}//libBullet3OpenCL_clew.a)
	ANDROID_dk_libRelease	(${BULLET3}/${OS}/src/Bullet3OpenCL/${RELEASE_DIR}/libBullet3OpenCL_clew.a)
	EMSCRIPTEN_dk_libDebug	(${BULLET3}/${OS}/${DEBUG_DIR}/src/Bullet3OpenCL/libBullet3OpenCL_clew.a)
	EMSCRIPTEN_dk_libRelease(${BULLET3}/${OS}/${RELEASE_DIR}/src/Bullet3OpenCL/libBullet3OpenCL_clew.a)
endif()
if(Bullet3Serialize)
	WIN_dk_libDebug			(${BULLET3}/${OS}/lib/${DEBUG_DIR}/BulletFileLoader_Debug.lib)
	WIN_dk_libRelease		(${BULLET3}/${OS}/lib/${RELEASE_DIR}/BulletFileLoader.lib)
	APPLE_dk_libDebug		(${BULLET3}/${OS}/src/Bullet3Serialize/Bullet2FileLoader/${DEBUG_DIR}/libBullet2FileLoader.a)
	APPLE_dk_libRelease		(${BULLET3}/${OS}/src/Bullet3Serialize/Bullet2FileLoader/${RELEASE_DIR}/libBullet2FileLoader.a)
	LINUX_dk_libDebug		(${BULLET3}/${OS}/${DEBUG_DIR}/src/Bullet3Serialize/Bullet2FileLoader/libBullet2FileLoader.a)
	LINUX_dk_libRelease		(${BULLET3}/${OS}/${RELEASE_DIR}/src/Bullet3Serialize/Bullet2FileLoader/libBullet2FileLoader.a)
	ANDROID_dk_libDebug		(${BULLET3}/${OS}/src/Bullet3Serialize/${DEBUG_DIR}//libBullet3Serialize.a)
	ANDROID_dk_libRelease	(${BULLET3}/${OS}/src/Bullet3Serialize/${RELEASE_DIR}/libBullet3Serialize.a)
	EMSCRIPTEN_dk_libDebug	(${BULLET3}/${OS}/${DEBUG_DIR}/src/Bullet3Serialize/Bullet2FileLoader/libBullet2FileLoader.a)
	EMSCRIPTEN_dk_libRelease(${BULLET3}/${OS}/${RELEASE_DIR}/src/Bullet3Serialize/Bullet2FileLoader/libBullet2FileLoader.a)
endif()
if(BulletCollision)
	WIN_dk_libDebug			(${BULLET3}/${OS}/lib/${DEBUG_DIR}/BulletCollision_Debug.lib)
	WIN_dk_libRelease		(${BULLET3}/${OS}/lib/${RELEASE_DIR}/BulletCollision.lib)
	APPLE_dk_libDebug		(${BULLET3}/${OS}/src/BulletCollision/${DEBUG_DIR}/libBulletCollision.a)
	APPLE_dk_libRelease		(${BULLET3}/${OS}/src/BulletCollision/${RELEASE_DIR}/libBulletCollision.a)
	LINUX_dk_libDebug		(${BULLET3}/${OS}/${DEBUG_DIR}/src/BulletCollision/libBulletCollision.a)
	LINUX_dk_libRelease		(${BULLET3}/${OS}/${RELEASE_DIR}/src/BulletCollision/libBulletCollision.a)
	ANDROID_dk_libDebug		(${BULLET3}/${OS}/src/BulletCollision/${DEBUG_DIR}//libBulletCollision.a)
	ANDROID_dk_libRelease	(${BULLET3}/${OS}/src/BulletCollision/${RELEASE_DIR}/libBulletCollision.a)
	EMSCRIPTEN_dk_libDebug	(${BULLET3}/${OS}/${DEBUG_DIR}/src/BulletCollision/libBulletCollision.a)
	EMSCRIPTEN_dk_libRelease(${BULLET3}/${OS}/${RELEASE_DIR}/src/BulletCollision/libBulletCollision.a)
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
	EMSCRIPTEN_dk_libDebug	(${BULLET3}/${OS}/${DEBUG_DIR}/src/BulletDynamics/libBulletDynamics.a)
	EMSCRIPTEN_dk_libRelease(${BULLET3}/${OS}/${RELEASE_DIR}/src/BulletDynamics/libBulletDynamics.a)
endif()
if(BulletInverseDynamics)
	WIN_dk_libDebug			(${BULLET3}/${OS}/lib/${DEBUG_DIR}/BulletInverseDynamics_Debug.lib)
	WIN_dk_libRelease		(${BULLET3}/${OS}/lib/${RELEASE_DIR}/BulletInverseDynamics.lib)
	APPLE_dk_libDebug		(${BULLET3}/${OS}/src/BulletInverseDynamics/${DEBUG_DIR}/libBulletInverseDynamics.a)
	APPLE_dk_libRelease		(${BULLET3}/${OS}/src/BulletInverseDynamics/${RELEASE_DIR}/libBulletInverseDynamics.a)
	LINUX_dk_libDebug		(${BULLET3}/${OS}/${DEBUG_DIR}/src/BulletInverseDynamics/libBulletInverseDynamics.a)
	LINUX_dk_libRelease		(${BULLET3}/${OS}/${RELEASE_DIR}/src/BulletInverseDynamics/libBulletInverseDynamics.a)
	ANDROID_dk_libDebug		(${BULLET3}/${OS}/src/BulletInverseDynamics/${DEBUG_DIR}/libBulletInverseDynamics.a)
	ANDROID_dk_libRelease	(${BULLET3}/${OS}/src/BulletInverseDynamics/${RELEASE_DIR}/libBulletInverseDynamics.a)
	EMSCRIPTEN_dk_libDebug	(${BULLET3}/${OS}/${DEBUG_DIR}/src/BulletInverseDynamics/libBulletInverseDynamics.a)
	EMSCRIPTEN_dk_libRelease(${BULLET3}/${OS}/${RELEASE_DIR}/src/BulletInverseDynamics/libBulletInverseDynamics.a)
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
	EMSCRIPTEN_dk_libDebug	(${BULLET3}/${OS}/${DEBUG_DIR}/src/BulletSoftBody/libBulletSoftBody.a)
	EMSCRIPTEN_dk_libRelease(${BULLET3}/${OS}/${RELEASE_DIR}/src/BulletSoftBody/libBulletSoftBody.a)
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
	EMSCRIPTEN_dk_libDebug	(${BULLET3}/${OS}/${DEBUG_DIR}/src/LinearMath/libLinearMath.a)
	EMSCRIPTEN_dk_libRelease(${BULLET3}/${OS}/${RELEASE_DIR}/src/LinearMath/libLinearMath.a)
endif(LinearMath)


### 3RDPARTY LINK ###
WIN_dk_set(BULLET3_CMAKE
	-DBULLET3_COLLISION_LIBRARY=${BULLET3}/${OS}/lib/${RELEASE_DIR}/Bullet3Collision_Debug.lib
	-DBULLET_DYNAMICS_LIBRARY=${BULLET3}/${OS}/lib/${RELEASE_DIR}/BulletDynamics.lib 
	-DBULLET_COLLISION_LIBRARY=${BULLET3}/${OS}/lib/${RELEASE_DIR}/BulletCollision.lib 
	-DBULLET_MATH_LIBRARY=${BULLET3}/${OS}/lib/${RELEASE_DIR}/LinearMath.lib 
	-DBULLET_SOFTBODY_LIBRARY=${BULLET3}/${OS}/lib/${RELEASE_DIR}/BulletSoftBody.lib 
	-DBULLET_INCLUDE_DIR=${BULLET3}/include)
APPLE_dk_set(BULLET3_CMAKE
	-DBULLET_COMMON_LIBRARY=${BULLET3}/${OS}/src/Bullet3Common/${RELEASE_DIR}/libBullet3Common.a
	-DBULLET_DYNAMICS_LIBRARY=${BULLET3}/${OS}/src/BulletDynamics/${RELEASE_DIR}/libBulletDynamics.a
	-DBULLET_INVERSE_DYNAMICS_LIBRARY=${BULLET3}/${OS}/src/BulletInverseDynamics/${RELEASE_DIR}/libBulletInverseDynamics.a
	-DBULLET_COLLISION_LIBRARY=${BULLET3}/${OS}/src/BulletCollision/${RELEASE_DIR}/libBulletCollision.a 
	-DBULLET_MATH_LIBRARY=${BULLET3}/${OS}/src/LinearMath/${RELEASE_DIR}/libLinearMath.a
	-DBULLET_SOFTBODY_LIBRARY=${BULLET3}/${OS}/src/BulletSoftBody/${RELEASE_DIR}/libBulletSoftBody.a
	-DBULLET_INCLUDE_DIR=${BULLET3}/include)
LINUX_DEBUG_dk_set(BULLET3_CMAKE 
	-DBULLET_DYNAMICS_LIBRARY=${BULLET3}/${OS}/${DEBUG_DIR}/src/BulletDynamics/libBulletDynamics.a
	-DBULLET_COLLISION_LIBRARY=${BULLET3}/${OS}/${DEBUG_DIR}/src/BulletCollision/libBulletCollision.a
	-DBULLET_MATH_LIBRARY=${BULLET3}/${OS}/${DEBUG_DIR}/src/LinearMath/libLinearMath.a
	-DBULLET_SOFTBODY_LIBRARY=${BULLET3}/${OS}/${DEBUG_DIR}/src/BulletSoftBody/libBulletSoftBody.a
	-DBULLET_INCLUDE_DIR=${BULLET3}/include)
LINUX_RELEASE_dk_set(BULLET3_CMAKE 
	-DBULLET_DYNAMICS_LIBRARY=${BULLET3}/${OS}/${RELEASE_DIR}/src/BulletDynamics/libBulletDynamics.a
	-DBULLET_COLLISION_LIBRARY=${BULLET3}/${OS}/${RELEASE_DIR}/src/BulletCollision/libBulletCollision.a
	-DBULLET_MATH_LIBRARY=${BULLET3}/${OS}/${RELEASE_DIR}/src/LinearMath/libLinearMath.a
	-DBULLET_SOFTBODY_LIBRARY=${BULLET3}/${OS}/${RELEASE_DIR}/src/BulletSoftBody/libBulletSoftBody.a
	-DBULLET_INCLUDE_DIR=${BULLET3}/include)
RASPBERRY_DEBUG_dk_set(BULLET3_CMAKE 
	-DBULLET_DYNAMICS_LIBRARY=${BULLET3}/${OS}/${DEBUG_DIR}/src/BulletDynamics/libBulletDynamics.a
	-DBULLET_COLLISION_LIBRARY=${BULLET3}/${OS}/${DEBUG_DIR}/src/BulletCollision/libBulletCollision.a
	-DBULLET_MATH_LIBRARY=${BULLET3}/${OS}/${DEBUG_DIR}/src/LinearMath/libLinearMath.a
	-DBULLET_SOFTBODY_LIBRARY=${BULLET3}/${OS}/${DEBUG_DIR}/src/BulletSoftBody/libBulletSoftBody.a
	-DBULLET_INCLUDE_DIR=${BULLET3}/include)
RASPBERRY_RELEASE_dk_set(BULLET3_CMAKE 
	-DBULLET_DYNAMICS_LIBRARY=${BULLET3}/${OS}/${RELEASE_DIR}/src/BulletDynamics/libBulletDynamics.a
	-DBULLET_COLLISION_LIBRARY=${BULLET3}/${OS}/${RELEASE_DIR}/src/BulletCollision/libBulletCollision.a
	-DBULLET_MATH_LIBRARY=${BULLET3}/${OS}/${RELEASE_DIR}/src/LinearMath/libLinearMath.a
	-DBULLET_SOFTBODY_LIBRARY=${BULLET3}/${OS}/${RELEASE_DIR}/src/BulletSoftBody/libBulletSoftBody.a
	-DBULLET_INCLUDE_DIR=${BULLET3}/include)
ANDROID_dk_set(BULLET3_CMAKE 
	-DBULLET_DYNAMICS_LIBRARY=${BULLET3}/${OS}/src/BulletDynamics/${RELEASE_DIR}/libBulletDynamics.a
	-DBULLET_COLLISION_LIBRARY=${BULLET3}/${OS}/src/Bullet3Collision/${RELEASE_DIR}/libBulletCollision.a
	-DBULLET_MATH_LIBRARY=${BULLET3}/${OS}/src/LinearMath/${RELEASE_DIR}/libLinearMath.a
	-DBULLET_SOFTBODY_LIBRARY=${BULLET3}/${OS}/src/BulletSoftBody/${RELEASE_DIR}/libBulletSoftBody.a
	-DBULLET_INCLUDE_DIR=${BULLET3}/include)
EMSCRIPTEN_DEBUG_dk_set(BULLET3_CMAKE 
	-DBULLET_DYNAMICS_LIBRARY=${BULLET3}/${OS}/${DEBUG_DIR}/src/BulletDynamics/libBulletDynamics.a
	-DBULLET_COLLISION_LIBRARY=${BULLET3}/${OS}/${DEBUG_DIR}/src/BulletCollision/libBulletCollision.a
	-DBULLET_MATH_LIBRARY=${BULLET3}/${OS}/${DEBUG_DIR}/src/LinearMath/libLinearMath.a
	-DBULLET_SOFTBODY_LIBRARY=${BULLET3}/${OS}/${DEBUG_DIR}/src/BulletSoftBody/libBulletSoftBody.a
	-DBULLET_INCLUDE_DIR=${BULLET3}/include)
EMSCRIPTEN_RELEASE_dk_set(BULLET3_CMAKE 
	-DBULLET_DYNAMICS_LIBRARY=${BULLET3}/${OS}/${RELEASE_DIR}/src/BulletDynamics/libBulletDynamics.a
	-DBULLET_COLLISION_LIBRARY=${BULLET3}/${OS}/${RELEASE_DIR}/src/BulletCollision/libBulletCollision.a
	-DBULLET_MATH_LIBRARY=${BULLET3}/${OS}/${RELEASE_DIR}/src/LinearMath/libLinearMath.a
	-DBULLET_SOFTBODY_LIBRARY=${BULLET3}/${OS}/${RELEASE_DIR}/src/BulletSoftBody/libBulletSoftBody.a
	-DBULLET_INCLUDE_DIR=${BULLET3}/include)
	

### GENERATE ###
#dk_queueCommand(${DKCMAKE_BUILD} -DBUILD_DEMOS=OFF -DBUILD_EXTRAS=OFF -DUSE_GLUT=OFF ${BULLET3})
#UNIX_dk_queueCommand(${DKCMAKE_BUILD} -DBUILD_PYBULLET=ON -DBUILD_PYBULLET_NUMPY=ON -DUSE_DOUBLE_PRECISION=ON -DBT_USE_EGL=ON ${BULLET3})
dk_queueCommand(${DKCMAKE_BUILD} ${BULLET3})


### COMPILE ###
dk_build(${BULLET3_FOLDER})
