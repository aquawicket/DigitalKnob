#https://github.com/dtrebilco/glintercept
#
#https://github.com/dtrebilco/glintercept/releases/download/1.3.4/GLIntercept_1_3_4.exe

### VERSION ###
DKSET(GLINTERCEPT_VERSION 1_3_4)
DKSET(GLINTERCEPT_NAME GLIntercept_${GLINTERCEPT_VERSION}.exe)
WIN_DKSET(GLINTERCEPT_DL https://github.com/dtrebilco/glintercept/releases/download/1.3.4/${GLINTERCEPT_NAME})


DOWNLOAD(${GLINTERCEPT_DL} ${DKDOWNLOAD}/${GLINTERCEPT_NAME})
