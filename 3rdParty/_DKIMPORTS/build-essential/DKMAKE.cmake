# https://packages.ubuntu.com/focal/build-essential

#if(NOT LINUX_HOST)
#	dk_undepend(build-essential)
#	dk_return()
#endif()

#dk_depend(openjdk)

if(ANDROID_HOST)
	dk_command(pkg install build-essential)
elseif(NOT ANDROID)
	dk_set(CURRENT_DIR /usr)
	dk_command(sudo apt -y install build-essential)
endif()

dk_todo("tiny-core-lunux build-essential")