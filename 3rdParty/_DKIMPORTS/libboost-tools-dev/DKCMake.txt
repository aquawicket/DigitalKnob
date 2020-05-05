IF(NOT LINUX)
	RETURN()
ENDIF()

### INSTALL ###
DKSET(QUEUE_BUILD ON)
DKSET(CURRENT_DIR /usr)
LINUX_COMMAND(sudo apt-get update -y)
LINUX_COMMAND(sudo apt-get install -y libboost-tools-dev)
