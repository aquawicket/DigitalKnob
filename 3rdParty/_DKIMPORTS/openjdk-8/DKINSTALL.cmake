#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ openjdk-8 ############
# https://docs.microsoft.com/en-us/java/openjdk/download
# https://jdk.java.net/archive/
# https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java8/java8u333/jdk/jdk-8u333-linux-i586.tar.gz
# https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java8/java8u333/jdk/jdk-8u333-linux-x64.tar.gz
# https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java8/java8u333/jdk/jdk-8u333-macosx-x64.dmg
# https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java8/java8u333/jdk/jdk-8u333-solaris-sparcv9.tar.gz
# https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java8/java8u333/jdk/jdk-8u333-windows-i586.zip
# https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java8/java8u333/jdk/jdk-8u333-windows-x64.zip

dk_validate(Host_Tuple "dk_Host_Tuple()")
if(Win_Host)
	dk_import	(https://download.java.net/openjdk/jdk8u41/ri/openjdk-8u41-b04-windows-i586-14_jan_2020.zip)
endif()
if(Mac_Host)
	dk_import	(https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java8/java8u333/jdk/jdk-8u333-macosx-x64.dmg)
endif()
if(Linux_Host)
	dk_import	(https://download.java.net/openjdk/jdk8u41/ri/openjdk-8u41-b04-linux-x64-14_jan_2020.tar.gz)
endif()


if(Win_Host)
	###### JAVA_VERSION ######
	set(ENV{JAVA_VERSION} 1.8.0_41)
	
	###### JAVA_HOME ######
	dk_nativePath("${OPENJDK_8_DIR}" ENV{JAVA_HOME})
	
	###### JAVA Registry ######
	dk_validate(CMD_EXE "dk_CMD_EXE()")
	execute_process(COMMAND ${CMD_EXE} /c reg add "HKLM\\SOFTWARE\\JavaSoft\\Java Runtime Environment" /v CurrentVersion /t REG_SZ /d "$ENV{JAVA_VERSION}" /f)
	execute_process(COMMAND ${CMD_EXE} /c reg add "HKLM\\SOFTWARE\\JavaSoft\\Java Runtime Environment\\$ENV{JAVA_VERSION}" /v JavaHome /t REG_SZ /d "$ENV{JAVA_HOME}" /f)
	execute_process(COMMAND ${CMD_EXE} /c reg add "HKLM\\SOFTWARE\\JavaSoft\\Java Runtime Environment\\$ENV{JAVA_VERSION}" /v RuntimeLib /t REG_SZ /d "$ENV{JAVA_HOME}\\bin\\server\\jvm.dll" /f)

	###### VS_JavaHome ######
#	set(ENV{VS_JavaHome} "$ENV{JAVA_HOME}")
#	execute_process(COMMAND ${CMD_EXE} /c setx VS_JavaHome "$ENV{VS_JavaHome}")
	
	###### STUDIO_JDK ######
#	set(ENV{STUDIO_JDK} "$ENV{JAVA_HOME}")
#	execute_process(COMMAND ${CMD_EXE} /c setx STUDIO_JDK "$ENV{STUDIO_JDK}")
	
	###### STUDIO_GRADLE_JDK ######
#	set(ENV{STUDIO_GRADLE_JDK} "$ENV{JAVA_HOME}")
#	execute_process(COMMAND ${CMD_EXE} /c setx STUDIO_GRADLE_JDK "$ENV{STUDIO_GRADLE_JDK}")	
endif()
