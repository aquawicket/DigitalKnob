# https://emscripten.org/index.html
# https://lyceum-allotments.github.io/2016/06/emscripten-and-sdl-2-tutorial-part-1/
#
# https://github.com/emscripten-core/emsdk/archive/refs/tags/2.0.26.zip

DKSET(EMSCRIPTEN_VERSION 2.0.26)
DKSET(EMSCRIPTEN_NAME emsdk-${EMSCRIPTEN_VERSION})
DKSET(EMSCRIPTEN_DL https://github.com/emscripten-core/emsdk/archive/refs/tags/${EMSCRIPTEN_VERSION}.zip)
DKSET(EMSCRIPTEN ${3RDPARTY}/${EMSCRIPTEN_NAME})

### INSTALL ###
DKINSTALL(${EMSCRIPTEN_DL} emsdk ${EMSCRIPTEN})

DKCOMMAND(${EMSCRIPTEN}/emsdk update)
DKCOMMAND(${EMSCRIPTEN}/emsdk install latest)
DKCOMMAND(${EMSCRIPTEN}/emsdk install activate latest)
DKCOMMAND(${EMSCRIPTEN}/emsdk_env.bat)