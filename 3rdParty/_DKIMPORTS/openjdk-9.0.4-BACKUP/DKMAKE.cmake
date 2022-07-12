# https://docs.microsoft.com/en-us/java/openjdk/download
# https://jdk.java.net/archive/

#dk_set(OPENJDK-9_VERSION 9.0.4)

WIN_HOST_dk_import(https://download.java.net/java/GA/jdk9/9.0.4/binaries/openjdk-9.0.4_windows-x64_bin.tar.gz PATCH)
MAC_HOST_dk_import(https://download.java.net/java/GA/jdk9/9.0.4/binaries/openjdk-9.0.4_osx-x64_bin.tar.gz PATCH)
LINUX_HOST_dk_import(https://download.java.net/java/GA/jdk9/9.0.4/binaries/openjdk-9.0.4_linux-x64_bin.tar.gz PATCH)

### LINK ###
#dk_include(${OPENJDK-9}/)	
#dk_setEnv("JAVA_HOME" ${OPENJDK-9})
#dk_setEnv("JAVA_VERSION" ${OPENJDK-9_VERSION})
#dk_setEnv("VS_JavaHome" ${OPENJDK-9})

#Add registry entries
#dk_addRegistryKey("HKLM/SOFTWARE/JavaSoft/Java Runtime Environment" "CurrentVersion" "${OPENJDK-9_VERSION}")
#dk_addRegistryKey("HKLM/SOFTWARE/JavaSoft/Java Runtime Environment/${OPENJDK-9_VERSION}" "JavaHome" "${OPENJDK-9}")
#dk_addRegistryKey("HKLM/SOFTWARE/JavaSoft/Java Runtime Environment/${OPENJDK-9_VERSION}" "RuntimeLib" "${OPENJDK-9}/bin/server/jvm.dll")