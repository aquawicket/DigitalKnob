# https://docs.microsoft.com/en-us/java/openjdk/download
# https://jdk.java.net/archive/
#
# https://download.java.net/java/GA/jdk9/9.0.4/binaries/openjdk-9.0.4_windows-x64_bin.tar.gz
# https://download.java.net/java/GA/jdk9/9.0.4/binaries/openjdk-9.0.4_osx-x64_bin.tar.gz
# https://download.java.net/java/GA/jdk9/9.0.4/binaries/openjdk-9.0.4_linux-x64_bin.tar.gz

# https://download.java.net/openjdk/jdk8u41/ri/openjdk-8u41-b04-windows-i586-14_jan_2020.zip


### VERSION ###
DKSET(JDK_VERSION 9.0.4)
DKSET(JDK_NAME openjdk-${JDK_VERSION}_windows-x64_bin)
WIN_HOST_DKSET(JDK_DL https://download.java.net/java/GA/jdk9/${JDK_VERSION}/binaries/${JDK_NAME}.tar.gz)


#DKSET(JDK_VERSION 8u41-b04)
#WIN_HOST_DKSET(JDK_DL https://download.java.net/openjdk/jdk8u41/ri/openjdk-8u41-b04-windows-i586-14_jan_2020.zip)



MAC_HOST_DKSET(JDK_NAME openjdk-${JDK_VERSION}_osx-x64_bin)
MAC_HOST_DKSET(JDK_DL https://download.java.net/java/GA/jdk9/${JDK_VERSION}/binaries/${JDK_NAME}.tar.gz)

LINUX_HOST_DKSET(JDK_NAME openjdk-${JDK_VERSION}_linux-x64_bin)
LINUX_HOST_DKSET(JDK_DL https://download.java.net/java/GA/jdk9/${JDK_VERSION}/binaries/${JDK_NAME}.tar.gz)


### INSTALL ###
DKSET(JDK ${3RDPARTY}/${JDK_NAME})
DKINSTALL(${JDK_DL} jdk ${JDK})

### LINK ###
DKINCLUDE(${JDK}/)	
DKSETENV("JAVA_HOME" ${JDK})
DKSETENV("VS_JavaHome" ${JDK})
