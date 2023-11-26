## https://sourceforge.net/projects/threadpool/files/threadpool/0.2.5%20%28Stable%29/threadpool-0_2_5-src.zip/download


### DEPEND ###
dk_depend(boost boost_system)
dk_depend(boost boost_thread)


### IMPORT ###
dk_import(https://sourceforge.net/projects/threadpool/files/threadpool/0.2.5%20%28Stable%29/threadpool-0_2_5-src.zip)


### LINK ###
dk_include(${THREADPOOL})
