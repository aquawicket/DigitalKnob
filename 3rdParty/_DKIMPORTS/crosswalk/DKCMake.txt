IF(NOT ANDROID)
	RETURN()
ENDIF()


### DEPENDS ###
DKDEPEND(jdk)
DKDEPEND(apache-ant)
DKDEPEND(nodeJS)


### INSTALL ###
WIN32_COMMAND("npm install -g crosswalk-app-tools")