# https://docs.microsoft.com/en-us/java/openjdk/download
# https://jdk.java.net/archive/
#
# https://download.java.net/openjdk/jdk8u41/ri/openjdk-8u41-b04-windows-i586-14_jan_2020.zip
# https://github.com/AdoptOpenJDK/openjdk8-upstream-binaries/releases/download/jdk8u312-b07/OpenJDK8U-jdk_x64_windows_8u312b07.zip


### VERSION ###
WIN_HOST_DKSET(JDK8_VERSION 8u41)
WIN_HOST_DKSET(JDK8_DL https://download.java.net/openjdk/jdk8u41/ri/openjdk-8u41-b04-windows-i586-14_jan_2020.zip)


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