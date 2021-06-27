### VERSION ###
DKSET(OPENFRAMEWORKS_VERSION 0.10.0)
DKSET(OPENFRAMEWORKS ${3RDPARTY}/openFrameworks-${OPENFRAMEWORKS_VERSION})


### INSTALL ###
## https://github.com/openframeworks/openFrameworks/archive/refs/tags/${OPENFRAMEWORKS_VERSION}.zip
## DKINSTALL(https://github.com/openframeworks/openFrameworks/archive/refs/tags/${OPENFRAMEWORKS_VERSION}.zip openFrameworks openFrameworks-${OPENFRAMEWORKS_VERSION}) ## find an online link
DKSET(OPENFRAMEWORKS ${3RDPARTY}/openFrameworks-${OPENFRAMEWORKS_VERSION})


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
WIN_DEBUG_LIB(${OPENFRAMEWORKS}/${OS}/lib/${DEBUG}/openFrameworks.lib)
WIN_RELEASE_LIB(${OPENFRAMEWORKS}/${OS}/lib/${RELEASE}/openFrameworks.lib)


### COMPILE ###
DKSETPATH(${OPENFRAMEWORKS}/${OS})
WIN32_COMMAND(${CMAKE_COMMAND} -G ${GENERATOR} -A Win32 "-DCMAKE_C_FLAGS=/DWIN32 /D_WINDOWS /W3 /nologo" "-DCMAKE_C_FLAGS_DEBUG=/MTd /Od /Ob0 /Zi /RTC1 /DDEBUG /D_DEBUG" "-DCMAKE_C_FLAGS_RELEASE=/MT /O2 /Ob2 /DNDEBUG" -DOF_PATH=${OPENFRAMEWORKS} ${OPENFRAMEWORKS})
WIN32_VS_DEBUG(openFrameworks-${OPENFRAMEWORKS_VERSION} openFrameworks.sln openFrameworks)
WIN32_VS_RELEASE(openFrameworks-${OPENFRAMEWORKS_VERSION} openFrameworks.sln openFrameworks)
