include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://www.gnu.org/software/ddd/
# https://ftp.gnu.org/gnu/ddd/ddd-3.3.12.tar.gz


### IMPORT ###
#dk_import(https://ftp.gnu.org/gnu/ddd/ddd-3.3.12.tar.gz)


# TODO
# sudo apt-get install ddd
dk_depend(sudo)
LINUX_HOST_dk_command(${SUDO} apt -y install ddd)
