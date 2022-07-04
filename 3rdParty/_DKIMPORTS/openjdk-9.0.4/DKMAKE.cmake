# https://docs.microsoft.com/en-us/java/openjdk/download
# https://jdk.java.net/archive/


WIN_HOST_dk_set(JDK9_VERSION 9.0.4)
WIN_HOST_dk_set(JDK9_DL https://download.java.net/java/GA/jdk9/9.0.4/binaries/openjdk-9.0.4_windows-x64_bin.tar.gz)

MAC_HOST_dk_set(JDK9_VERSION 9.0.4)
MAC_HOST_dk_set(JDK9_DL https://download.java.net/java/GA/jdk9/9.0.4/binaries/openjdk-9.0.4_osx-x64_bin.tar.gz)

LINUX_HOST_dk_set(JDK9_VERSION 9.0.4)
LINUX_HOST_dk_set(JDK9_DL https://download.java.net/java/GA/jdk9/9.0.4/binaries/openjdk-9.0.4_linux-x64_bin.tar.gz)


### INSTALL ###
dk_set(JDK9_NAME openjdk-${JDK9_VERSION})
dk_set(JDK9 ${3RDPARTY}/${JDK9_NAME})
#dk_import(${JDK9_DL} ${JDK9} PATCH)
dk_import(${JDK9_DL} ${JDK9} PATCH)


### LINK ###
#dk_include(${JDK9}/)	
#dk_setEnv("JAVA_HOME" ${JDK9})
#dk_setEnv("JAVA_VERSION" ${JDK9_VERSION})
#dk_setEnv("VS_JavaHome" ${JDK9})

#Add registry entries
#dk_addRegistryKey("HKLM/SOFTWARE/JavaSoft/Java Runtime Environment" "CurrentVersion" "${JDK9_VERSION}")
#dk_addRegistryKey("HKLM/SOFTWARE/JavaSoft/Java Runtime Environment/${JDK9_VERSION}" "JavaHome" "${JDK9}")
#dk_addRegistryKey("HKLM/SOFTWARE/JavaSoft/Java Runtime Environment/${JDK9_VERSION}" "RuntimeLib" "${JDK9}/bin/server/jvm.dll")