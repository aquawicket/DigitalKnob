@echo off
::echo %0(%*)

:main
	call:print_path_info "C:\Windows\System32\cmd.exe"
	
	set "my_path=C:\Windows\System32\cmd.exe"
	
	call:print_path_info "%my_path%"
	pause
goto:eof

:print_path_info <input>
	echo.
	echo print_path_info( %* )
	
	echo  1 = %1
	echo ~1 = %~1
	
	set "input=%~1"
	
	if defined %input% (
		call set "var=%%%input%%%"
	) else (
		set "var=%input%"
	)
	
    For %%I in ("%var%") do (
		echo                  original:      I: %%I
		echo        no quotation marks:     ~I:  %%~I
        echo fully qualified path name:    ~fI:  %%~fI
        echo         drive letter only:    ~dI:  %%~dI
        echo                 path only:    ~pI:  %%~pI
        echo            file name only:    ~nI:  %%~nI
        echo       file extension only:    ~nI:  %%~nI
        echo          short names only:    ~sI:  %%~sI
        echo           file attributes:    ~aI:  %%~aI
        echo        file date and time:    ~tI:  %%~tI
        echo                 file size:    ~zI:  %%~zI
        echo       drive letter + path:   ~dpI:  %%~dpI
        echo                  name.ext:   ~nxI:  %%~nxI
        echo             full + short :   ~fsI:  %%~fsI
		echo     dir like output line : ~ftzaI:  %%~ftzaI)
		
	pause
goto:eof


:::: Variable substitutions :::::::
:: 		   %I 	Original Variable
:: 		  %~I 	Expands %I which removes any surrounding quotation marks.
:: 		 %~fI	Expands %I to a fully qualified path name.
:: 		 %~dI	Expands %I to a drive letter only.
:: 		 %~pI	Expands %I to a path only.
:: 		 %~nI	Expands %I to a file name only.
:: 		 %~xI	Expands %I to a file name extension only.
:: 		 %~sI	Expands path to contain short names only.
:: 		 %~aI	Expands %I to the file attributes of file.
:: 	     %~tI	Expands %I to the date and time of file.
::       %~zI	Expands %I to the size of the file.
::  %~$PATH:I	Searches the directories listed in the PATH environment variable and expands %I to the fully qualified name of the first directory found. 
::                 If the environment variable name isn't defined or the file isn't found by the search, this modifier expands to the empty string.
::		%~dpI	Expands %I to a drive letter and path only.
::		%~nxI	Expands %I to a file name and extension only.
::		%~fsI	Expands %I to a full path name with short names only.
::%~dp$PATH:I	Searches the directories that are listed in the PATH environment variable for %I and expands to the drive letter and path of the first one found.
::	  %~ftzaI	Expands %I to an output line that is like dir.