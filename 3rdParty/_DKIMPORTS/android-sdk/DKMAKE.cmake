if(NOT WIN_HOST)
	return()
endif()

### VERSION ###
dk_set(ANDROID-SDK ${3RDPARTY}/android-sdk)

dk_setEnv("ANDROID_HOME" ${ANDROID-SDK})
dk_setEnv("VS_AndroidHome" ${ANDROID-SDK})

### DEPENDS ###
#dk_depend(jdk)
#dk_depend(jdk8)
#dk_depend(jdk9)
#dk_depend(ant)
#dk_depend(android-cmdline-tools)
#dk_depend(android-ndk)
#dk_depend(android-platforms)
#dk_depend(android-sources)
#dk_depend(android-system-images)
#dk_depend(android-platform-tools)
#dk_depend(android-build-tools)
#dk_depend(android-sdk-tools)
#dk_depend(android-cmake)

if(WIN_HOST)
	if(NOT EXISTS ${ANDROID-SDK}/SignLicenses.cmd)
		dk_copy(${DKIMPORTS}/android-sdk/SignLicenses.cmd ${ANDROID-SDK}/SignLicenses.cmd OVERWRITE)
		dk_command(${ANDROID-SDK}/SignLicenses.cmd)
	endif()
endif()
