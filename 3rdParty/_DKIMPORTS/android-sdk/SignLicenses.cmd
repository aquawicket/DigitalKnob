%dkbatch%

call EndProcess java.exe
call EndProcess adb.exe

call "C:/Users/%USERNAME%/digitalknob/Development/3rdParty/_DKIMPORTS/openjdk-8u41/registerJDK.cmd"

set "SDKMANAGER=C:\Users\%USERNAME%\digitalknob\Development\3rdParty\android-sdk\cmdline-tools\latest\bin\sdkmanager.bat

:: https://stackoverflow.com/a/48539058/688352
(
  echo y
  echo y
  echo y
  echo y
  echo y
  echo y
  echo y
  echo y
  echo y
  echo y
  echo y
  echo y
  echo y
  echo y
  echo y
  echo y
  echo y
  echo y
  echo y
  echo y
) > file-y.txt

%SDKMANAGER% --licenses < file-y.txt
::%SDKMANAGER% --licenses

call "C:/Users/%USERNAME%/digitalknob/Development/3rdParty/_DKIMPORTS/jdk/registerJDK.cmd" 
 
::%DKEND% 
