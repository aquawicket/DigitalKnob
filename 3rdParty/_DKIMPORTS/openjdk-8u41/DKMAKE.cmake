# https://docs.microsoft.com/en-us/java/openjdk/download
# https://jdk.java.net/archive/
# https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java8/java8u333/jdk/jdk-8u333-linux-i586.tar.gz
# https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java8/java8u333/jdk/jdk-8u333-linux-x64.tar.gz
# https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java8/java8u333/jdk/jdk-8u333-macosx-x64.dmg
# https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java8/java8u333/jdk/jdk-8u333-solaris-sparcv9.tar.gz
# https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java8/java8u333/jdk/jdk-8u333-windows-i586.zip
# https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java8/java8u333/jdk/jdk-8u333-windows-x64.zip

#dk_set(OPENJDK-8U41_VERSION 11)
WIN_HOST_dk_import	(https://download.java.net/openjdk/jdk8u41/ri/openjdk-8u41-b04-windows-i586-14_jan_2020.zip PATCH)
MAC_HOST_dk_import	(https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java8/java8u333/jdk/jdk-8u333-macosx-x64.dmg PATCH)
LINUX_HOST_dk_import(https://download.java.net/openjdk/jdk8u41/ri/openjdk-8u41-b04-linux-x64-14_jan_2020.tar.gz PATCH)


### LINK ###
#dk_include(${OPENJDK_8U41}/)	
#dk_setEnv("JAVA_HOME" ${OPENJDK_8U41})
#dk_setEnv("JAVA_VERSION" ${OPENJDK_8U41_VERSION})
#dk_setEnv("VS_JavaHome" ${OPENJDK_8U41})


#Add registry entries
#dk_addRegistryKey("HKLM/SOFTWARE/JavaSoft/Java Runtime Environment" "CurrentVersion" "${OPENJDK_8U41_VERSION}")
#dk_addRegistryKey("HKLM/SOFTWARE/JavaSoft/Java Runtime Environment/${OPENJDK_8U41_VERSION}" "JavaHome" "${OPENJDK_8U41}")
#dk_addRegistryKey("HKLM/SOFTWARE/JavaSoft/Java Runtime Environment/${OPENJDK_8U41_VERSION}" "RuntimeLib" "${OPENJDK_8U41}/bin/server/jvm.dll")