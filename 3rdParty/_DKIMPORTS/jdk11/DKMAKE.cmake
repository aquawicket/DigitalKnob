# https://docs.microsoft.com/en-us/java/openjdk/download
# https://jdk.java.net/archive/


WIN_HOST_dk_set(JDK11_VERSION 11)
WIN_HOST_dk_set(JDK11_DL https://download.java.net/java/ga/jdk11/openjdk-11_windows-x64_bin.zip)

MAC_HOST_dk_set(JDK11_VERSION 11)
MAC_HOST_dk_set(JDK11_DL https://download.java.net/openjdk/jdk11/ri/openjdk-11+28_osx-x64_bin.tar.gz)

LINUX_HOST_dk_set(JDK11_VERSION 11)
LINUX_HOST_dk_set(JDK11_DL https://download.java.net/openjdk/jdk11/ri/openjdk-11+28_linux-x64_bin.tar.gz)



### INSTALL ###
dk_set(JDK11_NAME openjdk-${JDK11_VERSION})
dk_set(JDK11 ${3RDPARTY}/${JDK11_NAME})
DKINSTALL(${JDK11_DL} jdk11 ${JDK11} PATCH)


### LINK ###
#DKINCLUDE(${JDK11}/)	
#DKSETENV("JAVA_HOME" ${JDK11})
#DKSETENV("JAVA_VERSION" ${JDK11_VERSION})
#DKSETENV("VS_JavaHome" ${JDK11})

#Add registry entries
#dk_addRegistryKey("HKLM/SOFTWARE/JavaSoft/Java Runtime Environment" "CurrentVersion" "${JDK11_VERSION}")
#dk_addRegistryKey("HKLM/SOFTWARE/JavaSoft/Java Runtime Environment/${JDK11_VERSION}" "JavaHome" "${JDK11}")
#dk_addRegistryKey("HKLM/SOFTWARE/JavaSoft/Java Runtime Environment/${JDK11_VERSION}" "RuntimeLib" "${JDK11}/bin/server/jvm.dll")