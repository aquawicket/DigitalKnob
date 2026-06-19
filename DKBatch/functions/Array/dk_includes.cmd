@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


rem ################################################################################
rem # Array::dk_includes(array, searchElement)
rem # Array::dk_includes(array, searchElement, fromIndex)
rem #
rem #	The includes() method of Array instances determines whether an array includes a certain value among its entries, returning true or false as appropriate.
rem #
rem #	PARAMETERS
rem #	searchElement
rem #		The value to search for.
rem #
rem #	fromIndex :optional
rem #		Zero-based index at which to start searching, converted to an integer.
rem #			Negative index counts back from the end of the array — if -Array::length <= fromIndex < 0, fromIndex + Array::length is used. However,
rem #			the array is still searched from front to back in this case.
rem #			If fromIndex < -Array::length or fromIndex is omitted, 0 is used, causing the entire array to be searched.
rem #			If fromIndex >= Array::length, the array is NOT searched and false is returned.
rem #
rem #	RETURN VALUE
rem #	A boolean value which is true if the value searchElement is found within the array (or the part of the array indicated by the index fromIndex, if specified).
rem #
rem #	REFERENCE
rem #	https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/includes
rem #
:dk_includes
%setlocal%

	set "_arry_=%~1"
	set /a count=0
	:includes_loop
	if defined %_arry_%[%count%] (
		if "!%_arry_%[%count%]!" equ "%~2" (
			if "%~3" neq "" (endlocal & set "%3=true")
			endlocal & (set dk_includes=true) & exit /b 0
		)
		rem ###### case-insensitive compair ######
		rem if /i "!%_arry_%[%count%]!" equ "%~2" (
		rem 	if "%~3" neq "" (endlocal & set "%3=true")
		rem 	endlocal & (set dk_includes=true) & exit /b 0
		rem )
		set /a count+=1
		goto includes_loop
	)
	if "%~3" neq "" (endlocal & set "%3=false")
	endlocal & (set dk_includes=false) & exit /b 1

