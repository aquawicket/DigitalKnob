# https://sdlc-esd.oracle.com/ESD6/JSCDL/jdk/8u301-b09/d3c52aa6bfa54d3ca74e617f18309292/JavaSetup8u301.exe?GroupName=JSC&FilePath=/ESD6/JSCDL/jdk/8u301-b09/d3c52aa6bfa54d3ca74e617f18309292/JavaSetup8u301.exe&BHost=javadl.sun.com&File=JavaSetup8u301.exe&AuthParam=1631595554_b0fa00f07e68f1cdcb5673520c5a64e3&ext=.exe
# https://javadl.oracle.com/webapps/download/AutoDL?BundleId=245029_d3c52aa6bfa54d3ca74e617f18309292
# https://javadl.oracle.com/webapps/download/AutoDL?BundleId=245058_d3c52aa6bfa54d3ca74e617f18309292
# https://sdlc-esd.oracle.com/ESD6/JSCDL/jdk/8u301-b09/d3c52aa6bfa54d3ca74e617f18309292/jre-8u301-windows-i586.exe?GroupName=JSC&FilePath=/ESD6/JSCDL/jdk/8u301-b09/d3c52aa6bfa54d3ca74e617f18309292/jre-8u301-windows-i586.exe&BHost=javadl.sun.com&File=jre-8u301-windows-i586.exe&AuthParam=1631595621_2291054da58bdda192ed0500e141024c&ext=.exe

### VERSION ###
#DKSET(JAVA_VERSION ???)
#DKSET(JAVA_NAME java-${JDK_VERSION})
#DKSET(JAVA_DL https://us.softpedia-secure-download.com/dl/b98e1543ee54316ef787e417cb87ac67/61a84020/400123332/mac/System-Utilities/jre-8u311-macosx-x64.dmg)
#DKSET(JAVA ${3RDPARTY}/${JAVA_NAME})


### INSTALL ###
#DKINSTALL(${JAVA_DL} JAVA ${JAVA})
