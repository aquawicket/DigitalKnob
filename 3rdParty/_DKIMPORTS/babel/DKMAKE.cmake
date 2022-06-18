# https://github.com/babel/babel)


#dk_import(https://github.com/babel/babel.git)
dk_import(https://unpkg.com/@babel/standalone@7.14.4/babel.min.js)


#dk_set(BABEL_VERSION 7.14.4)
#dk_set(BABEL_DL https://unpkg.com/@babel/standalone@7.14.4/babel.min.js)
#dk_set(BABEL_NAME babel-${BABEL_VERSION})
#dk_set(BABEL ${3RDPARTY}/${BABEL_NAME})
#DKINSTALL(${BABEL_DL} babel ${BABEL})
