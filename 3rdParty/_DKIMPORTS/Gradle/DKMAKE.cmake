### VERSION ###
DKSET(GRADLE_VERSION 7.1.1-all)
DKSET(GRADLE_NAME gradle-${GRADLE_VERSION})
DKSET(GRADLE ${3RDPARTY}/${GRADLE_NAME})
#DKSET(GRADLE_EXE "C:/gradle.exe")


### INSTALL ###
# https://downloads.gradle-dn.com/distributions/gradle-7.1.1-all.zip
DKINSTALL(https://downloads.gradle-dn.com/distributions/gradle-7.1.1-all.zip Gradle ${GRADLE_NAME})