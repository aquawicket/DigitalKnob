# https://docs.microsoft.com/en-us/java/openjdk/download
# https://jdk.java.net/archive/


dk_set(JDK11_VERSION 11)

WIN_HOST_dk_import(https://download.java.net/java/ga/jdk11/openjdk-11_windows-x64_bin.zip PATCH)
MAC_HOST_dk_import(JDK11_DL https://download.java.net/openjdk/jdk11/ri/openjdk-11+28_osx-x64_bin.tar.gz PATCH)
LINUX_HOST_dk_import(JDK11_DL https://download.java.net/openjdk/jdk11/ri/openjdk-11+28_linux-x64_bin.tar.gz PATCH)


### LINK ###
#dk_include(${JDK11}/)	
#dk_setEnv("JAVA_HOME" ${JDK11})
#dk_setEnv("JAVA_VERSION" ${JDK11_VERSION})
#dk_setEnv("VS_JavaHome" ${JDK11})

#Add registry entries
#dk_addRegistryKey("HKLM/SOFTWARE/JavaSoft/Java Runtime Environment" "CurrentVersion" "${JDK11_VERSION}")
#dk_addRegistryKey("HKLM/SOFTWARE/JavaSoft/Java Runtime Environment/${JDK11_VERSION}" "JavaHome" "${JDK11}")
#dk_addRegistryKey("HKLM/SOFTWARE/JavaSoft/Java Runtime Environment/${JDK11_VERSION}" "RuntimeLib" "${JDK11}/bin/server/jvm.dll")