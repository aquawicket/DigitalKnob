# https://docs.microsoft.com/en-us/java/openjdk/download
# https://jdk.java.net/archive/
#
# https://download.java.net/java/GA/jdk9/9.0.4/binaries/openjdk-9.0.4_windows-x64_bin.tar.gz
# https://download.java.net/java/GA/jdk9/9.0.4/binaries/openjdk-9.0.4_osx-x64_bin.tar.gz
# https://download.java.net/java/GA/jdk9/9.0.4/binaries/openjdk-9.0.4_linux-x64_bin.tar.gz

### VERSION ###
DKSET(JDK_VERSION 9.0.4)
if(WIN)
	DKSET(JDK_NAME openjdk-${JDK_VERSION}_windows-x64_bin)
	DKSET(JDK_DL https://download.java.net/java/GA/jdk9/${JDK_VERSION}/binaries/${JDK_NAME}.tar.gz)
endif()
if(MAC)
	DKSET(JDK_NAME openjdk-${JDK_VERSION}_osx-x64_bin)
	DKSET(JDK_DL https://download.java.net/java/GA/jdk9/${JDK_VERSION}/binaries/${JDK_NAME}.tar.gz)
endif()
if(LINUX)
	DKSET(JDK_NAME openjdk-${JDK_VERSION}_linux-x64_bin)
	DKSET(JDK_DL https://download.java.net/java/GA/jdk9/${JDK_VERSION}/binaries/${JDK_NAME}.tar.gz)
endif()
DKSET(JDK ${3RDPARTY}/${JDK_NAME})
DKSETENV("JAVA_HOME" ${JDK})
DKSETENV("VS_JavaHome" ${JDK})


### INSTALL ###
DKINSTALL(${JDK_DL} jdk ${JDK})

### LINK ###
DKINCLUDE(${JDK}/)	
	



