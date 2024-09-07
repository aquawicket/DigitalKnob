include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_validate(HOST_TRIPLE "dk_getHostTriple()")
# https://docs.python.org/3/using/windows.html
# https://silentinstallhq.com/python-3-10-silent-install-how-to-guide/
# https://wiki.termux.com/wiki/Python


WIN_HOST_dk_set	(PYTHON3_DL https://www.python.org/ftp/python/3.11.8/python-3.11.8-embed-win32.zip)
MAC_HOST_dk_set (PYTHON3_DL ttps://www.python.org/ftp/python/3.11.8/python-3.11.8-macos11.pkg)


if(NOT EXISTS ${PYTHON3_EXE})
	ANDROID_HOST_dk_command(pkg install python -y)
	LINUX_HOST_dk_command(${SUDO} apt-get install python3)
	MAC_HOST_dk_import(${PYTHON3_DL})
	WIN_HOST_dk_import(${PYTHON3_DL})
	
	if(LINUX_HOST OR ANDROID_HOST)
		dk_findProgram(PYTHON3_EXE python)
	else()
		dk_assertPath(PYTHON3)
		dk_findProgram(PYTHON3_EXE python "${PYTHON3}")
	endif()
endif()


### 3RDPARTY LINK ###
dk_set(PYTHON3_CMAKE -DPython3_EXECUTABLE=${PYTHON3_EXE}) # -DPython3_Interpreter=${PYTHON3_EXE})



if(NOT EXISTS ${PYTHON3_EXE})
	dk_fatal("Could not find PYTHON3_EXE:${PYTHON3_EXE}")
endif()
