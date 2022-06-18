## https://sourceforge.net/projects/threadpool/files/threadpool/0.2.5%20%28Stable%29/threadpool-0_2_5-src.zip/download


DKDEPEND(boost boost_system)
DKDEPEND(boost boost_thread)


dk_import(https://sourceforge.net/projects/threadpool/files/threadpool/0.2.5%20%28Stable%29/threadpool-0_2_5-src.zip)


#dk_set(THREADPOOL_VERSION 0_2_5-src)
#dk_set(THREADPOOL_DL https://sourceforge.net/projects/threadpool/files/threadpool/0.2.5%20%28Stable%29/threadpool-0_2_5-src.zip)
#dk_set(THREADPOOL ${3RDPARTY}/threadpool-${THREADPOOL_VERSION})
#DKINSTALL(${THREADPOOL_DL} threadpool ${THREADPOOL})


### LINK ###
DKINCLUDE(${THREADPOOL})
