# https://docs.microsoft.com/en-us/java/openjdk/download
# https://jdk.java.net/archive/
# https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java8/java8u333/jdk/jdk-8u333-linux-i586.tar.gz
# https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java8/java8u333/jdk/jdk-8u333-linux-x64.tar.gz
# https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java8/java8u333/jdk/jdk-8u333-macosx-x64.dmg
# https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java8/java8u333/jdk/jdk-8u333-solaris-sparcv9.tar.gz
# https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java8/java8u333/jdk/jdk-8u333-windows-i586.zip
# https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java8/java8u333/jdk/jdk-8u333-windows-x64.zip

WIN_HOST_dk_import	(https://download.java.net/openjdk/jdk8u41/ri/openjdk-8u41-b04-windows-i586-14_jan_2020.zip) # PATCH)
MAC_HOST_dk_import	(https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java8/java8u333/jdk/jdk-8u333-macosx-x64.dmg) # PATCH)
LINUX_HOST_dk_import(https://download.java.net/openjdk/jdk8u41/ri/openjdk-8u41-b04-linux-x64-14_jan_2020.tar.gz) # PATCH)


# Create registerJDK.cmd and run it
if(WIN_HOST)
	set(JAVA_VERSION 1.8.0_41)
	set(registerJDK ${OPENJDK_8U41}/registerJDK.cmd)
	string(REPLACE "/" "\\" OPENJDK_8U41_WINPATH "${OPENJDK_8U41}")
	
	file(WRITE ${registerJDK} "@echo off\n")
	file(APPEND ${registerJDK} "set JAVA_VERSION=${JAVA_VERSION}\n")
	file(APPEND ${registerJDK} "setx JAVA_VERSION ${JAVA_VERSION}\n")
	file(APPEND ${registerJDK} "set JAVA_HOME=${OPENJDK_8U41_WINPATH}\n")
	file(APPEND ${registerJDK} "setx JAVA_HOME ${OPENJDK_8U41_WINPATH}\n")
	file(APPEND ${registerJDK} "setx VS_JavaHome ${OPENJDK_8U41_WINPATH}\n")
	file(APPEND ${registerJDK} "setx STUDIO_JDK ${OPENJDK_8U41_WINPATH}\n")
	file(APPEND ${registerJDK} "setx STUDIO_GRADLE_JDK ${OPENJDK_8U41_WINPATH}\n")
	file(APPEND ${registerJDK} "reg add \"HKLM\\SOFTWARE\\JavaSoft\\Java Runtime Environment\" /v CurrentVersion /t REG_SZ /d ${JAVA_VERSION} /f\n")
	file(APPEND ${registerJDK} "reg add \"HKLM\\SOFTWARE\\JavaSoft\\Java Runtime Environment\\${JAVA_VERSION}\" /v JavaHome /t REG_SZ /d \"${OPENJDK_8U41_WINPATH}\" /f\n")
	file(APPEND ${registerJDK} "reg add \"HKLM\\SOFTWARE\\JavaSoft\\Java Runtime Environment\\${JAVA_VERSION}\" /v RuntimeLib /t REG_SZ /d \"${OPENJDK_8U41_WINPATH}\\bin\\server\\jvm.dll\" /f\n")
	dk_executeProcess(${registerJDK})
	
	### Set Environment Variables ###
	#dk_setEnv(JAVA_VERSION ${JAVA_VERSION})
	#dk_setEnv(JAVA_HOME ${JAVA_HOME})
	#dk_setEnv(VS_JavaHome ${JAVA_HOME})
	#dk_setEnv(STUDIO_JDK ${JAVA_HOME})
	#dk_setEnv(STUDIO_GRADLE_JDK ${JAVA_HOME})
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