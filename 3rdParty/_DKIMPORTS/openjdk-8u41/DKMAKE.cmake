#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://docs.microsoft.com/en-us/java/openjdk/download
# https://jdk.java.net/archive/
# https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java8/java8u333/jdk/jdk-8u333-linux-i586.tar.gz
# https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java8/java8u333/jdk/jdk-8u333-linux-x64.tar.gz
# https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java8/java8u333/jdk/jdk-8u333-macosx-x64.dmg
# https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java8/java8u333/jdk/jdk-8u333-solaris-sparcv9.tar.gz
# https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java8/java8u333/jdk/jdk-8u333-windows-i586.zip
# https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java8/java8u333/jdk/jdk-8u333-windows-x64.zip

WIN_HOST_dk_import	(https://download.java.net/openjdk/jdk8u41/ri/openjdk-8u41-b04-windows-i586-14_jan_2020.zip)
MAC_HOST_dk_import	(https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java8/java8u333/jdk/jdk-8u333-macosx-x64.dmg)
LINUX_HOST_dk_import(https://download.java.net/openjdk/jdk8u41/ri/openjdk-8u41-b04-linux-x64-14_jan_2020.tar.gz)


if(WIN_HOST)
	###### JAVA_VERSION ######
	set(ENV{JAVA_VERSION} 1.8.0_41)
	execute_process(COMMAND cmd /c setx JAVA_VERSION "$ENV{JAVA_VERSION}")
	
	###### JAVA_HOME ######
	set(ENV{JAVA_HOME} "${OPENJDK_8U41_DIR}")
	#dk_getNativePath("$ENV{JAVA_HOME}" ENV{JAVA_HOME})
	dk_replaceAll("$ENV{JAVA_HOME}" "/" "\\" ENV{JAVA_HOME})
	execute_process(COMMAND cmd /c setx JAVA_HOME "$ENV{JAVA_HOME}")
	
	###### VS_JavaHome ######
	set(ENV{VS_JavaHome} "$ENV{JAVA_HOME}")
	execute_process(COMMAND cmd /c setx VS_JavaHome "$ENV{VS_JavaHome}")
	
	###### STUDIO_JDK ######
	set(ENV{STUDIO_JDK} "$ENV{JAVA_HOME}")
	execute_process(COMMAND cmd /c setx STUDIO_JDK "$ENV{STUDIO_JDK}")
	
	###### STUDIO_GRADLE_JDK ######
	set(ENV{STUDIO_GRADLE_JDK} "$ENV{JAVA_HOME}")
	execute_process(COMMAND cmd /c setx STUDIO_GRADLE_JDK "$ENV{STUDIO_GRADLE_JDK}")
	
	
	###### registerJDK.cmd ######
	set(registerJDK8 ${OPENJDK_8U41_DIR}/registerJDK.cmd)
	dk_fileWrite(${registerJDK8} "@echo off\n")
	dk_fileAppend(${registerJDK8} "set JAVA_VERSION=$ENV{JAVA_VERSION}\n")
	dk_fileAppend(${registerJDK8} "setx JAVA_VERSION $ENV{JAVA_VERSION}\n")
	dk_fileAppend(${registerJDK8} "set JAVA_HOME=$ENV{JAVA_HOME}\n")
	dk_fileAppend(${registerJDK8} "setx JAVA_HOME $ENV{JAVA_HOME}\n")
	dk_fileAppend(${registerJDK8} "set VS_JavaHome=$ENV{VS_JavaHome}\n")
	dk_fileAppend(${registerJDK8} "setx VS_JavaHome $ENV{VS_JavaHome}\n")
	dk_fileAppend(${registerJDK8} "set STUDIO_JDK=$ENV{STUDIO_JDK}\n")
	dk_fileAppend(${registerJDK8} "setx STUDIO_JDK $ENV{STUDIO_JDK}\n")
	dk_fileAppend(${registerJDK8} "set STUDIO_GRADLE_JDK=$ENV{STUDIO_GRADLE_JDK}\n")
	dk_fileAppend(${registerJDK8} "setx STUDIO_GRADLE_JDK $ENV{STUDIO_GRADLE_JDK}\n")
	dk_fileAppend(${registerJDK8} "reg add \"HKLM\\SOFTWARE\\JavaSoft\\Java Runtime Environment\" /v CurrentVersion /t REG_SZ /d $ENV{JAVA_VERSION} /f\n")
	dk_fileAppend(${registerJDK8} "reg add \"HKLM\\SOFTWARE\\JavaSoft\\Java Runtime Environment\\$ENV{JAVA_VERSION}\" /v JavaHome /t REG_SZ /d \"$ENV{JAVA_HOME}\" /f\n")
	dk_fileAppend(${registerJDK8} "reg add \"HKLM\\SOFTWARE\\JavaSoft\\Java Runtime Environment\\$ENV{JAVA_VERSION}\" /v RuntimeLib /t REG_SZ /d \"$ENV{JAVA_HOME}\\bin\\server\\jvm.dll\" /f\n")
	dk_executeProcess(${registerJDK8})
endif()

### LINK ###
#dk_include(${OPENJDK_8U41}/)	
#dk_setEnv("JAVA_HOME" ${OPENJDK_8U41})
#dk_setEnv("JAVA_VERSION" ${OPENJDK_8U41_VERSION})
#dk_setEnv("VS_JavaHome" ${OPENJDK_8U41})


#Add registry entries
#dk_registrySetKey("HKLM/SOFTWARE/JavaSoft/Java Runtime Environment" "CurrentVersion" "${OPENJDK_8U41_VERSION}")
#dk_registrySetKey("HKLM/SOFTWARE/JavaSoft/Java Runtime Environment/${OPENJDK_8U41_VERSION}" "JavaHome" "${OPENJDK_8U41}")
#dk_registrySetKey("HKLM/SOFTWARE/JavaSoft/Java Runtime Environment/${OPENJDK_8U41_VERSION}" "RuntimeLib" "${OPENJDK_8U41}/bin/server/jvm.dll")