# https://github.com/dtrebilco/glintercept.git
# https://github.com/dtrebilco/glintercept/archive/e204189eff4045c24d48b82c93d4f012ed44e166.zip
# https://github.com/dtrebilco/glintercept/releases/download/1.3.4/GLIntercept_1_3_4.exe
if(NOT WIN_HOST)
	dk_undepend(glintercept)
	dk_return()
endif()


### IMPORT ###
#dk_import(https://github.com/dtrebilco/glintercept/archive/e204189eff4045c24d48b82c93d4f012ed44e166.zip)
#dk_import(https://github.com/dtrebilco/glintercept.git)
#dk_import(https://github.com/dtrebilco/glintercept/releases/download/1.3.4/GLIntercept_1_3_4.exe)
WIN_dk_set(GLINTERCEPT "${ProgramFiles_x86}/GLIntercept_1_3_4")
if(NOT EXISTS "${GLINTERCEPT}/unins000.exe")
	WIN_dk_download(https://github.com/dtrebilco/glintercept/releases/download/1.3.4/GLIntercept_1_3_4.exe ${DKDOWNLOAD_DIR}/GLIntercept_1_3_4.exe)
	WIN_dk_command(${DKDOWNLOAD_DIR}/GLIntercept_1_3_4.exe)
endif()
