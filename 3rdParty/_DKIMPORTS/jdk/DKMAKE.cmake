if(NOT ANDROID)
	return()
endif()

### VERSION ###
DKSET(JDK_VERSION 16.0.2_windows-x64_bin)
DKSET(JDK_NAME jdk-${JDK_VERSION})
DKSET(JDK ${3RDPARTY}/${JDK_NAME})

DKINCUDE(${JDK}/)
### INSTALL ###
#https://download.oracle.com/otn-pub/java/jdk/16.0.2+7/d4a915d82b4c4fbb9bde534da945d746/jdk-16.0.2_windows-x64_bin.zip?AuthParam=1627218782_911dc8e4e20f52cfe841b45b81c95b6e
#https://download.oracle.com/otn-pub/java/jdk/16.0.2+7/d4a915d82b4c4fbb9bde534da945d746/jdk-16.0.2_windows-x64_bin.zip
DKINSTALL(https://download.oracle.com/otn-pub/java/jdk/16.0.2+7/d4a915d82b4c4fbb9bde534da945d746/jdk-16.0.2_windows-x64_bin.zip jdk ${JDK_NAME})

#https://javadl.oracle.com/webapps/download/AutoDL?BundleId=245044_d3c52aa6bfa54d3ca74e617f18309292

