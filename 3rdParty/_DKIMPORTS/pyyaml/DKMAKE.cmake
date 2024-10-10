#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
dk_load(dk_builder)
# https://github.com/yaml/pyyaml


dk_depend(python)



### INSTALL ###
WIN_dk_executeProcess(${PYTHON}/Scripts/pip install PyYAML)
MAC_dk_executeProcess(pip install PyYAML)
#dk_depend(sudo)
#LINUX_dk_executeProcess(${SUDO_EXE} apt-get -y install python python-yaml)
#RASPBERRY_dk_executeProcess(${SUDO_EXE} apt-get -y install python python-yaml)
dk_installPackage(python python-yaml)

