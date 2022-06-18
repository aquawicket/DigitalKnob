if(NOT LINUX_HOST)
	return()
endif()

DKDEPEND(jdk)


dk_set(CURRENT_DIR /usr)
DKCOMMAND(sudo apt -y install build-essential)