# https://invisible-island.net/ncurses/ncurses.html
#
# https://invisible-island.net/datafiles/release/ncurses.tar.gz

### DEPENDS ###
#DKDEPEND(libname)


### VERSION ###
DKSET(NCURSES_VERSION 6.2)
DKSET(NCURSES_NAME ncurses-${NCURSES_VERSION})
DKSET(NCURSES_DL https://invisible-island.net/datafiles/release/ncurses.tar.gz)
DKSET(NCURSES ${3RDPARTY}/${NCURSES_NAME})


### INSTALL ###
DKINSTALL(${NCURSES_DL} ncurses ${NCURSES})


### LINK ###
DKINCLUDE(${NCURSES}/include)
DKINCLUDE(${NCURSES}/${OS})
LINUX_DEBUG_LIB(${NCURSES}/${OS}/${DEBUG_DIR}/ncursesd.a)
LINUX_RELEASE_LIB(${NCURSES}/${OS}/${RELEASE_DIR}/ncurses.a)



LINUX_DEBUG_PATH(${NCURSES}/${OS}/${DEBUG_DIR})
LINUX_DEBUG_COMMAND(../../configure --disable-shared --enable-static)
LINUX_DEBUG_COMMAND(make)

LINUX_RELEASE_PATH(${NCURSES}/${OS}/${RELEASE_DIR})
LINUX_RELEASE_COMMAND(../../configure --disable-shared --enable-static)
LINUX_RELEASE_COMMAND(make)