%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	rem https://www.robvanderwoude.com/escapechars.php
	%dk_call% dk_echo
	set "ASCII[0]= "
	set "ASCII[1]= "
	set "ASCII[2]= "
	set "ASCII[3]= "
	set "ASCII[4]= "
	set "ASCII[5]= "
	set "ASCII[6]= "
	set "ASCII[7]= "
	set "ASCII[8]= "
	set "ASCII[9]= "
	set "ASCII[10]= "
	set "ASCII[11]= "
	set "ASCII[12]= "
	set "ASCII[13]= "
	set "ASCII[14]= "
	set "ASCII[15]= "
	set "ASCII[16]= "
	set "ASCII[17]= "
	set "ASCII[18]= "
	set "ASCII[19]= "
	set "ASCII[20]= "
	set "ASCII[21]= "
	set "ASCII[22]= "
	set "ASCII[23]= "
	set "ASCII[24]= "
	set "ASCII[25]= "
	set "ASCII[26]= "
	set "ASCII[27]= "
	set "ASCII[28]= "
	set "ASCII[29]= "
	set "ASCII[30]= "
	set "ASCII[31]= "
	
	set "ASCII[32]= "
	set "ASCII[33]= " 	&rem !
	set "ASCII[34]= "	&rem "
	set "ASCII[35]=#"
	set "ASCII[36]=$"			
	set "ASCII[37]= "	&rem %
	set "ASCII[38]= "	&rem &
	set "ASCII[39]='"
	set "ASCII[40]=("
	set "ASCII[41]=)"
	set "ASCII[42]=*"
	set "ASCII[43]=+"
	set "ASCII[44]=,"
	set "ASCII[45]=-"
	set "ASCII[46]=."
	set "ASCII[47]=/"
	set "ASCII[48]=0"
	set "ASCII[49]=1"
	set "ASCII[50]=2"
	set "ASCII[51]=3"
	set "ASCII[52]=4"
	set "ASCII[53]=5"
	set "ASCII[54]=6"
	set "ASCII[55]=7"
	set "ASCII[56]=8"
	set "ASCII[57]=9"
	set "ASCII[58]=:"
	set "ASCII[59]=;"
	set "ASCII[60]= "	&rem <
	set "ASCII[61]=="
	set "ASCII[62]= "	&rem >
	set "ASCII[63]=?"
	set "ASCII[64]=@"
	set "ASCII[65]=A"
	set "ASCII[66]=B"
	set "ASCII[67]=C"
	set "ASCII[68]=D"
	set "ASCII[69]=E"
	set "ASCII[70]=F"
	set "ASCII[71]=G"
	set "ASCII[72]=H"
	set "ASCII[73]=I"
	set "ASCII[74]=J"
	set "ASCII[75]=K"
	set "ASCII[76]=L"
	set "ASCII[77]=M"
	set "ASCII[78]=N"
	set "ASCII[79]=O"
	set "ASCII[80]=P"
	set "ASCII[81]=Q"
	set "ASCII[82]=R"
	set "ASCII[83]=S"
	set "ASCII[84]=T"
	set "ASCII[85]=U"
	set "ASCII[86]=V"
	set "ASCII[87]=W"
	set "ASCII[88]=X"
	set "ASCII[89]=Y"
	set "ASCII[90]=Z"
	set "ASCII[91]=["
	set "ASCII[92]=\"
	set "ASCII[93]=]"
	set "ASCII[94]=^"
	set "ASCII[95]=_"
	set "ASCII[96]=`"
	set "ASCII[97]=a"
	set "ASCII[98]=b"
	set "ASCII[99]=c"
	set "ASCII[100]=d"
	set "ASCII[101]=e"
	set "ASCII[102]=f"
	set "ASCII[103]=g"
	set "ASCII[104]=h"
	set "ASCII[105]=i"
	set "ASCII[106]=j"
	set "ASCII[107]=k"
	set "ASCII[108]=l"
	set "ASCII[109]=m"
	set "ASCII[110]=n"
	set "ASCII[111]=o"
	set "ASCII[112]=p"
	set "ASCII[113]=q"
	set "ASCII[114]=r"
	set "ASCII[115]=s"
	set "ASCII[116]=t"
	set "ASCII[117]=u"
	set "ASCII[118]=v"
	set "ASCII[119]=w"
	set "ASCII[120]=x"
	set "ASCII[121]=y"
	set "ASCII[122]=z"
	set "ASCII[123]={"
	set "ASCII[124]= "	&rem |
	set "ASCII[125]=}"
	set "ASCII[126]=~"
	%dk_call% dk_printVar ASCII
	%dk_call% dk_echo
	%dk_call% Array::dk_includes ASCII		&& echo  = true		|| echo  = false
	%dk_call% Array::dk_includes ASCII		&& echo  = true		|| echo  = false
	%dk_call% Array::dk_includes ASCII		&& echo  = true		|| echo  = false
	%dk_call% Array::dk_includes ASCII		&& echo  = true		|| echo  = false
	%dk_call% Array::dk_includes ASCII		&& echo  = true		|| echo  = false
	%dk_call% Array::dk_includes ASCII		&& echo  = true		|| echo  = false
	%dk_call% Array::dk_includes ASCII		&& echo  = true		|| echo  = false
	%dk_call% Array::dk_includes ASCII		&& echo  = true		|| echo  = false
	%dk_call% Array::dk_includes ASCII		&& echo  = true		|| echo  = false
	%dk_call% Array::dk_includes ASCII		&& echo  = true		|| echo  = false
	%dk_call% Array::dk_includes ASCII		&& echo  = true		|| echo  = false
	%dk_call% Array::dk_includes ASCII		&& echo  = true		|| echo  = false
	%dk_call% Array::dk_includes ASCII		&& echo  = true		|| echo  = false
	%dk_call% Array::dk_includes ASCII		&& echo  = true		|| echo  = false
	%dk_call% Array::dk_includes ASCII		&& echo  = true		|| echo  = false
	%dk_call% Array::dk_includes ASCII		&& echo  = true		|| echo  = false
	%dk_call% Array::dk_includes ASCII		&& echo  = true		|| echo  = false
	%dk_call% Array::dk_includes ASCII		&& echo  = true		|| echo  = false
	%dk_call% Array::dk_includes ASCII		&& echo  = true		|| echo  = false
	%dk_call% Array::dk_includes ASCII		&& echo  = true		|| echo  = false
	%dk_call% Array::dk_includes ASCII		&& echo  = true		|| echo  = false
	%dk_call% Array::dk_includes ASCII		&& echo  = true		|| echo  = false
	%dk_call% Array::dk_includes ASCII		&& echo  = true		|| echo  = false
	%dk_call% Array::dk_includes ASCII		&& echo  = true		|| echo  = false
	%dk_call% Array::dk_includes ASCII		&& echo  = true		|| echo  = false
	%dk_call% Array::dk_includes ASCII		&& echo  = true		|| echo  = false
	%dk_call% Array::dk_includes ASCII		&& echo  = true		|| echo  = false
	%dk_call% Array::dk_includes ASCII		&& echo  = true		|| echo  = false
	%dk_call% Array::dk_includes ASCII		&& echo  = true		|| echo  = false
	%dk_call% Array::dk_includes ASCII		&& echo  = true		|| echo  = false
	%dk_call% Array::dk_includes ASCII		&& echo  = true		|| echo  = false
	%dk_call% Array::dk_includes ASCII		&& echo  = true		|| echo  = false
	%dk_call% Array::dk_includes ASCII		&& echo space = true 	|| echo space = false	&rem FIXME
	%dk_call% Array::dk_includes ASCII !	&& echo ! = true 		|| echo ! = false		&rem FIXME
	%dk_call% Array::dk_includes ASCII ""   && echo "" = true 		|| echo "" = false		&rem FIXME
	%dk_call% Array::dk_includes ASCII #	&& echo # = true 		|| echo # = false
	%dk_call% Array::dk_includes ASCII $	&& echo $ = true 		|| echo $ = false		
	%dk_call% Array::dk_includes ASCII %%   && echo %% = true 		|| echo %% = false		&rem FIXME
