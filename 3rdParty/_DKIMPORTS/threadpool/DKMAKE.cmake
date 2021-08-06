DKDEPEND(boost Boost_Thread)

### VERSION ###
DKSET(THREADPOOL_MAJOR 0)
DKSET(THREADPOOL_MINOR 2)
DKSET(THREADPOOL_BUILD 5)
DKSET(THREADPOOL_VERSION 0_2_5-src)
DKSET(THREADPOOL ${3RDPARTY}/threadpool-${THREADPOOL_VERSION})


### INSTALL ###
## https://sourceforge.net/projects/threadpool/files/threadpool/0.2.5%20%28Stable%29/threadpool-0_2_5-src.zip/download
DKINSTALL(https://sourceforge.net/projects/threadpool/files/threadpool/${THREADPOOL_MAJOR}.${THREADPOOL_MINOR}.${THREADPOOL_BUILD}%20%28Stable%29/threadpool-${THREADPOOL_VERSION}.zip threadpool ${THREADPOOL})


### LINK ###
DKINCLUDE(${THREADPOOL})
