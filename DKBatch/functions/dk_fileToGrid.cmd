@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_fileToGrid(path rtn_var)
::#
::#  Read lines of a file into an grid and echo them back
::#
::#
:dk_fileToGrid
    %dk_call% dk_debugFunc 2
 setlocal
 
	echo dk_fileToGrid(%*)
    set "_file_=%~1"
	echo _file_ = %_file_%
	set "_file_=%_file_:/=\%"
	echo _file_ = %_file_%
	
	set /a row=0
	for /F "usebackq delims=" %%r in ("%_file_%") do (
    rem for /f "tokens=*" %%r in ("%_file_%") do (
		set /a column=0
		for %%c IN (%%r) do (
			set "%~2[!row!][!column!]=%%c"
			set /a column+=1
		)
		set /a row+=1
    )
	
    :: Return the grid to the calling scope
    set "currentScope=1"
    for /F "delims=" %%a in ('set %~2[') do (
       if defined currentScope endlocal
       set "%%a"
    )
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    %dk_call% dk_debugFunc 0
 setlocal
 
    %dk_call% dk_fileToGrid "fileToGrid_TEST.txt" MyGrid

    :: print items individually
    %dk_call% dk_printVar MyGrid[0][0]
    %dk_call% dk_printVar MyGrid[1][1]
    %dk_call% dk_printVar MyGrid[2][2]
    %dk_call% dk_printVar MyGrid[3][3]
    %dk_call% dk_printVar MyGrid[4][4]
    %dk_call% dk_printVar MyGrid[5][5]
    %dk_call% dk_printVar MyGrid[6][6]
    %dk_call% dk_printVar MyGrid[7][7]
	%dk_call% dk_printVar MyGrid[8][8]
	%dk_call% dk_printVar MyGrid[9][9]
	
	:: print rows individually 
	%dk_call% dk_printVar MyGrid[0]
	%dk_call% dk_printVar MyGrid[1]
	%dk_call% dk_printVar MyGrid[2]
	%dk_call% dk_printVar MyGrid[3]
	%dk_call% dk_printVar MyGrid[4]
	%dk_call% dk_printVar MyGrid[5]
	%dk_call% dk_printVar MyGrid[6]
	%dk_call% dk_printVar MyGrid[7]
	%dk_call% dk_printVar MyGrid[8]
	%dk_call% dk_printVar MyGrid[9]
%endfunction%
