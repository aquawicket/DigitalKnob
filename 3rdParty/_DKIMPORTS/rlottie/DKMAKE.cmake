# https://github.com/Samsung/rlottie.git


### IMPORT ###
dk_import(https://github.com/Samsung/rlottie.git)


### LINK ###
dk_include				(${RLOTTIE}/inc)
dk_include				(${RLOTTIE}/${OS})
UNIX_dk_libDebug		(${RLOTTIE}/${OS}/${DEBUG_DIR}/librlottie.a)
UNIX_dk_libRelease		(${RLOTTIE}/${OS}/${RELEASE_DIR}/librlottie.a)
WIN_dk_libDebug			(${RLOTTIE}/${OS}/${DEBUG_DIR}/rlottie.lib)
WIN_dk_libRelease		(${RLOTTIE}/${OS}/${RELEASE_DIR}/rlottie.lib)


### GENERATE ###
UNIX_dk_queueCommand(${DKCMAKE_BUILD}
	-DLOTTIE_THREAD=ON 		# "Enable LOTTIE THREAD SUPPORT" ON
	-DLOTTIE_CACHE=ON  		# "Enable LOTTIE CACHE SUPPORT" ON
	-DLOTTIE_TEST=OFF 		# "Build LOTTIE AUTOTESTS" OFF
	-DLOTTIE_CCACHE=OFF 	# "Enable LOTTIE ccache SUPPORT" OFF
	-DLOTTIE_ASAN=OFF 		# "Compile with asan" OFF
	${RLOTTIE})
WIN_dk_queueCommand(${DKCMAKE_BUILD} 
	/EHsc 
	-DLOTTIE_THREAD=ON 		# "Enable LOTTIE THREAD SUPPORT" ON
	-DLOTTIE_CACHE=ON  		# "Enable LOTTIE CACHE SUPPORT" ON
	-DLOTTIE_TEST=OFF 		# "Build LOTTIE AUTOTESTS" OFF
	-DLOTTIE_CCACHE=OFF 	# "Enable LOTTIE ccache SUPPORT" OFF
	-DLOTTIE_ASAN=OFF 		# "Compile with asan" OFF
	${RLOTTIE})


### COMPILE ###
dk_build(${RLOTTIE} rlottie)
