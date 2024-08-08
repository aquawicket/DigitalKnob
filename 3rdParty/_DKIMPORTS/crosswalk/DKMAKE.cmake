include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# crosswalk


### DEPEND ###
#dk_depend(openjdk)
dk_depend(ant)
dk_depend(nodejs)


### INSTALL ###
WIN_dk_queueCommand("npm install -g crosswalk-app-tools")