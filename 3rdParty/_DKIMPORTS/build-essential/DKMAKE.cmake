if(NOT LINUX_HOST)
	return()
endif()

dk_depend(jdk)


dk_set(CURRENT_DIR /usr)
dk_command(sudo apt -y install build-essential)