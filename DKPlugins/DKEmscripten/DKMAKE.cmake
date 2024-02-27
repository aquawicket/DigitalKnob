## https://emscripten.org/docs/getting_started/downloads.html

dk_depend(emsdk)

##dk_generateCmake(DKEmscripten)
##dk_assets(DKEmscripten)

dk_set(CURRENT_DIR ${DKPLUGINS}/DKEmscripten)
dk_set(QUEUE_BUILD ON)
##WIN_X86_dk_queueCommand(${EMSCRIPTEN}/emscripten/1.37.33/emcc ${DKPLUGINS}/DKEmscripten/hello.c -o hello.html)

if(EXISTS ${EMSCRIPTEN}/emscripten/1.37.33/emcc)
	WIN_X86_dk_queueCommand(${EMSCRIPTEN}/emscripten/1.37.33/emcc --bind -o test.js ${DKPLUGINS}/DKEmscripten/test.cpp)
endif()