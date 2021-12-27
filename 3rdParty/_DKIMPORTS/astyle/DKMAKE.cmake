# http://astyle.sourceforge.net/
#
# https://sourceforge.net/projects/astyle/files/latest/download
# https://managedway.dl.sourceforge.net/project/astyle/astyle/astyle%203.1/AStyle_3.1_windows.zip


### VERSION ###
DKSET(ASTYLE_VERSION 3.1)
DKSET(ASTYLE_NAME AStyle_${ASTYLE_VERSION}_windows)
DKSET(ASTYLE_DL https://sourceforge.net/projects/astyle/files/astyle/astyle%203.1/AStyle_3.1_windows.zip)
DKSET(ASTYLE ${3RDPARTY}/${ASTYLE_NAME})


### INSTALL ###
DKINSTALL(${ASTYLE_DL} astyle ${ASTYLE})
