# https://github.com/Samsung/rlottie.git


### IMPORT ###
dk_import(https://github.com/Samsung/rlottie.git)

### PATCH ###
dk_fileReplace(${RLOTTIE}/CMakeLists.txt "set(CMAKE_CXX_FLAGS_RELEASE \"\${CMAKE_CXX_FLAGS_RELEASE} /MT\")" "")
dk_fileReplace(${RLOTTIE}/CMakeLists.txt "set(CMAKE_CXX_FLAGS_DEBUG \"\${CMAKE_CXX_FLAGS_DEBUG} /MTd\")" "")


### LINK ###
dk_include				(${RLOTTIE}/inc						RLOTTIE_INCLUDE_DIR)
dk_include				(${RLOTTIE}/${OS})
if(MSVC)
	WIN_dk_libDebug		(${RLOTTIE}/${OS}/${DEBUG_DIR}/rlottie.lib)
	WIN_dk_libRelease	(${RLOTTIE}/${OS}/${RELEASE_DIR}/rlottie.lib)
else()
	dk_libDebug			(${RLOTTIE}/${OS}/${DEBUG_DIR}/librlottie.a)
	dk_libRelease		(${RLOTTIE}/${OS}/${RELEASE_DIR}/librlottie.a)
endif()


### 3RDPARTY LINK ###
dk_set(RLOTTIE_CMAKE -Drlottie_DIR=${RLOTTIE}/${OS}/${DEBUG_DIR} -Drlottie_INCLUDE_DIR=${RLOTTIE}/inc)


### GENERATE ###
dk_configure(${RLOTTIE}
	-DBUILD_SHARED_LIBS=OFF 
	-DBUILD_STATIC_LIBS=ON
	-DLOTTIE_MODULE=ON		# "Enable LOTTIE MODULE SUPPORT" ON
	-DLOTTIE_THREAD=ON 		# "Enable LOTTIE THREAD SUPPORT" ON
	-DLOTTIE_CACHE=ON  		# "Enable LOTTIE CACHE SUPPORT" ON
	-DLOTTIE_TEST=OFF 		# "Build LOTTIE AUTOTESTS" OFF
	-DLOTTIE_CCACHE=OFF 	# "Enable LOTTIE ccache SUPPORT" OFF
	-DLOTTIE_ASAN=OFF) 		# "Compile with asan" OFF


### COMPILE ###
dk_build(${RLOTTIE} rlottie)
