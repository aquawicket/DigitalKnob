include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# https://terminator-gtk3.readthedocs.io/en/latest/


#LINUX_HOST_dk_cd(/usr)
LINUX_HOST_dk_command(sudo apt -y install terminator) #FIXME sudo needed
MAC_HOST_dk_command(brew install terminator)
