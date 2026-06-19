@echo off
title Network Chat Room
setlocal EnableDelayedExpansion

rem [Settings]
set "adminKey=z "
set "msgPathDefault=BatchScript_Data\NetChatRoom"
set "msgFileName=chatRoom.txt"

set "msgKeyHLP=---HELP"
set "msgKeyCLS=---CLS"
set "msgKeyREN=---REN"
set "msgKeyDEL=---DEL"
set "msgKeyXIT=---XIT"
rem [/Settings]

set "userNickMaxLength=12"
set "displayLines=20"

if /i "%1" == "START" if not "%2" == "" goto %2 %3 %4 %5 %6 %7 %8 %9
goto scriptMain

:errorUnexpected
echo=
echo An error happened.
echo Network Chat Room will exit
pause
exit

:scriptMain
set "msgPath=?"
mode cols=80

:beepMenu
set "bellSound=?"
cls
echo                                NETWORK CHAT ROOM
echo ================================================================================
echo                                                ===============================
echo                                                ^|        Made by wthe22       ^|
echo                                                ^| http://winscr.blogspot.com/ ^|
echo                                                =============================\^|
echo  ===============================
echo  ^|      Enable beep sound?     ^|
echo  ^|/=============================
echo=
echo ================================================================================
set /p "userInput=Reply | Y/N? "
if /i "%userInput%" == "Y" set "bellSound="
if /i "%userInput%" == "N" set "bellSound="
if not "%bellSound%" == "?" goto userNickIn
echo=
echo Invalid choice
pause
goto beepMenu

:userNickIn
cls
set "userNick="
if defined bellSound (
    echo Beep sound         : Enabled
) else echo Beep sound         : Disabled
echo=
echo Input your username:
echo=
set /p "userNick="
if defined userNick if "!userNick:~%userNickMaxLength%!" == "" (
    set "userNick=%userNick%                "
    set "userNick=!userNick:~0,%userNickMaxLength%!"
    goto msgPathIn
)
echo=
echo Invalid username
echo Username must be 1 - %userNickMaxLength% characters long
pause
goto userNickIn

:msgPathIn
set "userLvl=1"
cls
if defined bellSound (
    echo Beep sound         : Enabled
) else echo Beep sound         : Disabled
echo=
echo Your username      : %userNick%
echo=
echo Previous chat room :
echo=%msgPath%
echo=
echo Type nothing to use previous chat room if used before
echo Use default        ?
echo Change username    :
echo=
echo Input your chat room address:
echo=
set /p "msgPath="
:msgPathCheck
if not defined msgPath goto msgPathIn
set "fileA="
set "fileN="
for %%f in (%msgPath%) do (
    set "fileA=%%~af"   Attributes
    set "fileN=%%~nf"   Name
    set "msgPath=%%~ff" Full Path
)
if "%fileN%" == ":" goto userNickIn
if "%msgPath%" == "?" (
    set "msgPath=%msgPathDefault%"
    goto msgPathCheck
)
if not defined fileA goto msgFileNotExist
if /i not "%fileA:~0,1%" == "D" goto msgPathInvalid
if not exist "%msgPath%" goto msgFileNotExist
if not exist "%msgPath%\chatHistory.txt" goto msgFileNotExist
goto msgChatModeIn

:msgPathInvalid
echo=
echo Invalid chat room address
echo You input a file address, not a folder address.
echo=
pause
goto msgPathIn

:msgFileNotExist
cls
echo Chat room address:
echo=
echo %msgPath%
echo=
echo The message file or folder did not exist
echo Create the message file and folder?
set /p "userInput=Y/N? "
if /i "%userInput%" == "Y" goto msgFileCreate
if /i "%userInput%" == "N" goto msgPathIn
echo=
echo Invalid choice
pause
goto msgFileNotExist

:msgFileCreate
cls
echo Creating chat room...
if not exist "%msgPath%" md "%msgPath%"
@echo Created on %date% %time% > "%msgPath%\chatHistory.txt"
@echo -------------------------------------------------------------------------------- >> "%msgPath%\chatHistory.txt"
if not exist "%msgPath%\chatHistory.txt" goto msgFileCreateError
set "userLvl=2"
echo Chat room created
pause
goto msgChatModeIn

:msgFileCreateError
echo=
echo Script cannot create the chat room...
echo The chat room address is not accessible,
echo write-protected or access is denied.
pause
goto msgPathIn

