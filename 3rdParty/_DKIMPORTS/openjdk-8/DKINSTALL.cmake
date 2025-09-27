#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


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
if(Windows_Host)
	dk_import	(https://download.java.net/openjdk/jdk8u41/ri/openjdk-8u41-b04-windows-i586-14_jan_2020.zip)
endif()
if(Mac_Host)
	dk_import	(https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java8/java8u333/jdk/jdk-8u333-macosx-x64.dmg)
endif()
if(Linux_Host)
	dk_import	(https://download.java.net/openjdk/jdk8u41/ri/openjdk-8u41-b04-linux-x64-14_jan_2020.tar.gz)
endif()


if(Windows_Host)
	###### JAVA_VERSION ######
	set(ENV{JAVA_VERSION} 1.8.0_41)
	
	###### JAVA_HOME ######
	dk_nativePath("${openjdk-8}" ENV{JAVA_HOME})
	
	###### JAVA Registry ######
	dk_validate(cmd_exe "dk_depend(cmd_exe)")
	execute_process(COMMAND ${cmd_exe} /c reg add "HKLM\\SOFTWARE\\JavaSoft\\Java Runtime Environment" /v CurrentVersion /t REG_SZ /d "$ENV{JAVA_VERSION}" /f)
	execute_process(COMMAND ${cmd_exe} /c reg add "HKLM\\SOFTWARE\\JavaSoft\\Java Runtime Environment\\$ENV{JAVA_VERSION}" /v JavaHome /t REG_SZ /d "$ENV{JAVA_HOME}" /f)
	execute_process(COMMAND ${cmd_exe} /c reg add "HKLM\\SOFTWARE\\JavaSoft\\Java Runtime Environment\\$ENV{JAVA_VERSION}" /v RuntimeLib /t REG_SZ /d "$ENV{JAVA_HOME}\\bin\\server\\jvm.dll" /f)

	###### VS_JavaHome ######
#	set(ENV{VS_JavaHome} "$ENV{JAVA_HOME}")
#	execute_process(COMMAND ${cmd_exe} /c setx VS_JavaHome "$ENV{VS_JavaHome}")
	
	###### STUDIO_JDK ######
#	set(ENV{STUDIO_JDK} "$ENV{JAVA_HOME}")
#	execute_process(COMMAND ${cmd_exe} /c setx STUDIO_JDK "$ENV{STUDIO_JDK}")
	
	###### STUDIO_GRADLE_JDK ######
#	set(ENV{STUDIO_GRADLE_JDK} "$ENV{JAVA_HOME}")
#	execute_process(COMMAND ${cmd_exe} /c setx STUDIO_GRADLE_JDK "$ENV{STUDIO_GRADLE_JDK}")	
endif()
