# https://github.com/openframeworks/openFrameworks
# https://github.com/openframeworks/openFrameworks/archive/refs/tags/0.10.0.zip


### DEPEND ###
dk_depend(glew)
dk_depend(opengl)



### IMPORT ###
#dk_import(https://github.com/openframeworks/openFrameworks/archive/refs/tags/0.10.0.zip PATCH)
dk_import(https://github.com/openframeworks/openFrameworks.git PATCH)



### LINK ###
dk_include(${OPENFRAMEWORKS})
dk_include(${OPENFRAMEWORKS}/libs/openFrameworks)
dk_include(${OPENFRAMEWORKS}/libs/openFrameworks/utils)
dk_include(${OPENFRAMEWORKS}/libs/glew/include)
dk_include(${OPENFRAMEWORKS}/libs/glu/include)
dk_include(${OPENFRAMEWORKS}/libs/tess2/include)
dk_include(${OPENFRAMEWORKS}/libs/json/include)
dk_include(${OPENFRAMEWORKS}/libs/openFrameworks/types)
dk_include(${OPENFRAMEWORKS}/libs/openFrameworks/math)
dk_include(${OPENFRAMEWORKS}/libs/openFrameworks/events)
dk_include(${OPENFRAMEWORKS}/libs/utf8cpp/include)
dk_include(${OPENFRAMEWORKS}/libs/openFrameworks/3d)
dk_include(${OPENFRAMEWORKS}/libs/openFrameworks/gl)
dk_include(${OPENFRAMEWORKS}/libs/openFrameworks/graphics)
dk_include(${OPENFRAMEWORKS}/libs/poco/include)
dk_include(${OPENFRAMEWORKS}/libs/openFrameworks/communication)
dk_include(${OPENFRAMEWORKS}/libs/openFrameworks/app)
dk_include(${OPENFRAMEWORKS}/libs/cairo/include/cairo)
dk_include(${OPENFRAMEWORKS}/libs/glfw/include)
dk_include(${OPENFRAMEWORKS}/libs/openFrameworks/sound)
dk_include(${OPENFRAMEWORKS}/libs/fmodex/include)
dk_include(${OPENFRAMEWORKS}/libs/openFrameworks/video)
dk_include(${OPENFRAMEWORKS}/libs/videoInput/include)
WIN_dk_libDebug(${OPENFRAMEWORKS}/${OS}/lib/${DEBUG_DIR}/openFrameworks.lib)
WIN_dk_libRelease(${OPENFRAMEWORKS}/${OS}/lib/${RELEASE_DIR}/openFrameworks.lib)
UNIX_dk_libDebug(${OPENFRAMEWORKS}/${OS}/lib/${DEBUG_DIR}/libopenframeworks.a)
UNIX_dk_libRelease(${OPENFRAMEWORKS}/${OS}/lib/${RELEASE_DIR}/libopenframeworks.a)


### GENERATE ###
dk_setPath(${OPENFRAMEWORKS}/${BUILD_DIR})
dk_command(${DKCMAKE_BUILD} -DOF_PATH=${OPENFRAMEWORKS} ${OPENFRAMEWORKS})


### COMPILE ###
dk_visualStudio				(${OPENFRAMEWORKS_NAME} openFrameworks)
dk_xcode					(${OPENFRAMEWORKS_NAME} openFrameworks)
LINUX_dk_queueCommand		(make openFrameworks)
RASPBERRY_dk_queueCommand	(make openFrameworks)
