if(NOT CMAKE_HOST_WIN32)
	return()
endif()
if(NOT ANDROID)
	return()
endif()


### VERSION ####
DKSET(ANT_VERSION 1.9.16)
DKSET(ANT_NAME apache-ant-${ANT_VERSION})
DKSET(ANT ${3RDPARTY}/${ANT_NAME})
DKSETENV("ANT_HOME" ${ANT})


### INSTALL ###
## https://mirror.cogentco.com/pub/apache/ant/binaries/apache-ant-1.9.15-bin.zip
DKINSTALL(https://mirror.cogentco.com/pub/apache/ant/binaries/${ANT_NAME}-bin.zip apache-ant ${ANT_NAME})
