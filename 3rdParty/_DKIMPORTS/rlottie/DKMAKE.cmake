# https://github.com/Samsung/rlottie.git


### IMPORT ###
dk_import(https://github.com/Samsung/rlottie.git)


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



### GENERATE ###
UNIX_dk_queueCommand(${DKCMAKE_BUILD}
	-DBUILD_SHARED_LIBS=OFF 
	-DBUILD_STATIC_LIBS=ON
	-DLOTTIE_MODULE=ON		# "Enable LOTTIE MODULE SUPPORT" ON
	-DLOTTIE_THREAD=ON 		# "Enable LOTTIE THREAD SUPPORT" ON
	-DLOTTIE_CACHE=ON  		# "Enable LOTTIE CACHE SUPPORT" ON
	-DLOTTIE_TEST=OFF 		# "Build LOTTIE AUTOTESTS" OFF
	-DLOTTIE_CCACHE=OFF 	# "Enable LOTTIE ccache SUPPORT" OFF
	-DLOTTIE_ASAN=OFF 		# "Compile with asan" OFF
	${RLOTTIE})
WIN_dk_queueCommand(${DKCMAKE_BUILD} #/EHsc
	-DBUILD_SHARED_LIBS=OFF 
	-DBUILD_STATIC_LIBS=ON
	-DLOTTIE_MODULE=ON		# "Enable LOTTIE MODULE SUPPORT" ON
	-DLOTTIE_THREAD=ON 		# "Enable LOTTIE THREAD SUPPORT" ON
	-DLOTTIE_CACHE=ON  		# "Enable LOTTIE CACHE SUPPORT" ON
	-DLOTTIE_TEST=OFF 		# "Build LOTTIE AUTOTESTS" OFF
	-DLOTTIE_CCACHE=OFF 	# "Enable LOTTIE ccache SUPPORT" OFF
	-DLOTTIE_ASAN=OFF 		# "Compile with asan" OFF
	${RLOTTIE})


dk_set(RLOTTIE_CMAKE --Drlottie_DIR=${RLOTTIE_INCLUDE_DIR})

### COMPILE ###
dk_build(${RLOTTIE} rlottie)
