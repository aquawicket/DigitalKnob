# https://docs.microsoft.com/en-us/java/openjdk/download
# https://jdk.java.net/archive/


WIN_HOST_DKSET(JDK8_VERSION 1.8.0_41)
WIN_HOST_DKSET(JDK8_DL https://download.java.net/openjdk/jdk8u41/ri/openjdk-8u41-b04-windows-i586-14_jan_2020.zip)

MAC_HOST_DKSET(JDK8_VERSION 1.8.0_41)
MAC_HOST_DKSET(JDK8_DL https://download.java.net/openjdk/jdk8u41/ri/openjdk-8u41-b04_osx-x64_14_jan_2020.tar.gz)

LINUX_HOST_DKSET(JDK8_VERSION 1.8.0_41)
LINUX_HOST_DKSET(JDK8_DL https://download.java.net/openjdk/jdk8u41/ri/openjdk-8u41-b04-linux-x64-14_jan_2020.tar.gz)


### INSTALL ###
DKSET(JDK8_NAME openjdk-${JDK8_VERSION})
DKSET(JDK8 ${3RDPARTY}/${JDK8_NAME})
DKINSTALL(${JDK8_DL} jdk8 ${JDK8})


### LINK ###
#DKINCLUDE(${JDK8}/)	
#DKSETENV("JAVA_HOME" ${JDK8})
#DKSETENV("JAVA_VERSION" ${JDK8_VERSION})
#DKSETENV("VS_JavaHome" ${JDK8})

#Add registry entries
#dk_addRegistryKey("HKLM/SOFTWARE/JavaSoft/Java Runtime Environment" "CurrentVersion" "${JDK8_VERSION}")
#dk_addRegistryKey("HKLM/SOFTWARE/JavaSoft/Java Runtime Environment/${JDK8_VERSION}" "JavaHome" "${JDK8}")
#dk_addRegistryKey("HKLM/SOFTWARE/JavaSoft/Java Runtime Environment/${JDK8_VERSION}" "RuntimeLib" "${JDK8}/bin/server/jvm.dll")