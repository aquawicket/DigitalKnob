@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_fileToGrid(path rtn_var)
::#
::#  Read lines of a file into an grid and echo them back
::#
::#
:dk_fileToGrid
setlocal
	%dk_call% dk_debugFunc 2

    set "_file_=%~1"
	set "_file_=%_file_:/=\%"
	
	set /a _row_=0
	for /F "usebackq delims=" %%r in ("%_file_%") do (
    rem for /f "tokens=*" %%r in ("%_file_%") do (
		set /a _column_=0
		for %%c IN (%%r) do (
			set "%~2[!_row_!][!_column_!]=%%c"
			set /a _column_+=1
		)
		set /a _row_+=1
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
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_fileToGrid "%DKBRANCH_DIR%\build_list.txt" MyGrid
	
    ::%dk_call% dk_fileToGrid "fileToGrid_TEST.txt" MyGrid

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
