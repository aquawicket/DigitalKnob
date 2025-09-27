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


############ openjdk ############
# https://docs.microsoft.com/en-us/java/openjdk/download
# https://jdk.java.net/archive/
# https://download.java.net/java/ga/jdk11/openjdk-11_windows-x64_bin.zip
# https://download.java.net/openjdk/jdk11/ri/openjdk-11+28_osx-x64_bin.tar.gz
# https://download.java.net/openjdk/jdk11/ri/openjdk-11+28_linux-x64_bin.tar.gz
# https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java11/java110151/jdk-11.0.15.1_linux-x64_bin.tar.gz
# https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java11/java110151/jdk-11.0.15.1_osx-x64_bin.dmg
# https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java11/java110151/jdk-11.0.15.1_solaris-sparcv9_bin.tar.gz
# https://cfdownload.adobe.com/pub/adobe/coldfusion/java/java11/java110151/jdk-11.0.15.1_windows-x64_bin.zip
# https://gist.github.com/douglarek/bbda8cc23a562cb5d5798717d57bc9e9


dk_getFileParams("${CMAKE_CURRENT_LIST_DIR}/dkconfig.txt")
dk_validate(Host_Tuple "dk_Host_Tuple()")

if(Android_Host)
	dk_installPackage(openjdk-17)
	dk_exec(java --version)
endif()

if(Linux_Host)
	dk_installPackage(openjdk-11-jdk)
	dk_exec(java --version)
endif()

if(Mac_Host)
	if(NOT EXISTS /Library/Java/JavaVirtualMachines/jdk-11.jdk)
		dk_download(${openjdk_Mac_X86_64_Import})
		dk_exec(tar xf ${dk_download})
		dk_validate(sudo_exe "dk_depend(sudo_exe)")
		dk_exec(${sudo_exe} mv $ENV{DKDOWNLOAD_DIR}/jdk-11.jdk /Library/Java/JavaVirtualMachines/)
		dk_delete($ENV{DKDOWNLOAD_DIR}/openjdk-11_osx-x64_bin.tar.gz)
	endif()
	dk_exec(java --version)
endif()

if(Windows_Host)
	dk_import(${openjdk_Windows_X86_64_Import} IMPORT_PATH ${CMAKE_CURRENT_LIST_DIR})
	dk_assertPath(openjdk)
	dk_set(javac_exe "${openjdk}/bin/javac.exe")

	###### JAVA_VERSION ######
	set(ENV{JAVA_VERSION} 11)
	
	###### JAVA_HOME ######
	dk_nativePath("${openjdk}" ENV{JAVA_HOME})
	
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
