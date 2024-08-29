include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://github.com/yaml/pyyaml


### DEPENDS ###
dk_depend(python)


### INSTALL ###
WIN_TARGET_dk_executeProcess(${PYTHON}/Scripts/pip install PyYAML)
MAC_TARGET_dk_executeProcess(pip install PyYAML)
LINUX_TARGET_dk_executeProcess(sudo apt-get -y install python python-yaml)
RASPBERRY_TARGET_dk_executeProcess(sudo apt-get -y install python python-yaml)
