# https://docs.microsoft.com/en-us/java/openjdk/download
# https://jdk.java.net/archive/
#
# https://download.java.net/java/ga/jdk11/openjdk-11_windows-x64_bin.zip
# https://github.com/AdoptOpenJDK/openjdk11-upstream-binaries/releases/download/jdk-11.0.13%2B8/OpenJDK11U-jdk_x64_windows_11.0.13_8.zip

### VERSION ###

WIN_HOST_DKSET(JDK11_VERSION 11)
WIN_HOST_DKSET(JDK11_DL https://download.java.net/java/ga/jdk11/openjdk-11_windows-x64_bin.zip)


### INSTALL ###
DKSET(JDK11_NAME openjdk-${JDK11_VERSION})
DKSET(JDK11 ${3RDPARTY}/${JDK11_NAME})
DKINSTALL(${JDK11_DL} jdk11 ${JDK11})


### LINK ###
#DKINCLUDE(${JDK11}/)	
#DKSETENV("JAVA_HOME" ${JDK11})
#DKSETENV("JAVA_VERSION" ${JDK11_VERSION})
#DKSETENV("VS_JavaHome" ${JDK11})

#Add registry entries
#dk_addRegistryKey("HKLM/SOFTWARE/JavaSoft/Java Runtime Environment" "CurrentVersion" "${JDK11_VERSION}")
#dk_addRegistryKey("HKLM/SOFTWARE/JavaSoft/Java Runtime Environment/${JDK11_VERSION}" "JavaHome" "${JDK11}")
#dk_addRegistryKey("HKLM/SOFTWARE/JavaSoft/Java Runtime Environment/${JDK11_VERSION}" "RuntimeLib" "${JDK11}/bin/server/jvm.dll")