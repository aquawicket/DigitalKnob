# https://github.com/babel/babel)


#DKIMPORT(https://github.com/babel/babel.git)
DKIMPORT(https://unpkg.com/@babel/standalone@7.14.4/babel.min.js)


#DKSET(BABEL_VERSION 7.14.4)
#DKSET(BABEL_DL https://unpkg.com/@babel/standalone@7.14.4/babel.min.js)
#DKSET(BABEL_NAME babel-${BABEL_VERSION})
#DKSET(BABEL ${3RDPARTY}/${BABEL_NAME})
#DKINSTALL(${BABEL_DL} babel ${BABEL})
