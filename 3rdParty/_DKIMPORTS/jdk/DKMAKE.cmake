# https://docs.microsoft.com/en-us/java/openjdk/download
# https://jdk.java.net/archive/
#
# https://download.java.net/java/GA/jdk9/9.0.4/binaries/openjdk-9.0.4_windows-x64_bin.tar.gz
# https://download.java.net/java/GA/jdk9/9.0.4/binaries/openjdk-9.0.4_osx-x64_bin.tar.gz
# https://download.java.net/java/GA/jdk9/9.0.4/binaries/openjdk-9.0.4_linux-x64_bin.tar.gz
# https://download.java.net/openjdk/jdk8u41/ri/openjdk-8u41-b04-windows-i586-14_jan_2020.zip
# https://download.java.net/java/ga/jdk11/openjdk-11_windows-x64_bin.zip


### VERSION ###
#WIN_HOST_DKSET(JDK_VERSION 1.8.0_41)
#WIN_HOST_DKSET(JDK_DL https://download.java.net/openjdk/jdk8u41/ri/openjdk-8u41-b04-windows-i586-14_jan_2020.zip)

WIN_HOST_DKSET(JDK_VERSION 9.0.4)
WIN_HOST_DKSET(JDK_DL https://download.java.net/java/GA/jdk9/9.0.4/binaries/openjdk-9.0.4_windows-x64_bin.tar.gz)

#WIN_HOST_DKSET(JDK_VERSION 11)
#WIN_HOST_DKSET(JDK_DL https://download.java.net/java/ga/jdk11/openjdk-11_windows-x64_bin.zip)


MAC_HOST_DKSET(JDK_VERSION 9.0.4)
MAC_HOST_DKSET(JDK_DL https://download.java.net/java/GA/jdk9/9.0.4/binaries/openjdk-9.0.4_osx-x64_bin.tar.gz)


LINUX_HOST_DKSET(JDK_VERSION 9.0.4)
LINUX_HOST_DKSET(JDK_DL https://download.java.net/java/GA/jdk9/9.0.4/binaries/openjdk-9.0.4_linux-x64_bin.tar.gz)



### INSTALL ###
DKSET(JDK_NAME openjdk-${JDK_VERSION})
DKSET(JDK ${3RDPARTY}/${JDK_NAME})
DKINSTALL(${JDK_DL} jdk ${JDK})


### LINK ###
DKINCLUDE(${JDK}/)	
DKSETENV("JAVA_HOME" ${JDK})
DKSETENV("JAVA_VERSION" ${JDK_VERSION})
DKSETENV("VS_JavaHome" ${JDK})

#Add registry entries
dk_addRegistryKey("HKLM/SOFTWARE/JavaSoft/Java Runtime Environment" "CurrentVersion" "${JDK_VERSION}")
dk_addRegistryKey("HKLM/SOFTWARE/JavaSoft/Java Runtime Environment/${JDK_VERSION}" "JavaHome" "${JDK}")
dk_addRegistryKey("HKLM/SOFTWARE/JavaSoft/Java Runtime Environment/${JDK_VERSION}" "RuntimeLib" "${JDK}/bin/server/jvm.dll")