rem	%dk_call% Array::dk_includes ASCII &	&& echo & = true 		|| echo & = false		&rem FIXME
	%dk_call% Array::dk_includes ASCII '	&& echo ' = true 		|| echo ' = false
	%dk_call% Array::dk_includes ASCII (	&& echo ( = true 		|| echo ( = false
rem	%dk_call% Array::dk_includes ASCII )	&& echo ) = true 		|| echo ) = false		&rem FIXME
	%dk_call% Array::dk_includes ASCII *	&& echo * = true 		|| echo * = false
	%dk_call% Array::dk_includes ASCII +	&& echo + = true 		|| echo + = false
	%dk_call% Array::dk_includes ASCII ,	&& echo , = true 		|| echo , = false		&rem FIXME
	%dk_call% Array::dk_includes ASCII -	&& echo - = true 		|| echo - = false
	%dk_call% Array::dk_includes ASCII .	&& echo . = true 		|| echo . = false
	%dk_call% Array::dk_includes ASCII /	&& echo / = true 		|| echo / = false
	%dk_call% Array::dk_includes ASCII 0	&& echo 0 = true 		|| echo 0 = false
	%dk_call% Array::dk_includes ASCII 1	&& echo 1 = true 		|| echo 1 = false
	%dk_call% Array::dk_includes ASCII 2	&& echo 2 = true 		|| echo 2 = false
	%dk_call% Array::dk_includes ASCII 3	&& echo 3 = true 		|| echo 3 = false
	%dk_call% Array::dk_includes ASCII 4	&& echo 4 = true 		|| echo 4 = false
	%dk_call% Array::dk_includes ASCII 5	&& echo 5 = true 		|| echo 5 = false
	%dk_call% Array::dk_includes ASCII 6	&& echo 6 = true 		|| echo 6 = false
	%dk_call% Array::dk_includes ASCII 7	&& echo 7 = true 		|| echo 7 = false
	%dk_call% Array::dk_includes ASCII 8	&& echo 8 = true 		|| echo 8 = false
	%dk_call% Array::dk_includes ASCII 9	&& echo 9 = true 		|| echo 9 = false
	%dk_call% Array::dk_includes ASCII :	&& echo : = true 		|| echo : = false
	%dk_call% Array::dk_includes ASCII ;	&& echo ; = true 		|| echo ; = false		&rem FIXME
