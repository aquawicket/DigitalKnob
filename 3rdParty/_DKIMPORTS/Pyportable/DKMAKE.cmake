# https://github.com/sganis/pyportable


### INSTALL ###
if(WIN_HOST)
	dk_set(PYTHON_EXE ${pyportable}/python.exe)
	
	WIN_HOST_dk_import(https://github.com/sganis/pyportable/releases/download/v2.7.10rc1/pyportable-2.7.10rc1.zip)

	if(NOT EXISTS ${pyportable}/Scripts/pip.exe)
		dk_executeProcess(${PYTHON_EXE} -m ensurepip)
	endif()

	dk_prependEnvPath("${pyportable}")
	
	dk_set(Python_INCLUDE_DIRS ${pyportable}/include)
	dk_debug(Python_INCLUDE_DIRS)
	
	dk_set(Python_LIBRARIES ${pyportable}/libs)
	dk_debug(Python_LIBRARIES)

endif()

#dk_debug(PYTHON_EXE)
#dk_command(${PYTHON_EXE} --version OUTPUT_VARIABLE PYTHON_VERSION ERROR_VARIABLE PYTHON_VERSION)
#dk_debug(PYTHON_VERSION)
DK_ASSERT_PATH(PYTHON_EXE)