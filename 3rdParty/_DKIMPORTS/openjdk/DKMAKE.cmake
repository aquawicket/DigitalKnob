include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
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

#dk_set(OPENJDK_11_VERSION 11)

WIN_HOST_dk_import	(https://download.java.net/java/ga/jdk11/openjdk-11_windows-x64_bin.zip) # PATCH)
#MAC_HOST_dk_import	(https://download.java.net/java/ga/jdk11/openjdk-11_osx-x64_bin.tar.gz PATCH)
#LINUX_HOST_dk_import(https://download.java.net/openjdk/jdk11/ri/openjdk-11+28_linux-x64_bin.tar.gz PATCH)

if(WIN_HOST)
	set(JAVA_VERSION 11)
	set(registerJDK11 ${OPENJDK_DIR}/registerJDK.cmd)

	dk_getNativePath("${OPENJDK_DIR}" OPENJDK_WINDIR)
	
	dk_fileWrite(${registerJDK11} "@echo off\n")
	dk_fileAppend(${registerJDK11} "set JAVA_VERSION=${JAVA_VERSION}\n")
	dk_fileAppend(${registerJDK11} "setx JAVA_VERSION ${JAVA_VERSION}\n")
	dk_fileAppend(${registerJDK11} "set JAVA_HOME=${OPENJDK_WINDIR}\n")
	dk_fileAppend(${registerJDK11} "setx JAVA_HOME ${OPENJDK_WINDIR}\n")
	dk_fileAppend(${registerJDK11} "setx VS_JavaHome ${OPENJDK_WINDIR}\n")
	dk_fileAppend(${registerJDK11} "setx STUDIO_JDK ${OPENJDK_WINDIR}\n")
	dk_fileAppend(${registerJDK11} "setx STUDIO_GRADLE_JDK ${OPENJDK_WINDIR}\n")
	dk_fileAppend(${registerJDK11} "reg add \"HKLM\\SOFTWARE\\JavaSoft\\Java Runtime Environment\" /v CurrentVersion /t REG_SZ /d ${JAVA_VERSION} /f\n")
	dk_fileAppend(${registerJDK11} "reg add \"HKLM\\SOFTWARE\\JavaSoft\\Java Runtime Environment\\${JAVA_VERSION}\" /v JavaHome /t REG_SZ /d \"${OPENJDK_WINDIR}\" /f\n")
	dk_fileAppend(${registerJDK11} "reg add \"HKLM\\SOFTWARE\\JavaSoft\\Java Runtime Environment\\${JAVA_VERSION}\" /v RuntimeLib /t REG_SZ /d \"${OPENJDK_WINDIR}\\bin\\server\\jvm.dll\" /f\n")
	dk_executeProcess(${registerJDK11})
	
	### Set Environment Variables ###
	dk_setEnv(JAVA_VERSION ${JAVA_VERSION})
	dk_setEnv(JAVA_HOME "${OPENJDK_8U41_WINPATH}")
	dk_setEnv(VS_JavaHome "${OPENJDK_8U41_WINPATH}")
	dk_setEnv(STUDIO_JDK "${OPENJDK_8U41_WINPATH}")
	dk_setEnv(STUDIO_GRADLE_JDK "${OPENJDK_8U41_WINPATH}")
endif()

# MAC Install
if(MAC_HOST)
	if(NOT EXISTS /Library/Java/JavaVirtualMachines/jdk-11.jdk)
		dk_download(https://download.java.net/java/ga/jdk11/openjdk-11_osx-x64_bin.tar.gz ${DKDOWNLOAD_DIR}/openjdk-11_osx-x64_bin.tar.gz)
		dk_command(tar xf ${DKDOWNLOAD_DIR}/openjdk-11_osx-x64_bin.tar.gz)
		dk_command(${SUDO} mv ${DKDOWNLOAD_DIR}/jdk-11.jdk /Library/Java/JavaVirtualMachines/)
		dk_delete(${DKDOWNLOAD_DIR}/openjdk-11_osx-x64_bin.tar.gz)
	endif()
	
	dk_command(java --version)
endif()

if(LINUX_HOST)
	#if(EXISTS /usr)
	#	dk_cd(/usr)
	#endif()
	
	#if(ANDROID_HOST)
	#	dk_set(SUDO "")
	#	dk_set(APT "apt")
	#else()
	#	dk_set(SUDO "sudo")
	#	dk_set(APT "apt-get")
	#endif()
	
	if(ANDROID_HOST)
		dk_command(pkg install openjdk-17 -y)
	else()
		dk_command(${SUDO} apt update)
		dk_command(${SUDO} apt -y install openjdk-11-jdk)
	endif()
	
	dk_command(java --version)
endif()



### LINK ###
#dk_include(${OPENJDK_11}/)	
#dk_setEnv("JAVA_HOME" ${OPENJDK_11})
#dk_setEnv("JAVA_VERSION" ${OPENJDK_11_VERSION})
#dk_setEnv("VS_JavaHome" ${OPENJDK_11})

#Add registry entries
#dk_registrySetKey("HKLM/SOFTWARE/JavaSoft/Java Runtime Environment" "CurrentVersion" "${OPENJDK_11_VERSION}")
#dk_registrySetKey("HKLM/SOFTWARE/JavaSoft/Java Runtime Environment/${OPENJDK_11_VERSION}" "JavaHome" "${OPENJDK_11}")
#dk_registrySetKey("HKLM/SOFTWARE/JavaSoft/Java Runtime Environment/${OPENJDK_11_VERSION}" "RuntimeLib" "${OPENJDK_11}/bin/server/jvm.dll")