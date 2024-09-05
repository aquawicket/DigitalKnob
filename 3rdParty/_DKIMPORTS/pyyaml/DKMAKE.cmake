include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://github.com/yaml/pyyaml


dk_depend(python)
dk_depend(sudo)


### INSTALL ###
WIN_dk_executeProcess(${PYTHON}/Scripts/pip install PyYAML)
MAC_dk_executeProcess(pip install PyYAML)
LINUX_dk_executeProcess(${SUDO} apt-get -y install python python-yaml)
RASPBERRY_dk_executeProcess(${SUDO} apt-get -y install python python-yaml)

