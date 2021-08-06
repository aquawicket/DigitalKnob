### VERSION ###
DKSET(BABEL_MAJOR 7)
DKSET(BABEL_MINOR 14)
DKSET(BABEL_BUILD 4)
DKSET(BABEL_VERSION ${BABEL_MAJOR}.${BABEL_MINOR}.${BABEL_BUILD})
DKSET(BABEL ${3RDPARTY}/babel)


### INSTALL ###
## https://unpkg.com/@babel/standalone@7.14.4/babel.min.js
DKINSTALL(https://unpkg.com/@babel/standalone@${BABEL_VERSION}/babel.min.js babel ${BABEL})
