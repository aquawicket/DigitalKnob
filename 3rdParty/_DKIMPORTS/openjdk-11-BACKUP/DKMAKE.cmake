# https://docs.microsoft.com/en-us/java/openjdk/download
# https://jdk.java.net/archive/
# https://download.java.net/java/ga/jdk11/openjdk-11_windows-x64_bin.zip
# https://download.java.net/openjdk/jdk11/ri/openjdk-11+28_osx-x64_bin.tar.gz
# https://download.java.net/openjdk/jdk11/ri/openjdk-11+28_linux-x64_bin.tar.gz
# https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java11/java110151/jdk-11.0.15.1_linux-x64_bin.tar.gz
# https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java11/java110151/jdk-11.0.15.1_osx-x64_bin.dmg
# https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java11/java110151/jdk-11.0.15.1_solaris-sparcv9_bin.tar.gz
# https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java11/java110151/jdk-11.0.15.1_windows-x64_bin.zip

#dk_set(OPENJDK-11_VERSION 11)

WIN_HOST_dk_import	(https://download.java.net/java/ga/jdk11/openjdk-11_windows-x64_bin.zip PATCH)
MAC_HOST_dk_import	(https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java11/java110151/jdk-11.0.15.1_osx-x64_bin.dmg PATCH)
LINUX_HOST_dk_import(https://download.java.net/openjdk/jdk11/ri/openjdk-11+28_linux-x64_bin.tar.gz PATCH)


### LINK ###
#dk_include(${OPENJDK-11}/)	
#dk_setEnv("JAVA_HOME" ${OPENJDK-11})
#dk_setEnv("JAVA_VERSION" ${OPENJDK-11_VERSION})
#dk_setEnv("VS_JavaHome" ${OPENJDK-11})

#Add registry entries
#dk_addRegistryKey("HKLM/SOFTWARE/JavaSoft/Java Runtime Environment" "CurrentVersion" "${OPENJDK-11_VERSION}")
#dk_addRegistryKey("HKLM/SOFTWARE/JavaSoft/Java Runtime Environment/${OPENJDK-11_VERSION}" "JavaHome" "${OPENJDK-11}")
#dk_addRegistryKey("HKLM/SOFTWARE/JavaSoft/Java Runtime Environment/${OPENJDK-11_VERSION}" "RuntimeLib" "${OPENJDK-11}/bin/server/jvm.dll")