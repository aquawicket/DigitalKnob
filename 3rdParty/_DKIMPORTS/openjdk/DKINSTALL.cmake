#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


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

dk_validate(host_triple "dk_host_triple()")
dk_validate(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
dk_getFileParams("$ENV{DKIMPORTS_DIR}/openjdk/dkconfig.txt")

if(ANDROID_HOST)
	dk_installPackage(openjdk-17)
		
	dk_command(java --version)
endif()

if(LINUX_HOST)
	dk_installPackage(openjdk-11-jdk)
	
	dk_command(java --version)
endif()

if(MAC_HOST)
	if(NOT EXISTS /Library/Java/JavaVirtualMachines/jdk-11.jdk)
		dk_download(${OPENJDK_DL_MAC_X86_64} $ENV{DKDOWNLOAD_DIR}/openjdk-11_osx-x64_bin.tar.gz)
		dk_command(tar xf $ENV{DKDOWNLOAD_DIR}/openjdk-11_osx-x64_bin.tar.gz)
		
		dk_validate(SUDO_EXE "dk_depend(sudo)")
		dk_command(${SUDO_EXE} mv $ENV{DKDOWNLOAD_DIR}/jdk-11.jdk /Library/Java/JavaVirtualMachines/)
		dk_delete($ENV{DKDOWNLOAD_DIR}/openjdk-11_osx-x64_bin.tar.gz)
	endif()
	
	dk_command(java --version)
endif()

if(WIN_HOST)
	dk_import(${OPENJDK_DL_WIN_X86_64})
	dk_assertPath(OPENJDK)
	
	dk_set(JAVAC_EXE "${OPENJDK}/bin/javac.exe")

	###### JAVA_VERSION ######
	set(ENV{JAVA_VERSION} 11)
	
	###### JAVA_HOME ######
	dk_nativePath("${OPENJDK}" ENV{JAVA_HOME})
	
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
