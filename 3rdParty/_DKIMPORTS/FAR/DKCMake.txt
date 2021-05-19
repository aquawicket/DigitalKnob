IF(NOT CMAKE_HOST_WIN32)
	RETURN()
ENDIF()

### VERSION ###
DKSET(FAR_VERSION 2.0.2)

### INSTALL ###
DKINSTALL(https://sourceforge.net/projects/findandreplace/files/findandreplace/${FAR_VERSION}/FAR-${FAR_VERSION}-win.zip FAR FAR-${FAR_VERSION}-win)
DKSET(FAR ${3RDPARTY}/far)