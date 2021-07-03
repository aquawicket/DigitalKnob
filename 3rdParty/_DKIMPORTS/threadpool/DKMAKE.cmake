DKDEPEND(boost Boost_Thread)

### VERSION ###
DKSET(THREADPOOL_MAJOR_VERSION 0)
DKSET(THREADPOOL_MINOR_VERSION 2)
DKSET(THREADPOOL_BUILD_VERSION 5)
DKSET(THREADPOOL_VERSION 0_2_5-src)
DKSET(THREADPOOL ${3RDPARTY}/threadpool-${THREADPOOL_VERSION})


### INSTALL ###
## https://sourceforge.net/projects/threadpool/files/threadpool/0.2.5%20%28Stable%29/threadpool-0_2_5-src.zip/download
DKINSTALL(https://sourceforge.net/projects/threadpool/files/threadpool/${THREADPOOL_MAJOR_VERSION}.${THREADPOOL_MINOR_VERSION}.${THREADPOOL_BUILD_VERSION}%20%28Stable%29/threadpool-${THREADPOOL_VERSION}.zip threadpool threadpool-${THREADPOOL_VERSION})


### LINK ###
DKINCLUDE(${THREADPOOL})
