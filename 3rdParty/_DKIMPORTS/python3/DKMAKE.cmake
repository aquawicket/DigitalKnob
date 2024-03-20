# https://docs.python.org/3/using/windows.html
# https://silentinstallhq.com/python-3-10-silent-install-how-to-guide/
# https://wiki.termux.com/wiki/Python

WIN_HOST_dk_import(https://www.python.org/ftp/python/3.11.8/python-3.11.8-embed-win32.zip)
WIN_HOST_dk_set	(PYTHON3_EXE ${PYTHON3}/python.exe)

if(ANDROID_HOST)
	dk_command(pkg install python -y)
endif()