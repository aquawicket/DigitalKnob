#https://jdk.java.net/archive/

if(NOT ANDROID)
	return()
endif()

### VERSION ###
DKSET(JDK_VERSION 9.0.4_windows-x64_bin)
DKSET(JDK_NAME openjdk-${JDK_VERSION})
DKSET(JDK ${3RDPARTY}/${JDK_NAME})

DKINCLUDE(${JDK}/)
### INSTALL ###
#https://download.java.net/java/GA/jdk9/9.0.4/binaries/openjdk-9.0.4_windows-x64_bin.tar.gz
DKINSTALL(https://download.java.net/java/GA/jdk9/9.0.4/binaries/${JDK_NAME}.tar.gz jdk ${JDK_NAME})


#https://download.oracle.com/otn-pub/java/jdk/16.0.2+7/d4a915d82b4c4fbb9bde534da945d746/jdk-16.0.2_windows-x64_bin.zip?AuthParam=1627218782_911dc8e4e20f52cfe841b45b81c95b6e
#https://download.oracle.com/otn-pub/java/jdk/16.0.2+7/d4a915d82b4c4fbb9bde534da945d746/jdk-16.0.2_windows-x64_bin.zip
#https://javadl.oracle.com/webapps/download/AutoDL?BundleId=245044_d3c52aa6bfa54d3ca74e617f18309292

