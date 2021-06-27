### VERSION ###
DKSET(BABEL_MAJOR_VERSION 7)
DKSET(BABEL_MINOR_VERSION 14)
DKSET(BABEL_BUILD_VERSION 4)
DKSET(BABEL_VERSION ${BABEL_MAJOR_VERSION}.${BABEL_MINOR_VERSION}.${BABEL_BUILD_VERSION})
DKSET(BABEL ${3RDPARTY}/babel)


### INSTALL ###
## https://unpkg.com/@babel/standalone@7.14.4/babel.min.js
DKINSTALL(https://unpkg.com/@babel/standalone@${BABEL_VERSION}/babel.min.js babel babel)
