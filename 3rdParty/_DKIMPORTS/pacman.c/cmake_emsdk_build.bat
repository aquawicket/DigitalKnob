%dkbatch%

mkdir emscripten
cd emscripten
call C:\Users\Administrator\digitalknob\Development\3rdParty\emsdk-main\emsdk_env.bat
call cmake -G "MinGW Makefiles" -DCMAKE_TOOLCHAIN_FILE="C:/Users/Administrator/digitalknob/Development/3rdParty/emsdk-main/upstream/emscripten/cmake/Modules/Platform/Emscripten.cmake" ..
call cmake --build .
 
%DKEND% 
