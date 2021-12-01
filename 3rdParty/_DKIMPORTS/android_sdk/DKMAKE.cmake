if(NOT CMAKE_HOST_WIN32)
	return()
endif()

### VERSION ###
DKSET(ANDROIDSDK ${3RDPARTY}/android_sdk)

DKSETENV("ANDROID_HOME" ${ANDROIDSDK})
DKSETENV("VS_AndroidHome" ${ANDROIDSDK})

### DEPENDS ###
DKDEPEND(jdk)
DKDEPEND(apache_ant)
DKDEPEND(android_ndk)
DKDEPEND(android_cmdline_tools)
DKDEPEND(android_platforms)
DKDEPEND(android_sources)
#DKDEPEND(android_system_images)
DKDEPEND(android_platform_tools)
DKDEPEND(android_build_tools)
