# https://emscripten.org/index.html
# https://lyceum-allotments.github.io/2016/06/emscripten-and-sdl-2-tutorial-part-1/
# https://github.com/emscripten-core/emsdk/archive/refs/tags/2.0.26.zip


dk_import(https://github.com/emscripten-core/emsdk.git)


dk_command("${EMSCRIPTEN}/emsdk update")
dk_command(${EMSCRIPTEN}/emsdk install latest)
dk_command(${EMSCRIPTEN}/emsdk install activate latest)
dk_command(${EMSCRIPTEN}/emsdk_env.bat)