@echo off


:main
	rem ######### Local DigitalKnob Folder ########
	set "Branch=Development"
	set "Local_DK_Dir=%USERPROFILE:\=/%/Digital Knob"

	rem ###### Remote DigitalKnob Folders ######
	for %%i in (A B C D E F G H J J K L M N O P Q R S T U V W X Y Z) do (
		if EXIST "%%i:/DigitalKnob/%Branch%.git" (
			set "Remote_DK_Dir=%%i:/DigitalKnob"
		)
	)

	call :loadFiles
	call :gitClone

	rem # TODO: Automatically select option 1 from pickUpdate
	rem set "pickUpdate=1"
	start "" /b "%Remote_DK_Dir:/=\%\%Branch%\DKBatch\functions\DKBuilder\DKBuilder.cmd"
exit /b %errorlevel%

:loadFiles
	rem #	DK_Dir
    if NOT EXIST "%Remote_DK_Dir%" (echo ERROR: Remote_DK_Dir:'%Remote_DK_Dir%' NOT FOUND & pause & exit /b 1) else (echo Remote_DK_Dir:'%Remote_DK_Dir%')
    if NOT EXIST "%Local_DK_Dir%" 	(mkdir "%Local_DK_Dir:/=\%")
    if NOT EXIST "%Local_DK_Dir%" 	(echo ERROR: Local_DK_Dir:'%Local_DK_Dir%' NOT FOUND & pause & exit /b 1) else (echo Local_DK_Dir:'%Local_DK_Dir%')
    
	rem # 	BACKUP.cmd
    if NOT EXIST "%Local_DK_Dir%/BACKUP.cmd" (
		if NOT EXIST "%Remote_DK_Dir%/BACKUP.cmd" (echo ERROR: BACKUP.cmd:'%Remote_DK_Dir%/BACKUP.cmd' NOT FOUND & exit /b 1) else (
			copy "%Remote_DK_Dir:/=\%\BACKUP.cmd" "%Local_DK_Dir:/=\%\BACKUP.cmd"
		)
	)
	if NOT EXIST "%Local_DK_Dir%/BACKUP.cmd" (echo ERROR: BACKUP.cmd:'%Local_DK_Dir%/BACKUP.cmd' NOT FOUND & exit /b 1) else (echo BACKUP.cmd:'%Local_DK_Dir%/BACKUP.cmd')
	
	rem #	RESTORE.cmd
    if NOT EXIST "%Local_DK_Dir%/RESTORE.cmd" (
		if NOT EXIST "%Remote_DK_Dir%/RESTORE.cmd" (echo ERROR: RESTORE.cmd:'%Remote_DK_Dir%/RESTORE.cmd' NOT FOUND & exit /b 1) else (
			copy "%Remote_DK_Dir:/=\%\RESTORE.cmd" "%Local_DK_Dir:/=\%\RESTORE.cmd"
		)
	)
    if NOT EXIST "%Local_DK_Dir%/RESTORE.cmd" (echo ERROR: RESTORE.cmd:'%Local_DK_Dir%/RESTORE.cmd' NOT FOUND & exit /b 1) else (echo RESTORE.cmd:'%Local_DK_Dir%/RESTORE.cmd')
	
	rem #	SYNC.cmd
    if NOT EXIST "%Local_DK_Dir%/SYNC.cmd" (
		if NOT EXIST "%Remote_DK_Dir%/SYNC.cmd" (echo ERROR: Remote_DK_Dir/SYNC.cmd:'%Remote_DK_Dir%/SYNC.cmd' NOT FOUND & exit /b 1) else (
			copy "%Remote_DK_Dir:/=\%\SYNC.cmd" "%Local_DK_Dir:/=\%\SYNC.cmd"
		)
	)
    if NOT EXIST "%Local_DK_Dir%/SYNC.cmd" (echo ERROR: SYNC.cmd:'%Local_DK_Dir%/SYNC.cmd' NOT FOUND & exit /b 1) else (echo SYNC.cmd:'%Local_DK_Dir%/SYNC.cmd')

	rem #	DKTools
	if NOT EXIST "%Remote_DK_Dir%/DKTools" (echo ERROR: DKTools:'%Remote_DK_Dir%/DKTools'NOT FOUND & pause & exit /b 1)
    if NOT EXIST "%Local_DK_Dir%/DKTools" 	(mkdir "%Local_DK_Dir:/=\%\DKTools")
    if NOT EXIST "%Local_DK_Dir%/DKTools" 	(echo ERROR: DKTools:'%Local_DK_Dir%\DKTools' NOT FOUND & pause & exit /b 1) else (echo DKTools:'%Local_DK_Dir%\DKTools')
    
	rem #	curl.exe
    if NOT EXIST "%Local_DK_Dir%/DKTools/curl.exe" (
		if NOT EXIST "%Remote_DK_Dir%/DKTools/curl.exe" (echo ERROR: curl.exe:'%Remote_DK_Dir%/DKTools/curl.exe' NOT FOUND & exit /b 1) else (
			copy "%Remote_DK_Di:/=\r%\DKTools\curl.exe" "%Local_DK_Dir:/=\%\DKTools\curl.exe"
		)
	)
	if NOT EXIST "%Local_DK_Dir%/DKTools/curl.exe" (echo ERROR: curl.exe:'%Local_DK_Dir%/DKTools/curl.exe' NOT FOUND & exit /b 1) else (echo curl.exe:'%Local_DK_Dir%/DKTools/curl.exe')
    rem if NOT EXIST "%Local_DK_Dir%/DKTools/cosmos/curl.exe" (copy "%Local_DK_Dir%/DKTools/cosmos/curl" "%Local_DK_Dir%/DKTools/cosmos/curl.exe")

    rem if NOT EXIST "%Local_DK_Dir%/%Branch%/DKBatch/functions/DKBuilder/DKBuilder.cmd" (
		rem if NOT EXIST "%Remote_DK_Dir%/%Branch%/DKBatch/functions/DKBuilder" (echo ERROR: DKBuilder:'%Remote_DK_Dir%/%Branch%/DKBatch/functions/DKBuilder' NOT FOUND & exit /b 1)
		rem if NOT EXIST "%Local_DK_Dir%/%Branch%/DKBatch/functions/DKBuilder/DKBuilder.cmd" (
			rem if NOT EXIST "%Local_DK_Dir%/%Branch%/DKBatch/functions/DKBuilder" (mkdir "%Local_DK_Dir:/=\%\%Branch%\DKBatch\functions\DKBuilder")
    rem		copy "%Remote_DK_Dir:/=\%\%Branch%\DKBatch\functions\DKBuilder\DKBuilder.cmd" "%Local_DK_Dir:/=\%\%Branch%\DKBatch\functions\DKBuilder\DKBuilder.cmd"
    rem )
exit /b %errorlevel%


:gitClone
  if NOT EXIST "%Local_DK_Dir%/%Branch%/.git" (
    %USB_Drive%
    "%Remote_DK_Dir:/=\%\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" config --global --add safe.directory "%Remote_DK_Dir%/%Branch%.git"
    "%Remote_DK_Dir:/=\%\DKTools\git-portable-2.46.2-64-bit\bin\git.exe" clone "%Remote_DK_Dir%/%Branch%.git" "%Local_DK_Dir%/%Branch%"
  )
exit /b %errorlevel%
