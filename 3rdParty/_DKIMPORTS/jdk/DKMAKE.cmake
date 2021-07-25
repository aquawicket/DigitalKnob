if(NOT ANDROID)
	return()
endif()

### VERSION ###
DKSET(JDK_VERSION 16.0.2_windows-x64_bin)
DKSET(JDK_NAME jdk-${JDK_VERSION})
DKSET(JDK ${3RDPARTY}/${JDK_NAME})


### INSTALL ###
DKINSTALL(https://download.oracle.com/otn-pub/java/jdk/16.0.2%2B7/d4a915d82b4c4fbb9bde534da945d746/jdk-16.0.2_windows-x64_bin.zip jdk ${JDK_NAME})