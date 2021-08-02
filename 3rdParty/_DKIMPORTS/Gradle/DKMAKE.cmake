# Info
# https://github.com/gradle/gradle
#
# Source
# https://downloads.gradle-dn.com/distributions/gradle-7.1.1-all.zip


### VERSION ###
DKSET(GRADLE_VERSION 7.1.1-all)
DKSET(GRADLE ${3RDPARTY}/gradle-${GRADLE_NAME})
DKSET(GRADLE_DL https://downloads.gradle-dn.com/distributions/gradle-${GRADLE_VERSION}.zip)


### INSTALL ###
DKINSTALL(${GRADLE_DL} gradle ${GRADLE})