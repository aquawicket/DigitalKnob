#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


# https://github.com/yaml/pyyaml


dk_depend(python)


dk_validate(host_triple "dk_host_triple()")

### INSTALL ###
if(WIN_HOST)
	dk_executeProcess(${PYTHON}/Scripts/pip install PyYAML)
elseif(MAC_HOST)
	dk_executeProcess(pip install PyYAML)
else()
	#LINUX_dk_executeProcess(${SUDO_EXE} apt-get -y install python python-yaml)
	#RASPBERRY_dk_executeProcess(${SUDO_EXE} apt-get -y install python python-yaml)
	dk_installPackage(python python-yaml)
endif()

