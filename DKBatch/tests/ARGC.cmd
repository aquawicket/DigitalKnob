@echo off
::### https://superuser.com/a/901966
call :Test1
call :Test2
call :Test3 
call :Test4
pause 
exit /b

:dk_ARGC
	SetLocal EnableDelayedExpansion

	set args=%*
	echo args    = !args!
	
	set "args=!args:^^=^!"
	set args=!args:;=[semicolon]!
	set args=!args:,=[comma]!
	set args=!args:"=[quote]!
	set args=!args:?=[question]!
	set args=!args:%%=[percent]!

	set /a "len=100"
	for /l %%x in (0,1,%len%) do (
		if not "!args:~%%x,1!"=="" (
			rem ### Exclaimation (!) breaks :Arg_Count_Loop.  Replace it with [exclaimation]
			if "!args:~%%x,1!"=="^!" (
				set /a plusone=%%x+1
				for /l %%y in (!plusone!, 1, !plusone!) do (
					set args=!args:~0,%%x![exclaimation]!args:~%%y!
				)
			)
			rem ### Astrisk (*) breaks :Arg_Count_Loop.  Replace it with [astrisk]
			if "!args:~%%x,1!"=="*" (
				set /a plusone=%%x+1
				for /l %%y in (!plusone!, 1, !plusone!) do (
					set args=!args:~0,%%x![astrisk]!args:~%%y!
				)
			)
			rem ### Equal (=) breaks :Arg_Count_Loop.  Replace it with [equal]
			if "!args:~%%x,1!"=="=" (
				set /a plusone=%%x+1
				for /l %%y in (!plusone!, 1, !plusone!) do (
					set args=!args:~0,%%x![equal]!args:~%%y!
				)
			)
			rem ### Percent (%) breaks :Arg_Count_Loop.  Replace it with [percent]
		rem if "!args:~%%x,1!"=="%" (
		rem 	set /a plusone=%%x+1
		rem		for /l %%y in (!plusone!, 1, !plusone!) do (
		rem			set args=!args:~0,%%x![percent]!args:~%%y!
		rem		)
		rem )
			rem ### Exclamation (!) breaks :Arg_Count_Loop.  Replace it with [exclamation]
		rem if "!args:~%%x,1!"=="!" (
		rem 	set /a plusone=%%x+1
		rem		for /l %%y in (!plusone!, 1, !plusone!) do (
		rem			set args=!args:~0,%%x![exclamation]!args:~%%y!
		rem		)
		rem )
		)
	)
	echo args   = !args!
	
	set ARGC=0
	:Arg_Count_Loop
	for %%a in (!args!) do (
		set arg=%%a
		rem echo %%a "%%a" %%~a "%%~a" !arg! "!arg!"
		rem if "!arg!" equ "[exclaimation]" (set "arg=^!")
		rem set "arg=!arg:[exclaimation]=^!!"
		set "arg=!arg:[astrisk]=*!"
		set "arg=!arg:[comma]=,!"
		set "arg=!arg:[quote]="!"
		set "arg=!arg:[equal]==!"
		set "arg=!arg:[percent]=%%!"
		set "arg=!arg:[semicolon]=;!"
		set "arg=!arg:[question]=?!"
		set /A ARGC+=1
		echo args:!ARGC! = !arg!
	)
	echo ARGC = %ARGC%
	
	
::	set "args=!args:[astrisk]=*!"
::	set "args=!args:[comma]=,!"
::	set "args=!args:[quote]="!"
::	set "args=!args:[equal]==!"
::	set "args=!args:[percent]=%%!"
::	set "args=!args:[semicolon]=;!"
::	set "args=!args:[question]=?!"
	::set "args=!args:[exclamation]=^^!!"
	endlocal & (
		set "ARGC=%ARGC%"
	)	
exit /b

:Test1
	echo(
	set args=a b c   
	echo args    = %args%
	set Expected=3
	call :dk_ARGC %args%
	echo     ARGC : [%ARGC%]
	echo Expected : [%Expected%]
	if "%ARGC%" == "%Expected%" (echo Test1 passed) else (echo Test1 failed)
exit /b

:Test2
	echo(
	SetLocal EnableDelayedExpansion
::        ALL:a ! " # $ % & ' ( ) * +  ,  -  .  /  :  ;  <  =  >  ?  @  [  \  ]  ^  _  `  {  |  }  ~
::    INVALID:  !       %
::      VALID:a     # $   & ' ( ) * +  ,  -  .  /  :  ;  <  =  >  ?  @  [  \  ]  ^  _  `  {  |  }  ~
::            1   2 3 4   5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
    set args=a   " # $   & ' ( ) * +  ,  -  .  /  :  ;  <  =  >  ?  @  [  \  ]  ^  _  `  {  |  }  ~      
	echo args    = %args%
	set Expected=31
	call :dk_ARGC !args!
	echo     ARGC : [%ARGC%]
	echo Expected : [!Expected!]
	if "%ARGC%" == "%Expected%" (echo Test2 passed) else (echo Test2 failed)
exit /b
	
:Test3
	echo(
	SetLocal EnableDelayedExpansion
::       ALL:a ! " # $ %  & ' ( ) *  +  ,  -  .  /  :  ;  <  =  >  ?  @  [  \  ]  ^  _  `  {  |  }  ~
::   INVALID:  !       % 
::     VALID:a     # $ %% & ' ( ) *  +  ,  -  .  /  :  ;  <  =  >  ?  @  [  \  ]  ^  _  `  {  |  }  ~
::           1 0 2 3 4 5  6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32
    set args=a   " # $ %% & ' ( ) *  +  ,  -  .  /  :  ;  <  =  >  ?  @  [  \  ]  ^  _  `  {  |  }  ~
	echo args    = !args!
	set Expected=32
	set args=!args:%%=[percent]!
	call :dk_ARGC !args!
	echo     ARGC : [%ARGC%]
	echo Expected : [%Expected%]
	if "%ARGC%" == "%Expected%" (echo Test3 passed) else (echo Test3 failed)
exit /b

:Test4
	echo(
	SetLocal EnableDelayedExpansion
::       ALL:a   ! " # $ %  & ' ( )  *  +  ,  -  .  /  :  ;  <  =  >  ?  @  [  \  ]  ^   _  `  {  |  }  ~
::   INVALID:    !       % 
::     VALID:a ^^! " # $    & ' ( )  *  +  ,  -  .  /  :  ;  <  =  >  ?  @  [  \  ]  ^   _  `  {  |  }  ~
::           1 2   3 4 5 6  7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27  28 29 30 31 32 33
    set args=a ^^! " # $ %% & ' ( )  *  +  ,  -  .  /  :  ;  <  =  >  ?  @  [  \  ]  ^^  _  `  {  |  }  ~
	echo args    = !args!
	set Expected=33
	setlocal disableDelayedExpansion
		call :dk_ARGC !args!
		::set /a "ARCG=%ARGC%"
		echo     ARGC : [%ARGC%]
		echo Expected : [%Expected%]
		if "%ARGC%" == "%Expected%" (echo Test4 passed) else (echo Test4 failed)
	endlocal
exit /b

