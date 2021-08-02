### VERSION ###
DKSET(OPENFRAMEWORKS_VERSION 0.10.0)
DKSET(OPENFRAMEWORKS_NAME openFrameworks-${OPENFRAMEWORKS_VERSION})
DKSET(OPENFRAMEWORKS ${3RDPARTY}/${OPENFRAMEWORKS_NAME})


### INSTALL ###
## https://github.com/openframeworks/openFrameworks/archive/refs/tags/0.10.0.zip
DKINSTALL(https://github.com/openframeworks/openFrameworks/archive/refs/tags/${OPENFRAMEWORKS_VERSION}.zip openFrameworks ${OPENFRAMEWORKS})



### LINK ###
DKINCLUDE(${OPENFRAMEWORKS})
WIN32_INCLUDE(${OPENFRAMEWORKS}/libs/openFrameworks)
WIN32_INCLUDE(${OPENFRAMEWORKS}/libs/openFrameworks/utils)
WIN32_INCLUDE(${OPENFRAMEWORKS}/libs/glew/include)
WIN32_INCLUDE(${OPENFRAMEWORKS}/libs/glu/include)
WIN32_INCLUDE(${OPENFRAMEWORKS}/libs/tess2/include)
WIN32_INCLUDE(${OPENFRAMEWORKS}/libs/json/include)
WIN32_INCLUDE(${OPENFRAMEWORKS}/libs/openFrameworks/types)
WIN32_INCLUDE(${OPENFRAMEWORKS}/libs/openFrameworks/math)
WIN32_INCLUDE(${OPENFRAMEWORKS}/libs/openFrameworks/events)
WIN32_INCLUDE(${OPENFRAMEWORKS}/libs/utf8cpp/include)
WIN32_INCLUDE(${OPENFRAMEWORKS}/libs/openFrameworks/3d)
WIN32_INCLUDE(${OPENFRAMEWORKS}/libs/openFrameworks/gl)
WIN32_INCLUDE(${OPENFRAMEWORKS}/libs/openFrameworks/graphics)
WIN32_INCLUDE(${OPENFRAMEWORKS}/libs/poco/include)
WIN32_INCLUDE(${OPENFRAMEWORKS}/libs/openFrameworks/communication)
WIN32_INCLUDE(${OPENFRAMEWORKS}/libs/openFrameworks/app)
WIN32_INCLUDE(${OPENFRAMEWORKS}/libs/cairo/include/cairo)
WIN32_INCLUDE(${OPENFRAMEWORKS}/libs/glfw/include)
WIN32_INCLUDE(${OPENFRAMEWORKS}/libs/openFrameworks/sound)
WIN32_INCLUDE(${OPENFRAMEWORKS}/libs/fmodex/include)
WIN32_INCLUDE(${OPENFRAMEWORKS}/libs/openFrameworks/video)
WIN32_INCLUDE(${OPENFRAMEWORKS}/libs/videoInput/include)
WIN_DEBUG_LIB(${OPENFRAMEWORKS}/${OS}/lib/${DEBUG_DIR}/openFrameworks.lib)
WIN_RELEASE_LIB(${OPENFRAMEWORKS}/${OS}/lib/${RELEASE_DIR}/openFrameworks.lib)


### COMPILE ###
WIN_PATH(${OPENFRAMEWORKS}/${OS})
WIN32_COMMAND(${DKCMAKE_WIN32} -DOF_PATH=${OPENFRAMEWORKS} ${OPENFRAMEWORKS})
WIN64_COMMAND(${DKCMAKE_WIN64} -DOF_PATH=${OPENFRAMEWORKS} ${OPENFRAMEWORKS})
WIN_VS(${OPENFRAMEWORKS_NAME} openFrameworks.sln openFrameworks)
