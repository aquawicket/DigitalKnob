# https://codemirror.net/codemirror.zip

### VERSION ###
DKSET(CODEMIRROR_VERSION 5.60.0)
DKSET(CODEMIRROR_NAME codemirror-${CODEMIRROR_VERSION})
DKSET(CODEMIRROR_DL https://codemirror.net/codemirror.zip)
DKSET(CODEMIRROR ${3RDPARTY}/${CODEMIRROR_NAME})

### INSTALL ###
DKINSTALL(${CODEMIRROR_DL} codemirror ${CODEMIRROR})
