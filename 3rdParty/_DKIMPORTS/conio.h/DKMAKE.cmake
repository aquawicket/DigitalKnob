# https://github.com/nowres/conio-for-linux
#
# https://github.com/nowres/conio-for-linux/archive/refs/heads/master.zip

### DEPENDS ###
DKDEPEND(ncurses)


### VERSION ###
DKSET(CONIO_VERSION master)
DKSET(CONIO_NAME conio-${CONIO_VERSION})
DKSET(CONIO_DL https://github.com/nowres/conio-for-linux/archive/refs/heads/${CONIO_VERSION}.zip)
DKSET(CONIO ${3RDPARTY}/${CONIO_NAME})


### INSTALL ###
DKINSTALL(${CONIO_DL} conio.h ${CONIO})


### LINK ###
DKINCLUDE(${CONIO})
