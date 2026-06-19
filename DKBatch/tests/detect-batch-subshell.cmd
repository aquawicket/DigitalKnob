@echo off

:detectSubshell
	setlocal EnableDelayedExpansion

	rem Dequote path to command processor and this script path
	set ScriptPath=%~0
	set CmdPath=%COMSPEC:"=%

	rem Get command processor filename and filename with extension
	for %%c in (!CmdPath!) do (
		set CmdExeName=%%~nxc
		set CmdName=%%~nc
	)

	rem Get this process' PID
	rem Adapted from: http://www.dostips.com/forum/viewtopic.php?p=22675#p22675
	set "uid="
	for /l %%i in (1 1 128) do (
		set /a "bit=!random!&1"
		set "uid=!uid!!bit!"
	)

	for /f "tokens=2 delims==" %%i in (
		'wmic Process WHERE "Name='!CmdExeName!' AND CommandLine LIKE '%%!uid!%%'" GET ParentProcessID /value'
	) do (
		rem Get commandline of parent
		for /f "tokens=1,2,*" %%j in (
			'wmic Process WHERE "Handle='%%i'" GET CommandLine /value'
		) do (

			rem Strip extra CR's from wmic output
			rem http://www.dostips.com/forum/viewtopic.php?t=4266
			for /f "delims=" %%x in ("%%l") do (
				rem Dequote path to batch file, if any (3rd argument)
				set ParentScriptPath=%%x
				set ParentScriptPath=!ParentScriptPath:"=!
			)

			rem Get parent process path
			for /f "tokens=2 delims==" %%y in ("%%j") do (
				rem Dequote parent path
				set ParentPath=%%y
				set ParentPath=!ParentPath:"=!

				rem Handle different invocations: C:\Windows\system32\cmd.exe , cmd.exe , cmd
				for %%p in (!CmdPath! !CmdExeName! !CmdName!) do (
					if !ParentPath!==%%p set IsCmdParent=1
				)

				rem Check if we're running in cmd.exe with /c switch and this script path as argument
				if !IsCmdParent!==1 if %%k==/c if "!ParentScriptPath!"=="%ScriptPath%" set IsExternal=1
			)
		)
	)

	if !IsExternal!==1 (
		echo %~nx0 only works if run directly from !CmdExeName!^^!
		exit 1
	) else (
		 echo Running interactively in !CmdExeName! session.
	)

	pause
endlocal