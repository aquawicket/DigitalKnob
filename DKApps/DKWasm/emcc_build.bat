%dkbatch%

call C:\Users\Administrator\digitalknob\DK\3rdParty\emsdk-main\emsdk_env.bat
call emcc -v main.cpp -o C:\Users\Administrator\digitalknob\DK\DKApps\DKWasm\assets\DKWasm.html
cd C:\Users\Administrator\digitalknob\DK\DKApps\DKWasm\assets\DKPhp
call RunPhpServers.bat
call rundll32 url.dll,FileProtocolHandler http://127.0.0.1:2393/DKWasm.html
 
%DKEND% 
