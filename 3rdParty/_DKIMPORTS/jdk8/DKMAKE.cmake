# https://docs.microsoft.com/en-us/java/openjdk/download
# https://jdk.java.net/archive/


WIN_HOST_dk_set(JDK8_VERSION 1.8.0_41)
WIN_HOST_dk_set(JDK8_DL https://download.java.net/openjdk/jdk8u41/ri/openjdk-8u41-b04-windows-i586-14_jan_2020.zip)

MAC_HOST_dk_set(JDK8_VERSION 1.8.0_41)
MAC_HOST_dk_set(JDK8_DL https://download.java.net/openjdk/jdk8u41/ri/openjdk-8u41-b04_osx-x64_14_jan_2020.tar.gz)

LINUX_HOST_dk_set(JDK8_VERSION 1.8.0_41)
LINUX_HOST_dk_set(JDK8_DL https://download.java.net/openjdk/jdk8u41/ri/openjdk-8u41-b04-linux-x64-14_jan_2020.tar.gz)


### INSTALL ###
dk_set(JDK8_NAME openjdk-${JDK8_VERSION})
dk_set(JDK8 ${3RDPARTY}/${JDK8_NAME})
dk_install(${JDK8_DL} ${JDK8} PATCH)


### LINK ###
#dk_include(${JDK8}/)	
#dk_setEnv("JAVA_HOME" ${JDK8})
#dk_setEnv("JAVA_VERSION" ${JDK8_VERSION})
#dk_setEnv("VS_JavaHome" ${JDK8})

#Add registry entries
#dk_addRegistryKey("HKLM/SOFTWARE/JavaSoft/Java Runtime Environment" "CurrentVersion" "${JDK8_VERSION}")
#dk_addRegistryKey("HKLM/SOFTWARE/JavaSoft/Java Runtime Environment/${JDK8_VERSION}" "JavaHome" "${JDK8}")
#dk_addRegistryKey("HKLM/SOFTWARE/JavaSoft/Java Runtime Environment/${JDK8_VERSION}" "RuntimeLib" "${JDK8}/bin/server/jvm.dll")