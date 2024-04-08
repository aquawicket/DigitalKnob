# https://docs.python.org/3/using/windows.html
# https://silentinstallhq.com/python-3-10-silent-install-how-to-guide/
# https://wiki.termux.com/wiki/Python


WIN_HOST_dk_set	(PYTHON_DL https://www.python.org/ftp/python/3.11.8/python-3.11.8-embed-win32.zip)
MAC_HOST_dk_set (PYTHON_DL ttps://www.python.org/ftp/python/3.11.8/python-3.11.8-macos11.pkg)


dk_find_program(PYTHON3_EXE python ${PYTHON3})

if(NOT EXISTS ${PYTHON3_EXE})
	ANDROID_HOST_dk_command(pkg install python -y)
	WIN_HOST_dk_import(${PYTHON_DL})
	MAC_HOST_dk_import(${PYTHON_DL})
	
	dk_find_program(PYTHON3_EXE python ${PYTHON3})
endif()



