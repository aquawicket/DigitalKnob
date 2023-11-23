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

#dk_set(OPENJDK-11_VERSION 11)

WIN_HOST_dk_import	(https://download.java.net/java/ga/jdk11/openjdk-11_windows-x64_bin.zip PATCH)
#MAC_HOST_dk_import	(https://download.java.net/java/ga/jdk11/openjdk-11_osx-x64_bin.tar.gz PATCH)
#LINUX_HOST_dk_import(https://download.java.net/openjdk/jdk11/ri/openjdk-11+28_linux-x64_bin.tar.gz PATCH)

# MAC Install
if(MAC_HOST)
	if(NOT EXISTS /Library/Java/JavaVirtualMachines/jdk-11.jdk)
		dk_download(https://download.java.net/java/ga/jdk11/openjdk-11_osx-x64_bin.tar.gz ${DKDOWNLOAD}/openjdk-11_osx-x64_bin.tar.gz)
		dk_command(tar xf ${DKDOWNLOAD}/openjdk-11_osx-x64_bin.tar.gz)
		dk_command(sudo mv ${DKDOWNLOAD}/jdk-11.jdk /Library/Java/JavaVirtualMachines/)
		dk_remove(${DKDOWNLOAD}/openjdk-11_osx-x64_bin.tar.gz NOERROR)
		#dk_command(java -version)
	endif()
endif()

# LINUX Install
if(LINUX_HOST)
	dk_set(CURRENT_DIR /usr)
	
	if(ANDROID_HOST)
		dk_set(SUDO "")
		dk_set(APT "apt")
	else()
		dk_set(SUDO "sudo")
		dk_set(APT "apt-get")
	endif()
	
	if(ANDROID_HOST)
		dk_command(pkg install openjdk-17)	# ANDROID install
	else()
		dk_command(${SUDO} ${APT} update)
		dk_command(${SUDO} apt -y install openjdk-11-jdk)
	endif()
	#dk_command(java -version)
endif()


### LINK ###
#dk_include(${OPENJDK-11}/)	
#dk_setEnv("JAVA_HOME" ${OPENJDK-11})
#dk_setEnv("JAVA_VERSION" ${OPENJDK-11_VERSION})
#dk_setEnv("VS_JavaHome" ${OPENJDK-11})

#Add registry entries
#dk_addRegistryKey("HKLM/SOFTWARE/JavaSoft/Java Runtime Environment" "CurrentVersion" "${OPENJDK-11_VERSION}")
#dk_addRegistryKey("HKLM/SOFTWARE/JavaSoft/Java Runtime Environment/${OPENJDK-11_VERSION}" "JavaHome" "${OPENJDK-11}")
#dk_addRegistryKey("HKLM/SOFTWARE/JavaSoft/Java Runtime Environment/${OPENJDK-11_VERSION}" "RuntimeLib" "${OPENJDK-11}/bin/server/jvm.dll")