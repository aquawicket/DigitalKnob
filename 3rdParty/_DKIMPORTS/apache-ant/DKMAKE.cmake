if(NOT CMAKE_HOST_WIN32)
	return()
endif()
if(NOT ANDROID)
	return()
endif()


### VERSION ####
DKSET(ANT_VERSION 1.9.15)
DKSET(ANT ${3RDPARTY}/apache-ant-${ANT_VERSION})


### INSTALL ###
## https://mirror.cogentco.com/pub/apache/ant/binaries/apache-ant-1.9.15-bin.zip
DKINSTALL(https://mirror.cogentco.com/pub/apache/ant/binaries/apache-ant-${ANT_VERSION}-bin.zip apache-ant apache-ant-${ANT_VERSION})
