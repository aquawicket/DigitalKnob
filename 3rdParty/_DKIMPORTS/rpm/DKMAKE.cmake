include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://www.thegeekdiary.com/rpm-command-not-found

if(NOT LINUX_HOST OR ANDROID_HOST)
	dk_undepend(rpm)
	dk_return()
endif()

### INSTALL ###
dk_set(WORKING_DIRECTORY /usr)
dk_command(sudo apt -y install rpm)
