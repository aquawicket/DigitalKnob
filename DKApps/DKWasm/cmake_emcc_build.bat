%dkbatch%

mkdir emscripten
cd emscripten
call C:\Users\Administrator\digitalknob\DK\3rdParty\emsdk-main\emsdk_env.bat
call emcmake cmake -G "MinGW Makefiles" ..
call cmake --build .
copy dkwasm.* C:\Users\Administrator\digitalknob\DK\DKApps\DKWasm\assets\
cd C:\Users\Administrator\digitalknob\DK\DKApps\DKWasm\assets\DKPhp
call RunPhpServers.bat
call rundll32 url.dll,FileProtocolHandler http://127.0.0.1:2393/dkwasm.html
 
%DKEND% 
