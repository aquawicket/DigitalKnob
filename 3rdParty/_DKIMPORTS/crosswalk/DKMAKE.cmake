if(NOT ANDROID)
	return()
endif()


### DEPENDS ###
DKDEPEND(jdk)
DKDEPEND(apache-ant)
DKDEPEND(nodeJS)


### INSTALL ###
WIN32_COMMAND("npm install -g crosswalk-app-tools")