# https://github.com/gradle/gradle


DKGITCLONE(https://github.com/gradle/gradle.git)

#DKSET(GRADLE_VERSION 7.3-bin)
#DKSET(GRADLE_NAME gradle-${GRADLE_VERSION})
#DKSET(GRADLE_DL https://services.gradle.org/distributions/gradle-7.3-bin.zip)
#DKSET(GRADLE ${3RDPARTY}/${GRADLE_NAME})
#DKINSTALL(${GRADLE_DL} gradle ${GRADLE})
