include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://github.com/glfw/glfw.git
# https://www.glfw.org/docs/latest/compile.html


### DEPEND ###
#dk_depend(wayland)
#dk_depend(x11)


### IMPORT ###
#dk_import(https://github.com/glfw/glfw.git)
dk_import(https://github.com/glfw/glfw/archive/refs/heads/master.zip)


### LINK ###
dk_include				(${GLFW}/include								GLFW_INCLUDE_DIR)
dk_include				(${GLFW}/${triple}/include/freetype2				GLFW_INCLUDE_DIR2)  # IS This Right?
if(MSVC)
	WIN_dk_libDebug		(${GLFW}/${triple}/${DEBUG_DIR}/src/glfw3.lib		GLFW_LIBRARY_DEBUG)
	WIN_dk_libRelease	(${GLFW}/${triple}/${RELEASE_DIR}/src/glfw.lib		GLFW_LIBRARY_RELEASE)
elseif(MAC)
	dk_libDebug			(${GLFW}/${triple}/src/${DEBUG_DIR}/libglfw3.a		GLFW_LIBRARY_DEBUG)
	dk_libRelease		(${GLFW}/${triple}/src/${RELEASE_DIR}/libglfw3.a	GLFW_LIBRARY_RELEASE)
else()
	dk_libDebug			(${GLFW}/${triple}/${DEBUG_DIR}/src/libglfw3.a		GLFW_LIBRARY_DEBUG)
	dk_libRelease		(${GLFW}/${triple}/${RELEASE_DIR}/src/libglfw3.a	GLFW_LIBRARY_RELEASE)
endif()


## https://www.glfw.org/docs/latest/compile.html

### 3RDPARTY LINK ###
dk_set(GLFW_CMAKE -Dglfw3_DIR=${GLFW}) #-DGLFW_INCLUDE_DIR=${GLFW_INCLUDE_DIR}


	
### GENERATE ###
dk_configure(${GLFW})


### COMPILE ###
dk_build(${GLFW} glfw)