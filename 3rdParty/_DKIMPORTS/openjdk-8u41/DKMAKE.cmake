# https://docs.microsoft.com/en-us/java/openjdk/download
# https://jdk.java.net/archive/
# https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java8/java8u333/jdk/jdk-8u333-linux-i586.tar.gz
# https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java8/java8u333/jdk/jdk-8u333-linux-x64.tar.gz
# https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java8/java8u333/jdk/jdk-8u333-macosx-x64.dmg
# https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java8/java8u333/jdk/jdk-8u333-solaris-sparcv9.tar.gz
# https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java8/java8u333/jdk/jdk-8u333-windows-i586.zip
# https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java8/java8u333/jdk/jdk-8u333-windows-x64.zip

#dk_set(OPENJDK_8U41_VERSION 11)
WIN_HOST_dk_import	(https://download.java.net/openjdk/jdk8u41/ri/openjdk-8u41-b04-windows-i586-14_jan_2020.zip PATCH)
MAC_HOST_dk_import	(https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java8/java8u333/jdk/jdk-8u333-macosx-x64.dmg PATCH)
LINUX_HOST_dk_import(https://download.java.net/openjdk/jdk8u41/ri/openjdk-8u41-b04-linux-x64-14_jan_2020.tar.gz PATCH)


# Create registerJDK.cmd and run it
if(WIN_HOST)
	file(WRITE ${OPENJDK_8U41}/registerJDK2.cmd "@echo off")
	file(WRITE ${OPENJDK_8U41}/registerJDK2.cmd "set \"Folder=openjdk-8u41-b04-windows-i586-14_jan_2020\"")
	file(WRITE ${OPENJDK_8U41}/registerJDK2.cmd "set \"CurrentVersion=1.8.0_41\"")
	file(WRITE ${OPENJDK_8U41}/registerJDK2.cmd "set \"JAVA_VERSION=%CurrentVersion%\"")
	file(WRITE ${OPENJDK_8U41}/registerJDK2.cmd "setx JAVA_VERSION %CurrentVersion%")
	file(WRITE ${OPENJDK_8U41}/registerJDK2.cmd "set \"JAVA_HOME=%HOMEDRIVE%%HOMEPATH%\digitalknob\Development\3rdParty\%Folder%\"")
	file(WRITE ${OPENJDK_8U41}/registerJDK2.cmd "setx JAVA_HOME %JAVA_HOME%")
	file(WRITE ${OPENJDK_8U41}/registerJDK2.cmd "setx VS_JavaHome %JAVA_HOME%")
	file(WRITE ${OPENJDK_8U41}/registerJDK2.cmd "setx STUDIO_JDK %JAVA_HOME%")
	file(WRITE ${OPENJDK_8U41}/registerJDK2.cmd "setx STUDIO_GRADLE_JDK %JAVA_HOME%")
	file(WRITE ${OPENJDK_8U41}/registerJDK2.cmd "reg add \"HKLM\SOFTWARE\JavaSoft\Java Runtime Environment\" /v CurrentVersion /t REG_SZ /d %CurrentVersion% /f")
	file(WRITE ${OPENJDK_8U41}/registerJDK2.cmd "reg add \"HKLM\SOFTWARE\JavaSoft\Java Runtime Environment\%CurrentVersion%\" /v JavaHome /t REG_SZ /d \"%JAVA_HOME%\" /f")
	file(WRITE ${OPENJDK_8U41}/registerJDK2.cmd "reg add \"HKLM\SOFTWARE\JavaSoft\Java Runtime Environment\%CurrentVersion%\" /v RuntimeLib /t REG_SZ /d \"%JAVA_HOME%\bin\server\jvm.dll\" /f")
	dk_executeProcess(${OPENJDK_8U41}/registerJDK2.cmd)
endif()

### LINK ###
#dk_include(${OPENJDK_8U41}/)	
#dk_setEnv("JAVA_HOME" ${OPENJDK_8U41})
#dk_setEnv("JAVA_VERSION" ${OPENJDK_8U41_VERSION})
#dk_setEnv("VS_JavaHome" ${OPENJDK_8U41})


#Add registry entries
#dk_addRegistryKey("HKLM/SOFTWARE/JavaSoft/Java Runtime Environment" "CurrentVersion" "${OPENJDK_8U41_VERSION}")
#dk_addRegistryKey("HKLM/SOFTWARE/JavaSoft/Java Runtime Environment/${OPENJDK_8U41_VERSION}" "JavaHome" "${OPENJDK_8U41}")
#dk_addRegistryKey("HKLM/SOFTWARE/JavaSoft/Java Runtime Environment/${OPENJDK_8U41_VERSION}" "RuntimeLib" "${OPENJDK_8U41}/bin/server/jvm.dll")