rem	%dk_call% Array::dk_includes ASCII <	&& echo < = true 		|| echo < = false		&rem FIXME
	%dk_call% Array::dk_includes ASCII =	&& echo = = true 		|| echo = = false		&rem 	FIXME
rem	%dk_call% Array::dk_includes ASCII >	&& echo > = true 		|| echo > = false		&rem FIXME
	%dk_call% Array::dk_includes ASCII ?	&& echo ? = true 		|| echo ? = false
	%dk_call% Array::dk_includes ASCII @	&& echo @ = true 		|| echo @ = false
	%dk_call% Array::dk_includes ASCII A	&& echo A = true 		|| echo A = false
	%dk_call% Array::dk_includes ASCII B	&& echo B = true 		|| echo B = false
	%dk_call% Array::dk_includes ASCII C	&& echo C = true 		|| echo C = false
	%dk_call% Array::dk_includes ASCII D	&& echo D = true 		|| echo D = false
	%dk_call% Array::dk_includes ASCII E	&& echo E = true 		|| echo E = false
	%dk_call% Array::dk_includes ASCII F	&& echo F = true 		|| echo F = false
	%dk_call% Array::dk_includes ASCII G	&& echo G = true 		|| echo G = false
	%dk_call% Array::dk_includes ASCII H	&& echo H = true 		|| echo H = false
	%dk_call% Array::dk_includes ASCII I	&& echo I = true 		|| echo I = false
	%dk_call% Array::dk_includes ASCII J	&& echo J = true 		|| echo J = false
	%dk_call% Array::dk_includes ASCII K	&& echo K = true 		|| echo K = false
	%dk_call% Array::dk_includes ASCII L	&& echo L = true 		|| echo L = false
	%dk_call% Array::dk_includes ASCII M	&& echo M = true 		|| echo M = false
	%dk_call% Array::dk_includes ASCII N	&& echo N = true 		|| echo N = false
	%dk_call% Array::dk_includes ASCII O	&& echo O = true 		|| echo O = false
	%dk_call% Array::dk_includes ASCII P	&& echo P = true 		|| echo P = false
	%dk_call% Array::dk_includes ASCII Q	&& echo Q = true 		|| echo Q = false
	%dk_call% Array::dk_includes ASCII R	&& echo R = true 		|| echo R = false
	%dk_call% Array::dk_includes ASCII S	&& echo S = true 		|| echo S = false
	%dk_call% Array::dk_includes ASCII T	&& echo T = true 		|| echo T = false
	%dk_call% Array::dk_includes ASCII U	&& echo U = true 		|| echo U = false
	%dk_call% Array::dk_includes ASCII V	&& echo V = true 		|| echo V = false
	%dk_call% Array::dk_includes ASCII W	&& echo W = true 		|| echo W = false
	%dk_call% Array::dk_includes ASCII X	&& echo X = true 		|| echo X = false
	%dk_call% Array::dk_includes ASCII Y	&& echo Y = true 		|| echo Y = false
	%dk_call% Array::dk_includes ASCII Z	&& echo Z = true 		|| echo Z = false
	%dk_call% Array::dk_includes ASCII [	&& echo [ = true 		|| echo [ = false
	%dk_call% Array::dk_includes ASCII \	&& echo \ = true 		|| echo \ = false
	%dk_call% Array::dk_includes ASCII ]	&& echo ] = true 		|| echo ] = false
	%dk_call% Array::dk_includes ASCII ^	&& echo ^ = true 		|| echo ^ = false		&rem  FIXME
	%dk_call% Array::dk_includes ASCII _	&& echo _ = true 		|| echo _ = false
	%dk_call% Array::dk_includes ASCII `	&& echo ` = true 		|| echo ` = false
	%dk_call% Array::dk_includes ASCII a	&& echo a = true 		|| echo a = false
	%dk_call% Array::dk_includes ASCII b	&& echo b = true 		|| echo b = false
	%dk_call% Array::dk_includes ASCII c	&& echo c = true		|| echo c = false
	%dk_call% Array::dk_includes ASCII d	&& echo d = true 		|| echo d = false
	%dk_call% Array::dk_includes ASCII e	&& echo e = true 		|| echo e = false
	%dk_call% Array::dk_includes ASCII f	&& echo f = true 		|| echo f = false
	%dk_call% Array::dk_includes ASCII g	&& echo g = true 		|| echo g = false
	%dk_call% Array::dk_includes ASCII h	&& echo h = true 		|| echo h = false
	%dk_call% Array::dk_includes ASCII i	&& echo i = true 		|| echo i = false
	%dk_call% Array::dk_includes ASCII j	&& echo j = true 		|| echo j = false
	%dk_call% Array::dk_includes ASCII k	&& echo k = true 		|| echo k = false
	%dk_call% Array::dk_includes ASCII l	&& echo l = true 		|| echo l = false
	%dk_call% Array::dk_includes ASCII m	&& echo m = true 		|| echo m = false
	%dk_call% Array::dk_includes ASCII n	&& echo n = true 		|| echo n = false
	%dk_call% Array::dk_includes ASCII o	&& echo o = true 		|| echo o = false
	%dk_call% Array::dk_includes ASCII p	&& echo p = true 		|| echo p = false
	%dk_call% Array::dk_includes ASCII q	&& echo q = true 		|| echo q = false
	%dk_call% Array::dk_includes ASCII r	&& echo r = true 		|| echo r = false
	%dk_call% Array::dk_includes ASCII s	&& echo s = true 		|| echo s = false
	%dk_call% Array::dk_includes ASCII t	&& echo t = true 		|| echo t = false
	%dk_call% Array::dk_includes ASCII u	&& echo u = true 		|| echo u = false
	%dk_call% Array::dk_includes ASCII v	&& echo v = true 		|| echo v = false
	%dk_call% Array::dk_includes ASCII w	&& echo w = true 		|| echo w = false
	%dk_call% Array::dk_includes ASCII x	&& echo x = true 		|| echo x = false
	%dk_call% Array::dk_includes ASCII y	&& echo y = true 		|| echo y = false
	%dk_call% Array::dk_includes ASCII z	&& echo z = true 		|| echo z = false
	%dk_call% Array::dk_includes ASCII {	&& echo { = true 		|| echo { = false
rem	%dk_call% Array::dk_includes ASCII |	&& echo | = true 		|| echo | = false		&rem FIXME
	%dk_call% Array::dk_includes ASCII }	&& echo } = true 		|| echo } = false
	%dk_call% Array::dk_includes ASCII ~	&& echo ~ = true 		|| echo ~ = false
	
	%dk_call% dk_echo
	set "WORDS[0]=lower"
	set "WORDS[1]=UPPER"
	set "WORDS[2]=CaseSensitive"
	set "WORDS[3]=with space"
	set "WORDS[4]=__INNER__"
	set "WORDS[5]="withQuotes""
	%dk_call% dk_printVar WORDS
	%dk_call% dk_echo
	%dk_call% Array::dk_includes WORDS lower			&& echo lower = true				|| echo lower = false
	%dk_call% Array::dk_includes WORDS UPPER			&& echo UPPER = true				|| echo UPPER = false
	%dk_call% Array::dk_includes WORDS CASESENSITIVE	&& echo CASESENSITIVE = true		|| echo CASESENSITIVE = false
	%dk_call% Array::dk_includes WORDS "with space"		&& echo "with space" = true			|| echo "with space" = false
	%dk_call% Array::dk_includes WORDS INNER			&& echo INNER = true				|| echo INNER = false
	%dk_call% Array::dk_includes WORDS withQuotes		&& echo withQuotes = true 			|| echo withQuotes = false
	%dk_call% Array::dk_includes WORDS "withQuotes"		&& echo "withQuotes" = true			|| echo "withQuotes" = false

%endfunction%
