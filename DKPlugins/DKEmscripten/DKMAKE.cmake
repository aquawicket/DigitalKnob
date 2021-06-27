## https://emscripten.org/docs/getting_started/downloads.html

DKDEPEND(emsdk-portable)

##DKPLUGIN(DKEmscripten)
##DKASSETS(DKEmscripten)

DKSET(CURRENT_DIR ${DKPLUGINS}/DKEmscripten)
DKSET(QUEUE_BUILD ON)
##WIN32_COMMAND(${EMSCRIPTEN}/emscripten/1.37.33/emcc ${DKPLUGINS}/DKEmscripten/hello.c -o hello.html)

WIN32_COMMAND(${EMSCRIPTEN}/emscripten/1.37.33/emcc --bind -o test.js ${DKPLUGINS}/DKEmscripten/test.cpp)