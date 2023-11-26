# https://packages.ubuntu.com/focal/build-essential

if(NOT LINUX_HOST)
	dk_undepend(build-essential)
	dk_return()
endif()

dk_depend(openjdk)

dk_set(CURRENT_DIR /usr)
dk_command(sudo apt -y install build-essential)
