# https://docs.python.org/3/using/windows.html
# https://silentinstallhq.com/python-3-10-silent-install-how-to-guide/


#dk_set			(PYTHON3_FOLDER python-3.11.2)
#dk_set			(PYTHON3 ${DK3RDPARTY_DIR}/${PYTHON3_FOLDER})
#WIN_HOST_dk_set	(PYTHON3_DL https://www.python.org/ftp/python/3.11.2/python-3.11.2-amd64.exe)
#WIN_HOST_dk_set (PYTHON3_DL https://www.python.org/ftp/python/3.11.8/python-3.11.8-embed-win32.zip)
#APPLE_dk_set	(PYTHON3_DL TODO)
WIN_HOST_dk_set	(PYTHON3_APP ${PYTHON3}/python.exe)


dk_import(https://www.python.org/ftp/python/3.11.8/python-3.11.8-embed-win32.zip)
WIN_HOST_dk_set	(PYTHON3_APP ${PYTHON3}/python.exe)

### INSTALL ###
#if(WIN_HOST)
#	dk_makeDirectory(${PYTHON3})
#	if(NOT EXISTS ${PYTHON3_APP})
#		#dk_download(${PYTHON3_DL} ${DKDOWNLOAD_DIR}/python-3.11.2-amd64.exe)
#		#dk_executeProcess(${DKDOWNLOAD_DIR}/python-3.11.2-amd64.exe)
#		#dk_executeProcess(${DKIMPORTS_DIR}/python3/install.cmd)
#	endif()
#endif()