:msgChatModeIn
cls
echo Chat Room address  :
echo=
echo %msgPath%
echo=
echo 1. Join chat room
echo 2. View chat room with auto update
echo 3. View full chat room without auto update
echo=
echo 0. Back
echo=
echo Choose what do you want to do:
set /p "userInput="
if "%userInput%" == "0" goto msgPathIn
if "%userInput%" == "1" goto msgScreenModeIn
if "%userInput%" == "2" goto msgScreenAuto
if "%userInput%" == "3" goto msgScreenFull
echo=
echo Invalid choice
pause
goto msgChatModeIn

:msgScreenModeIn
cls
if "%userLvl%" == "2" (
    echo Default is 1                                                                  `
) else echo Default is 1
echo=
echo 1. Split chat screen
echo 2. All in one screen
echo=
echo 0. Back
echo=
echo Choose your chat screen:
set /p "msgScreenSplit="
if "%msgScreenSplit%" == "0" goto msgChatModeIn
if "%msgScreenSplit%" == "2" set "msgScreenSplit=0"
if "%msgScreenSplit%" == "0" goto msgCmdList
if "%msgScreenSplit%" == "1" goto msgCmdList
if "%msgScreenSplit%" == "%adminKey%" set "userLvl=2"
echo=
echo Invalid choice
pause
goto msgScreenModeIn

:msgCmdList
cls
title Network Chat Room
echo Instructions
echo=
echo Action                 Command
echo=
if "%msgScreenSplit%" == "0" (
echo Refresh message        [Enter nothing]
echo See command list       %msgKeyHLP%
)
echo Exit chat room         %msgKeyXIT%
if not "%userLvl%" == "2" goto msgCmdEnd
echo Clear chat room        %msgKeyCLS%
echo Rename chat room       %msgKeyREN%
echo Delete chat room       %msgKeyDEL%
:msgCmdEnd
echo=
pause
if "%msgScreenSplit%" == "0" goto msgScreenCombinedSetup
if "%msgScreenSplit%" == "1" goto msgScreenSplitSetup
goto errorUnexpected

:msgScreenAuto
set "msgLines=0"
for /f %%n in ('type "%msgPath%\chatHistory.txt" ^| find "" /v /c') do set "msgLines=%%n"
set /a msgLineStart=%msgLines%-%displayLines%
if %msgLineStart% LSS 0 set "msgLineStart=0"
if not "%msgLines%" == "%msgLinesP%" (
    title Network Chat Room Receiver - [%date% %time%] New Message
    echo=%bellSound%
) else title Network Chat Room Receiver - [%date% %time%]
cls
more +%msgLineStart% < "%msgPath%\chatHistory.txt" 
set "msgLinesP=%msgLines%"
timeout /t 1 > nul 
if exist "%msgPath%\chatHistory.txt" goto msgScreenAuto
cls 
title Network Chat Room
echo Chat Room: 
echo=
echo %msgPath%
echo= 
echo ERROR: Cannot find chat room
echo Maybe someone deleted or renamed it 
pause 
exit


:msgScreenFull
for %%f in ("%msgPath%\chatHistory.txt") do set "msgSize=%%~zf"
if not "%msgSize%" == "%msgSizeP%" (
    title Network Chat Room [%date% %time%] New Message
    echo=%bellSound%
) else title Network Chat Room - [%date% %time%]
cls
type "%msgPath%\chatHistory.txt" 
set "msgSizeP=%msgSize%"
echo ================================================================================
echo 0. Back
echo=
echo Press enter to refresh
echo=
set /p "userInput="
if "%userInput%" == "0" goto msgPathIn
if not exist "%msgPath%\chatHistory.txt" goto msgDisconnected
goto msgScreenFull

:msgScreenSplitSetup
start "" "%~f0" START msgScreenAuto
title Network Chat Room - Chat as %userNick%
:msgScreenSplit
cls
echo Action                 Command
echo Exit chat room         %msgKeyXIT%
if "%userLvl%" == "2" (
echo Clear chat room        %msgKeyCLS%
echo Rename chat room       %msgKeyREN%
echo Delete chat room       %msgKeyDEL%
)
set "userInput="
echo ================================================================================
set /p "userInput="
goto msgProcess

:msgScreenCombinedSetup
:msgScreenCombined
for %%f in ("%msgPath%\chatHistory.txt") do set "msgSize=%%~zf"
if not "%msgSize%" == "%msgSizeP%" (
    title Network Chat Room [%date% %time%] New Message
    echo=%bellSound%
) else title Network Chat Room - [%date% %time%]
cls
type "%msgPath%\chatHistory.txt" 
set "msgSizeP=%msgSize%"
set "userInput="
echo ================================================================================
echo Help Command          %msgKeyHLP%
echo=
set /p "userInput=[  :  ] %userNick%: "
goto msgProcess

:msgProcess
rem Filter for empty message
if not defined userInput goto msgBack
set "msgFiltered=%userInput: =%"
if not defined msgFiltered goto msgBack

rem Filter for anti-spam
if "%time:~0,-3%" == "%msgTime%" (
    if "%msgCount%" == "2" (
        echo=
        echo Slow down, you are sending messages too fast...
        timeout /t 1 /nobreak > nul
        goto msgBack
    )
) else (
    set "msgTime=%time:~0,-3%"
    set "msgCount=0"
)
set /a msgCount+=1

if not exist "%msgPath%\chatHistory.txt" goto msgDisconnected
if /i "%msgFiltered%" == "%msgKeyXIT%" goto msgExit
if /i "%msgFiltered%" == "%msgKeyHLP%" goto msgCmdList
if "%userLvl%" == "2" (
    if /i "%msgFiltered%" == "%msgKeyCLS%" goto msgCls
    if /i "%msgFiltered%" == "%msgKeyREN%" goto msgRen
    if /i "%msgFiltered%" == "%msgKeyDEL%" goto msgDel
)
rem Adjust write output to prevent display error
call :GetLength userInput
for /l %%n in (0,57,%return%) do (
    echo [%time:~0,-6%] %userNick%: !userInput:~0,57!
    set "userInput=!userInput:~57!"
) >> "%msgPath%\chatHistory.txt"
goto msgBack

:msgBack
if not exist "%msgPath%\chatHistory.txt" goto msgDisconnected
if "%msgScreenSplit%" == "0" goto msgScreenCombined
if "%msgScreenSplit%" == "1" goto msgScreenSplit
goto errorUnexpected

:msgDisconnected
cls 
title Network Chat Room
echo Chat Room: 
echo=
echo %msgPath%
echo= 
echo ERROR: Cannot find chat room
echo Maybe someone deleted or renamed it 
pause 
goto msgPathIn

:msgExit
cls
echo Chat Room address  :
echo=
echo %msgPath%
echo=
echo Are you sure you want to exit chat room?
set /p "userInput=Y/N? "
if /i not "%userInput%" == "Y" goto msgBack
goto msgPathIn

:msgCls
cls
echo Chat Room address  :
echo=
echo %msgPath%
echo=
echo Are you sure you want to clear chat room messages?
set /p "userInput=Y/N? "
if /i not "%userInput%" == "Y" goto msgBack
cls
echo Clearing chat room...
@echo Created on %date% %time% > "%msgPath%\chatHistory.txt"
@echo -------------------------------------------------------------------------------- >> "%msgPath%\chatHistory.txt"
echo Done.
pause
goto msgBack


:msgRen
cls
echo Chat Room address  :
echo=
echo %msgPath%
echo=
echo Input new name for chat room:
set /p "userInput="
echo=
echo This would disconnect everyone in chat room
echo Are you sure you want to rename chat room?
set /p "userInput=Y/N? "
if /i not "%userInput%" == "Y" goto msgBack
echo=
echo Function not made yet...
pause
goto msgBack

:msgDel
cls
echo Chat Room address  :
echo=
echo %msgPath%
echo=
echo This would disconnect everyone and delete chat room messages
echo Are you sure you want to delete chat room?
set /p "userInput=Y/N? "
if /i not "%userInput%" == "Y" goto msgBack
cls
echo Deleting chat room...
del "%msgPath%" /f /q
echo Done.
pause
goto msgBack

rem Functions

:GetLength [Variable Name]
set "return=0"
if not defined %1 goto :EOF
for %%n in (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) do (
    set /a return+=%%n
    for %%l in (!return!) do if "!%1:~%%l,1!" == "" set /a return-=%%n
)
set /a return+=1
goto :EOF
