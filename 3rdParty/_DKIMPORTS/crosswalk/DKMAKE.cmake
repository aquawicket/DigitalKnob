### DEPENDS ###
#dk_depend(jdk)
dk_depend(ant)
dk_depend(nodejs)


### INSTALL ###
WIN_dk_queueCommand("npm install -g crosswalk-app-tools")