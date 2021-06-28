## http://findandreplace.sourceforge.net/

IF(NOT CMAKE_HOST_WIN32)
	RETURN()
ENDIF()

### VERSION ###
DKSET(FAR_VERSION 2.0.2)

### INSTALL ###
## https://sourceforge.net/projects/findandreplace/files/latest/download
## https://sourceforge.net/projects/findandreplace/files/findandreplace/2.0.3/FAR-2.0.3-win.zip/download
## https://sourceforge.net/projects/findandreplace/files/findandreplace/2.0.3/FAR-2.0.3-osx.zip/download
## https://sourceforge.net/projects/findandreplace/files/findandreplace/2.0.3/FAR-2.0.3-x.tar.gz/download
## https://sourceforge.net/projects/findandreplace/files/findandreplace/2.0.3/FAR-2.0.3-sources.tar.gz/download
DKINSTALL(https://sourceforge.net/projects/findandreplace/files/findandreplace/${FAR_VERSION}/FAR-${FAR_VERSION}-win.zip FAR FAR-${FAR_VERSION}-win)
DKSET(FAR ${3RDPARTY}/far)