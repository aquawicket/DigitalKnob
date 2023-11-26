# https://github.com/openframeworks/openFrameworks
# https://github.com/openframeworks/openFrameworks/archive/refs/tags/0.10.0.zip
# https://github.com/openframeworks/openFrameworks/releases/download/0.11.2/of_v0.11.2_vs2017_release.zip  # WINDOWS


### DEPEND ###
dk_depend(glew)
dk_depend(opengl)
dk_depend(opengles)


### IMPORT ###
ANDROID_dk_import	(https://github.com/openframeworks/openFrameworks/releases/download/0.11.2/of_v0.11.2_android_release.tar.gz)
IOSSIM_dk_import	(https://github.com/openframeworks/openFrameworks/releases/download/0.11.2/of_v0.11.2_ios_release.zip)
IOS_dk_import		(https://github.com/openframeworks/openFrameworks/releases/download/0.11.2/of_v0.11.2_ios_release.zip)
LINUX_dk_import		(https://github.com/openframeworks/openFrameworks/releases/download/0.11.2/of_v0.11.2_linux64gcc6_release.tar.gz)
MAC_dk_import		(https://github.com/openframeworks/openFrameworks/releases/download/0.11.2/of_v0.11.2_osx_release.zip)
RASPBERRY_dk_import	(https://github.com/openframeworks/openFrameworks/releases/download/0.11.2/of_v0.11.2_linuxarmv6l_release.tar.gz)
WIN_dk_import		(https://github.com/openframeworks/openFrameworks/releases/download/0.11.2/of_v0.11.2_vs2017_release.zip PATCH)
#dk_import			(https://github.com/openframeworks/openFrameworks/archive/refs/tags/0.10.0.zip PATCH)
#dk_import			(https://github.com/openframeworks/openFrameworks.git PATCH)


### LINK ###
dk_include(${OPENFRAMEWORKS})
dk_include(${OPENFRAMEWORKS}/libs/cairo/include/cairo)
dk_include(${OPENFRAMEWORKS}/libs/fmodex/include)
dk_include(${OPENFRAMEWORKS}/libs/glew/include)
dk_include(${OPENFRAMEWORKS}/libs/glfw/include)
dk_include(${OPENFRAMEWORKS}/libs/glm/include)
dk_include(${OPENFRAMEWORKS}/libs/glu/include)
dk_include(${OPENFRAMEWORKS}/libs/json/include)
dk_include(${OPENFRAMEWORKS}/libs/openFrameworks)
dk_include(${OPENFRAMEWORKS}/libs/openFrameworks/3d)
dk_include(${OPENFRAMEWORKS}/libs/openFrameworks/app)
dk_include(${OPENFRAMEWORKS}/libs/openFrameworks/communication)
dk_include(${OPENFRAMEWORKS}/libs/openFrameworks/events)
dk_include(${OPENFRAMEWORKS}/libs/openFrameworks/gl)
dk_include(${OPENFRAMEWORKS}/libs/openFrameworks/graphics)
dk_include(${OPENFRAMEWORKS}/libs/openFrameworks/math)
dk_include(${OPENFRAMEWORKS}/libs/openFrameworks/sound)
dk_include(${OPENFRAMEWORKS}/libs/openFrameworks/types)
dk_include(${OPENFRAMEWORKS}/libs/openFrameworks/utils)
dk_include(${OPENFRAMEWORKS}/libs/openFrameworks/video)
dk_include(${OPENFRAMEWORKS}/libs/poco/include)
dk_include(${OPENFRAMEWORKS}/libs/tess2/include)
dk_include(${OPENFRAMEWORKS}/libs/utf8cpp/include)
dk_include(${OPENFRAMEWORKS}/libs/videoInput/include)
UNIX_dk_libDebug	(${OPENFRAMEWORKS}/${OS}/lib/${DEBUG_DIR}/libopenframeworks.a)
UNIX_dk_libRelease	(${OPENFRAMEWORKS}/${OS}/lib/${RELEASE_DIR}/libopenframeworks.a)
WIN_dk_libDebug		(${OPENFRAMEWORKS}/${OS}/lib/${DEBUG_DIR}/openFrameworks.lib)
WIN_dk_libRelease	(${OPENFRAMEWORKS}/${OS}/lib/${RELEASE_DIR}/openFrameworks.lib)


### GENERATE ###
dk_queueCommand(${DKCMAKE_BUILD} -DOF_PATH=${OPENFRAMEWORKS} ${OPENFRAMEWORKS})


### COMPILE ###
dk_build(${OPENFRAMEWORKS} openFrameworks)
