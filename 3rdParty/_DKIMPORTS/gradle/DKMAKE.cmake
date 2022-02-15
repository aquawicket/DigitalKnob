# Info
# https://github.com/gradle/gradle
#
# Source
# https://services.gradle.org/distributions/gradle-7.3-bin.zip


### VERSION ###
DKSET(GRADLE_VERSION 7.3-bin)
DKSET(GRADLE_NAME gradle-${GRADLE_VERSION})
DKSET(GRADLE_DL https://services.gradle.org/distributions/gradle-7.3-bin.zip)
DKSET(GRADLE ${3RDPARTY}/${GRADLE_NAME})


### INSTALL ###
DKINSTALL(${GRADLE_DL} gradle ${GRADLE})
