# https://github.com/dtrebilco/glintercept.git
# https://github.com/dtrebilco/glintercept/archive/e204189eff4045c24d48b82c93d4f012ed44e166.zip
# https://github.com/dtrebilco/glintercept/releases/download/1.3.4/GLIntercept_1_3_4.exe
if(NOT WIN_HOST)
	return()
endif()


### IMPORT ###
#dk_import(https://github.com/dtrebilco/glintercept/archive/e204189eff4045c24d48b82c93d4f012ed44e166.zip)
#dk_import(https://github.com/dtrebilco/glintercept.git)
#dk_import(https://github.com/dtrebilco/glintercept/releases/download/1.3.4/GLIntercept_1_3_4.exe)
dk_set(GLINTERCEPT "C:/Program Files (x86)/GLIntercept_1_3_4")
if(NOT EXISTS "${GLINTERCEPT}/unins000.exe")
	dk_download(https://github.com/dtrebilco/glintercept/releases/download/1.3.4/GLIntercept_1_3_4.exe ${DKDOWNLOAD}/GLIntercept_1_3_4.exe)
	dk_command(${DKDOWNLOAD}/GLIntercept_1_3_4.exe)
endif()
