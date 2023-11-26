# https://github.com/yaml/pyyaml


### DEPENDS ###
dk_depend(python)


### INSTALL ###
WIN_dk_executeProcess(${PYTHON}/Scripts/pip install PyYAML)
MAC_dk_executeProcess(pip install PyYAML)
LINUX_dk_executeProcess(sudo apt-get -y install python python-yaml)
RASPBERRY_dk_executeProcess(sudo apt-get -y install python python-yaml)
