@echo off
  if "%~1"=="" (call :usage) else call :%*
pause
exit /b

:usage                             -- Library syntax and general info
::
::  CharLib.bat is a callable library of batch functions used to interconvert
::  between characters and numeric ASCII code values.
::
::  syntax:
::
::    [call] [path]CharLib function [arguments]
::
::  For a full list of available functions use:
::
::     CharLib help
::
::  For detailed help on a specific function use:
::
::     CharLib help FunctionName
::
::  All library functions give the correct result regardless whether delayed
::  expansion is enabled or disabled at the time of the call!
::
::  The following variables are reserved for this library and should only be
::  populated via a call to initLib:  ASCII_10, ASCII_13, ASCII_26
::
::  Some code and many coding techniques are from www.dostips.com
::  The rest is original work by Dave Benham
::  Special thanks and much credit to www.dostips.com member Jeb for providing
::  numerous techniques to deal with problematic non-printable characters, the
::  original idea to use !map:#%%c=! as a fast lookup mechanism for :asc
::  and :str2hex, and most importantly for incredible coding techniques to
::  facilitate return of ANY string across a function endlocal boundry,
::  even if the function was called while delayed expansion was enabled.
:::
::: Dependencies - :help
:::
  call :help Usage
exit /b


:rot13F  InFile [OutFile]          -- Applies the ROT13 cipher to a file
::
::  Applies the simple "rotate alphabet 13 places" cipher to the contents
::  of file InFile.
::
::  Writes the results to file OutFile
::  or displays the results if OutFile is not specified
::
::  OutFile should not contain ^ or ! in the name.
::
::  Warning - OutFile must not be the same as InFile. The file will be
::            deleted if InFile and OutFile are the same.
::
  setlocal disableDelayedExpansion
  set "outFile="
  if not "%~2"=="" (
    set outFile=^>^>"%~2"
    if exist "%~2" del "%~2"
  )
  set upper=#AAN#BBO#CCP#DDQ#EER#FFS#GGT#HHU#IIV#JJW#KKX#LLY#MMZ#NNA#OOB#PPC#QQD#RRE#SSF#TTG#UUH#VVI#WWJ#XXK#YYL#ZZM#
  set lower=#aan#bbo#ccp#ddq#eer#ffs#ggt#hhu#iiv#jjw#kkx#lly#mmz#nna#oob#ppc#qqd#rre#ssf#ttg#uuh#vvi#wwj#xxk#yyl#zzm#
  for /f "skip=2 tokens=1,* delims=[]" %%a in ('find /v /n "" %1') do (
    set "ln=%%b"
    setlocal enableDelayedExpansion
    set "str=A!ln!"
    set "len=0"
    for /L %%A in (12,-1,0) do (
      set /a "len|=1<<%%A"
      for %%B in (!len!) do if "!str:~%%B,1!"=="" set /a "len&=~1<<%%A"
    )
    set /a len-=1
    set rtn=
    for /l %%n in (0,1,!len!) do (
      set "c=!ln:~%%n,1!"
      if "!c!" geq "a" if "!c!" leq "Z" (
        for /f "delims=" %%c in ("!c!") do (
          set "test=!upper:*#%%c=!"
          if "!test:~0,1!"=="!c!" (
            set c=!test:~1,1!
          ) else (
            set "test=!lower:*#%%c=!"
            if "!test:~0,1!"=="!c!" set c=!test:~1,1!
          )
        )
      )
      set "rtn=!rtn!!c!"
    )
    echo:!rtn!%outFile%
    endlocal
  )
exit /b


:rot13   StrVar [RtnVar]           -- Applies the ROT13 cipher to a string
::
::  Applies the simple "rotate alphabet 13 places" cipher to the string
::  contained within variable StrVar.
::
::  Sets RtnVar=result
::  or displays result if RtnVar not specified
::
::  Note - This routine does not support carriage return or line feed
::  characters, though it would be easy to add this support using techniques
::  found in hex2str.
::
  setlocal
  set "NotDelayedFlag=!"
  setlocal enableDelayedExpansion
  set upper=#AAN#BBO#CCP#DDQ#EER#FFS#GGT#HHU#IIV#JJW#KKX#LLY#MMZ#NNA#OOB#PPC#QQD#RRE#SSF#TTG#UUH#VVI#WWJ#XXK#YYL#ZZM#
  set lower=#aan#bbo#ccp#ddq#eer#ffs#ggt#hhu#iiv#jjw#kkx#lly#mmz#nna#oob#ppc#qqd#rre#ssf#ttg#uuh#vvi#wwj#xxk#yyl#zzm#
  set "str=A!%~1!"
  set "len=0"
  for /L %%A in (12,-1,0) do (
    set /a "len|=1<<%%A"
    for %%B in (!len!) do if "!str:~%%B,1!"=="" set /a "len&=~1<<%%A"
  )
  set /a len-=1
  set rtn=
  for /l %%n in (0,1,!len!) do (
    set "c=!%~1:~%%n,1!"
    if "!c!" geq "a" if "!c!" leq "Z" (
      for /f "delims=" %%c in ("!c!") do (
        set "test=!upper:*#%%c=!"
        if "!test:~0,1!"=="!c!" (
          set c=!test:~1,1!
        ) else (
          set "test=!lower:*#%%c=!"
          if "!test:~0,1!"=="!c!" set c=!test:~1,1!
        )
      )
    )
    set "rtn=!rtn!!c!"
  )
  if "%~2"=="" (
    echo:!rtn!
    exit /b
  )
  if defined rtn (
    set "rtn=!rtn:%%=%%~3!"
    set "rtn=!rtn:"=%%~4!"
    if not defined NotDelayedFlag set "rtn=!rtn:^=^^^^!"
  )
  if defined rtn if not defined NotDelayedFlag set "rtn=%rtn:!=^^^!%" !
  set "replace=%% """"
  for /f "tokens=1,2" %%3 in ("!replace!") do (
    endlocal
    endlocal
    set "%~2=%rtn%" !
  )
exit /b


:str2hex StrVar [RtnVar]           -- Convert a string to hex digits
::
::  Converts the string contained within variable StrVar into a string of
::  ASCII codes, with each code represented as a pair of hexadecimal digits.
::  The length of the result will always be exactly twice the length of the
::  original string.
::
::  Sets RtnVar=result
::  or displays result if RtnVar not specified
:::
::: Dependencies - :_toAsciiMap, :_getLF, :_getCR, :StrLen
:::
  setlocal enableDelayedExpansion
	set "str=!%~1!"
  call :_toAsciiMap map
  call :StrLen str len
  set /a len-=1
  set rtn=
  set err=0
  for /l %%n in (0,1,%len%) do (
    set "c=!str:~%%n,1!"
    set "hex="
    if "!c!"==";" set hex=3B
    if "!c!"=="=" set hex=3D
    if "!c!"=="^!" set hex=21
    if not defined hex for /f "delims=" %%c in ("!c!") do (
      set "test=!map:*#%%c=!"
      if not "%%c"=="!test:~0,1!" set "test=!test:*#%%c=!"
      if "%%c"=="!test:~0,1!" set "hex=!test:~1,2!"
    )
    if not defined hex (
      if not defined ASCII_10 call :_getLF
      if "!c!"=="!ASCII_10!" set hex=0A
    )
    if not defined hex (
      if not defined ASCII_13 call :_getCR
      if "!c!"=="!ASCII_13!" set hex=0D
    )
    :: if not defined yet then must be 1A since all other viable characters are accounted for!
    if not defined hex set hex=1A
    set rtn=!rtn!!hex!
  )
  ( endlocal
    if "%~2" neq "" (set %~2=%rtn%) else echo:%rtn%
  )
exit /b 0


:hex2str [Options] HexVar [RtnVar] -- Convert hex digits to a string
::
::  Converts a string of hexadecimal digits contained within variable HexVar
::  into a string, where each pair of hex digits in the input represents the
::  ASCII code of a character in the result.
::
::  sets RtnVar=result
::  or displays the result if RtnVar is not specified
::
::  If any of the problematic characters below appear in the hex string
::  at least once then the indicated value is added to the errorlevel,
::  and the character may also be represented by a replacement string.
::  The absence of a Default Replacement indicates the character will be
::  represented as itself by default. The Default Replacement may be over-
::  ridden by one of the case insensitive options, where the str following
::  the option represents the replacement string. If there is no string after
::  the option then the character will be stripped from the output.
::
::                                               Default
::     Option  Hex  Character        errorlevel  Replacement
::     ------  ---  ---------------  ----------  -----------
::     /Nstr    00  null                 1       <NUL>
::     /Lstr    0A  line feed            2
::     /Cstr    0D  carriage return      4
::     /Estr   invalid-hex-digit         8       <ERR>
::
::  If the final output contains a carriage return or line feed, then the
::  rtnVar variable should only be accessed via delayed substitution.
::
::  If the hex string contains 1A then the function will briefly create a
::  temporary file to generate the correct SUB character. The location of
::  the file is specified by the %TEMP% or %TMP% variable, or the current
::  directory if neither variable is defined.
::
::  Aborts with an error message to stderr and errorlevel 16 if the hex string
::  length is not divisible by 2.
:::
::: Dependencies - :_fromAsciiMap, :_getLF, :_getCR, :_getSUB, :StrLen, :Unique
:::
  setlocal
  set "NotDelayedFlag=!"
  setlocal enableDelayedExpansion
  call :_fromAsciiMap map
  set "nulStr=<NUL>"
  set "errStr=<ERR>"
  set lfStr=
  set crStr=
  set subStr=
  set lfSkip=
  set crSkip=
  set shiftCnt=0
  set skip=
  for %%a in (%*) do (
    if not defined skip (
      set "arg=%%~a"
      if not "!arg:~0,1!"=="/" (
        set skip=true
      ) else (
        set "opt=!arg:~1,1!"
        set "str=!arg:~2!"
        if /i "!opt!"=="N" set "nulStr=!str!"
        if /i "!opt!"=="L" set "lfStr=!str!" & set "lfSkip=true"
        if /i "!opt!"=="C" set "crStr=!str!" & set "crSkip=true"
        if /i "!opt!"=="E" set "errStr=!str!"
        set /a shiftCnt+=1
      )
    )
  )
  for /l %%n in (1,1,%shiftCnt%) do shift /1
  call :StrLen %~1 len
  set /a mod=len%%2
  if %mod%==1 1>&2 echo ERROR: Hex string length not a multiple of 2& exit /b 16
  set rtn=
  set /a len-=1
  set err=0
  for /l %%n in (0,2,%len%) do (
    set "d="
    2>nul set /a d=0x!%~1:~%%n,2!
    if not defined d (
        set "c=!errStr!"
        set /a "err|=8"
    ) else if !d!==0 (
        set "c=!nulStr!"
        set /a "err|=1"
    ) else if !d!==10 (
        if not defined lfStr if not defined lfSkip (if not defined ASCII_10 call :_getLF)& set lfStr=!ASCII_10!
        set "c=!lfStr!"
        set /a "err|=2"
    ) else if !d!==13 (
        if not defined crStr if not defined crSkip (if not defined ASCII_13 call :_getCR)& set crStr=!ASCII_13!
        set "c=!crStr!"
        set /a "err|=4"
    ) else if !d!==26 (
        if not defined subStr (if not defined ASCII_26 call :_getSUB)& set subStr=!ASCII_26!
        set "c=!subStr!"
    ) else for %%d in (!d!) do set c=^!map:~%%d,1!
    set "rtn=!rtn!!c!"
  )
  if "%~2"=="" (
    echo:!rtn!
    exit /b %err%
  )
  if defined rtn (
    set "rtn=!rtn:%%=%%~3!"
    set "rtn=!rtn:"=%%~4!"
    if defined ASCII_13 for %%a in ("!ASCII_13!") do set "rtn=!rtn:%%~a=%%~5!"
    if defined ASCII_10 for %%a in ("!ASCII_10!") do set "rtn=!rtn:%%~a=%%~6!"
    if not defined NotDelayedFlag set "rtn=!rtn:^=^^^^!"
  )
  if defined rtn if not defined NotDelayedFlag set "rtn=%rtn:!=^^^!%" !
  set "replace=%% """ !ASCII_13!!ASCII_13!"
  for %%6 in ("!ASCII_10!") do (
    for /F "tokens=1,2,3" %%3 in ("!replace!") DO (
      endlocal
      endlocal
      set "%~2=%rtn%" !
      exit /b %err%
    )
  )
exit /b


:asc     StrVar IntVal [RtnVar]    -- Compute the ASCII code of a character
::
::  Computes the numeric ASCII code for a specified character within the
::  string contained by variable StrVar. The position within the string is
::  specified by the IntVal argument. A non-negative value is relative to the
::  beginning of the string, with 0 specifiying the first character. A
::  negative value is relative to the end of the string, with -1 specifying
::  the last character.
::
::  Sets RtnVar=result
::  or displays result if RtnVar not specified
::
::  IntVal may be passed as any numeric expression supported by SET /A.
::
::  If IntVal is not a valid number then aborts with an error message to
::  stderr and errorlevel 1.
::
::  If StrVar is not defined then aborts with an error message to stderr and
::  errorlevel 2.
::
::  If IntVal is greater than or equal to the length of the string then aborts
::  with an error message to stderr and errorlevel 3.
::
::  Negative IntVal values will never result in errorlevel 3: Positions earlier
::  than the 1st character are treated as the 1st character.
:::
::: Dependencies - :_toAsciiMap, :_getLF, :_getCR
:::
  setlocal enableDelayedExpansion
  if "%~1"=="" echo ERROR: Missing argument&exit /b 1
  if not defined %~1 1>&2 echo ERROR: Variable not defined&exit /b 2
  set "str=!%~1!"
  set /a "n=%~2" 2>nul
  if errorlevel 1 1>&2 echo ERROR: Invalid numeric value&exit /b 1
  set "chr=!str:~%n%,1!"
  if not defined chr 1>&2 echo ERROR: String position not found&exit /b 3
  call :_toAsciiMap map
  set "rtn="
  if "!chr!"==";" set rtn=59
  if "!chr!"=="=" set rtn=61
  if "!chr!"=="^!" set rtn=33
  if not defined rtn for /f "delims=" %%c in ("!chr!") do (
    set "test=!map:*#%%c=!"
    if not "%%c"=="!test:~0,1!" set "test=!test:*#%%c=!"
    if "%%c"=="!test:~0,1!" set /a "rtn=0x!test:~1,2!"
  )
  if not defined rtn (
    if not defined ASCII_10 call :_getLF
    if "!chr!"=="!ASCII_10!" set rtn=10
  )
  if not defined rtn (
    if not defined ASCII_13 call :_getCR
    if "!chr!"=="!ASCII_13!" set rtn=13
  )
  :: if not defined yet then must be 26 since all other viable characters are accounted for!
  if not defined rtn set rtn=26
  (endlocal & rem -- return values
    if "%~3" neq "" (set %~3=%rtn%) else (echo:%rtn%)
    exit /b 0
  )
exit /b


:chr     IntVal [RtnVar]           -- Return a character based on ASCII code
::
::  Converts numeric ASCII code IntVal into the corresponding character.
::
::  Sets RtnVar=result
::  or displays result if RtnVar not specified
::
::  IntVal must be a value between 0 and 255. Aborts with a message to stderr
::  and errorlevel 1 if not.
::
::  RtnVar will be undefined (or nothing will be displayed) if IntVal=0
::
::  IntVal may be passed as any numeric expression supported by SET /A.
::
::  If IntVal=26 then the function will briefly create a temporary file to
::  generate the correct SUB character. The location of the file is specified
::  by the %TEMP% or %TMP% variable, or the current directory if neither
::  variable is defined.
:::
::: Dependencies - :_fromAsciiMap, :_getLF, :_getCR, :_getSUB, :Unique
:::
  setlocal
  set "NotDelayedFlag=!"
  setlocal EnableDelayedExpansion
  set /a n=%~1 2>nul && (if defined err set err=) || (set "n=x" & set err=1)
  if not defined err if %n% lss 0 set err=1
  if not defined err if %n% gtr 255 set err=1
  if defined err 1>&2 echo ERROR: Invalid ASCII Code&exit /b %err%
  if %n%==0 (
     endlocal&endlocal
     if "%~2" neq "" (set "%~2=")
     exit /b 0
  )
  call :_fromAsciiMap ascii
  if %n%==32 (
      set "c= "
  ) else if %n%==59 (
      set "c=;"
  ) else if %n%==10 (
      if not defined ASCII_10 call :_getLF
      set "c=!ASCII_10!"
  ) else if %n%==13 (
      if not defined ASCII_13 call :_getCR
      set "c=!ASCII_13!"
  ) else if %n%==26 (
      if not defined ASCII_26 call :_getSUB
      set "c=!ASCII_26!"
  ) else (
      set "c=!ascii:~%n%,1!"
  )
  if "%~2"=="" (
    echo:!c!
    exit /b 0
  )
  set "rtn=!c:%%=%%~3!"
  set "rtn=!rtn:"=%%~4!"
  if defined ASCII_13 for %%a in ("!ASCII_13!") do set "rtn=!rtn:%%~a=%%~5!"
  if defined ASCII_10 for %%a in ("!ASCII_10!") do set "rtn=!rtn:%%~a=%%~6!"
  if not defined NotDelayedFlag set "rtn=!rtn:^=^^^^!"
  if not defined NotDelayedFlag set "rtn=%rtn:!=^^^!%" !
  set "replace=%% """ !ASCII_13!!ASCII_13!"
  for %%6 in ("!ASCII_10!") do (
    for /F "tokens=1,2,3" %%3 in ("!replace!") DO (
      endlocal&endlocal
      set "%~2=%rtn%" !
      exit /b %err%
    )
  )
exit /b 0


:_toAsciiMap  rtnVar  -- Creates a map useful for converting a char to ASCII
::
::  Sets variable rtnVar to a string useful for converting characters into
::  their numeric ASCII code values using hexadecimal notation. The following
::  characters are not represented: 0x00, 0x0A, 0x0D, 0x1A. The following
::  characters are represented but are difficult to extract: 0x21, 0x3B, 0x3D.
::
  setlocal
  set "NotDelayedFlag=!"
  setlocal DisableDelayedExpansion
  set rtn=xxx#01#02#03#04#05#06#07#08#		09#0B#0C#0E#0F#10#11#12#13#14#15#16#17#18#19#1B#1C#1D#1E#1F#  20#!!21#%%~B%%~B22###23#$$24#%%~A%%~A25#^&^&26#''27#^(^(28#^)^)29#**2A#++2B#,,2C#--2D#..2E#//2F#0030#1131#2232#3333#4434#5535#6636#7737#8838#9939#::3A#;;3B#^<^<3C#==3D#^>^>3E#??3F#@@40#AA41#BB42#CC43#DD44#EE45#FF46#GG47#HH48#II49#JJ4A#KK4B#LL4C#MM4D#NN4E#OO4F#PP50#QQ51#RR52#SS53#TT54#UU55#VV56#WW57#XX58#YY59#ZZ5A#[[5B#\\5C#]]5D#^^^^5E#__5F#``60#aa61#bb62#cc63#dd64#ee65#ff66#gg67#hh68#ii69#jj6A#kk6B#ll6C#mm6D#nn6E#oo6F#pp70#qq71#rr72#ss73#tt74#uu75#vv76#ww77#xx78#yy79#zz7A#{{7B#^|^|7C#}}7D#~~7E#7F#ÄÄ80#ÅÅ81#ÇÇ82#ÉÉ83#ÑÑ84#ÖÖ85#ÜÜ86#áá87#àà88#ââ89#ää8A#ãã8B#åå8C#çç8D#éé8E#èè8F#êê90#ëë91#íí92#ìì93#îî94#ïï95#ññ96#óó97#òò98#ôô99#öö9A#õõ9B#úú9C#ùù9D#ûû9E#üü9F#††A0#°°A1#¢¢A2#££A3#§§A4#••A5#¶¶A6#ßßA7#®®A8#©©A9#™™AA#´´AB#¨¨AC#≠≠AD#ÆÆAE#ØØAF#∞∞B0#±±B1#≤≤B2#≥≥B3#¥¥B4#µµB5#∂∂B6#∑∑B7#∏∏B8#ππB9#∫∫BA#ªªBB#ººBC#ΩΩBD#ææBE#øøBF#¿¿C0#¡¡C1#¬¬C2#√√C3#ƒƒC4#≈≈C5#∆∆C6#««C7#»»C8#……C9#  CA#ÀÀCB#ÃÃCC#ÕÕCD#ŒŒCE#œœCF#––D0#——D1#““D2#””D3#‘‘D4#’’D5#÷÷D6#◊◊D7#ÿÿD8#ŸŸD9#⁄⁄DA#€€DB#‹‹DC#››DD#ﬁﬁDE#ﬂﬂDF#‡‡E0#··E1#‚‚E2#„„E3#‰‰E4#ÂÂE5#ÊÊE6#ÁÁE7#ËËE8#ÈÈE9#ÍÍEA#ÎÎEB#ÏÏEC#ÌÌED#ÓÓEE#ÔÔEF#F0#ÒÒF1#ÚÚF2#ÛÛF3#ÙÙF4#ııF5#ˆˆF6#˜˜F7#¯¯F8#˘˘F9#˙˙FA#˚˚FB#¸¸FC#˝˝FD#˛˛FE#ˇˇFF#
  setlocal EnableDelayedExpansion
  if not defined NotDelayedFlag set "rtn=!rtn:^=^^^^!"
  if not defined NotDelayedFlag set "rtn=%rtn:!=^^^!%" !
  set "replace=%% """"
  for /F "tokens=1,2" %%A in ("!replace!") DO (
    endlocal&endlocal&endlocal
    set "%~1=%rtn%" !
    exit /b 0
  )
exit /b


:_fromAsciiMap rtnVar -- Creates a map useful for converting ASCII to a char
::
::  Sets variable rtnVar to a 256 character string containing the complete
::  extended ASCII character set except a space has been substituted for each
::  of the following problematic characters: 0x00, 0x0A, 0x0D, 0x1A.
::  The string is particularly well suited to convert a numeric ASCII code
::  into the corresponding character.
::
  setlocal
  set "NotDelayedFlag=!"
  setlocal DisableDelayedExpansion
  set rtn= 	    !%%~B#$%%~A^&'^(^)*+,-./0123456789:;^<=^>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^^_`abcdefghijklmnopqrstuvwxyz{^|}~ÄÅÇÉÑÖÜáàâäãåçéèêëíìîïñóòôöõúùûü†°¢£§•¶ß®©™´¨≠ÆØ∞±≤≥¥µ∂∑∏π∫ªºΩæø¿¡¬√ƒ≈∆«»… ÀÃÕŒœ–—“”‘’÷◊ÿŸ⁄€‹›ﬁﬂ‡·‚„‰ÂÊÁËÈÍÎÏÌÓÔÒÚÛÙıˆ˜¯˘˙˚¸˝˛ˇ
  setlocal EnableDelayedExpansion
  if not defined NotDelayedFlag set "rtn=!rtn:^=^^^^!"
  if not defined NotDelayedFlag set "rtn=%rtn:!=^^^!%" !
  set "replace=%% """"
  for /F "tokens=1,2" %%A in ("!replace!") DO (
    endlocal&endlocal&endlocal
    set "%~1=%rtn%" !
    exit /b 0
  )
exit /b


:initLib                           -- Improves performance of library
::
::  Improves library performance by pre-populating the following variables:
::    ASCII_10
::    ASCII_13
::    ASCII_26
::
::  Once set, these values should never be altered.
::
::  If this function is not called, then these characters may need to be
::  created with each function call.
::
  call :_getLF
  call :_getCR
  call :_getSUB
exit /b


:_getLF   -- Sets ASCII_10 to a line feed (0x0A) character
  if not defined ASCII_10 set ASCII_10=^


:: The above 2 blank lines MUST be preserved!
exit /b


:_getCR   -- Sets ASCII_13 to a carriage return (0x0D) character
  if not defined ASCII_13 for /f %%a in ('copy /Z "%~dpf0" nul') do set "ASCII_13=%%a"
exit /b


:_getSUB   -- sets ASCII_26 to the ASCII code 26 (0x1A) character
::
:: Briefly creates a temporary file with a unique name that should prevent
:: collisions in a shared environment.
:::
::: Dependencies - :Unique
:::
  if defined ASCII_26 exit /b
  setlocal disableDelayedExpansion
  call :Unique file
  if defined temp (set filePath=%temp%) else if defined tmp (set filePath=%tmp%) else set filePath=.
  set file="%filePath%\_getSUB_%file%_%random%.tmp"
  copy /a nul+nul %file% > nul
  for /f "usebackq" %%a in (%file%) do set "SUB=%%a"
  del %file%
  (endlocal
    set ASCII_26=%SUB%
  )
exit /b


:help    [ /I | FuncName ]         -- Help for this library
::
::  Displays help about function FuncName
::
::  If FuncName is not specified then lists all available functions
::
::  The case insensitive /I option adds Internal functions to the list
::  of availabile functions.
::
  setlocal disableDelayedExpansion
  set file="%~f0"
  echo:
  set _=
  if /i "%~1"=="/I" (set _=_) else if not "%~1"=="" goto :help.func
  for /f "tokens=* delims=:" %%a in ('findstr /r /c:"^:[%_%0-9A-Za-z]* " /c:"^:[%_%0-9A-Za-z]*$" %file%^|sort') do echo:  %%a
  exit /b
  :help.func
  set beg=
  for /f "tokens=1,* delims=:" %%a in ('findstr /n /r /i /c:"^:%~1 " /c:"^:%~1$" %file%') do (
    if not defined beg set beg=%%a
  )
  if not defined beg (1>&2 echo: Function %~1 not found) & exit /b 1
  set end=
  for /f "tokens=1 delims=:" %%a in ('findstr /n /r /c:"^[^:]" %file%') do (
    if not defined end if %beg% LSS %%a set end=%%a
  )
  for /f "tokens=1,* delims=[]:" %%a in ('findstr /n /r /c:"^ *:[^:]" /c:"^::[^:]" /c:"^ *::$" %file%') do (
    if %beg% LEQ %%a if %%a LEQ %end% echo: %%b
  )
exit /b 0


::-----------------------------------------------------------------------------
:: The following are existing functions found at www.dostips.com
::-----------------------------------------------------------------------------

:StrLen  string len                -- returns the length of a string
::                 -- string [in]  - variable name containing the string being measured for length
::                 -- len    [out] - variable to be used to return the string length
:: Many thanks to 'sowgtsoi', but also 'jeb' and 'amel27' dostips forum users helped making this short and efficient
:$created 20081122 :$changed 20101116 :$categories StringOperation
:$source http://www.dostips.com
(   SETLOCAL ENABLEDELAYEDEXPANSION
    set "str=A!%~1!"&rem keep the A up front to ensure we get the length and not the upper bound
                     rem it also avoids trouble in case of empty string
    set "len=0"
    for /L %%A in (12,-1,0) do (
        set /a "len|=1<<%%A"
        for %%B in (!len!) do if "!str:~%%B,1!"=="" set /a "len&=~1<<%%A"
    )
)
( ENDLOCAL & REM RETURN VALUES
    IF "%~2" NEQ "" SET /a %~2=%len%
)
EXIT /b

:Unique  ret  -- returns a unique string based on a date-time-stamp, YYYYMMDDhhmmsscc
::          -- ret    [out,opt] - unique string
:$created 20060101 :$changed 20080219 :$categories StringOperation,DateAndTime
:$source http://www.dostips.com
SETLOCAL
for /f "skip=1 tokens=2-4 delims=(-)" %%a in ('"echo.|date"') do (
    for /f "tokens=1-3 delims=/.- " %%A in ("%date:* =%") do (
        set %%a=%%A&set %%b=%%B&set %%c=%%C))
set /a "yy=10000%yy% %%10000,mm=100%mm% %% 100,dd=100%dd% %% 100"
for /f "tokens=1-4 delims=:. " %%A in ("%time: =0%") do @set UNIQUE=%yy%%mm%%dd%%%A%%B%%C%%D
ENDLOCAL & IF "%~1" NEQ "" (SET %~1=%UNIQUE%) ELSE echo.%UNIQUE%
EXIT /b


::-----------------------------------------------------------------------------
:: The remainder are test cases for the library
::-----------------------------------------------------------------------------

:test                              -- Test cases for this library
::
::  Tests the behaviour of all the functions within this library.
::
  setlocal
  call :initLib

  echo:
  echo Testing :chr and :asc for all viable ASCII values
  echo -------------------------------------------------
  setlocal enableDelayedExpansion
  set char=
  set rtn=
  for /l %%n in (1,1,255) do (
    call :chr %1 %%n char
    call :asc %1 char 0 rtn
    if "%%n"=="!rtn!" (set status=OK) else (set status=ERROR)
    echo:    !status! - "%%n:!char!:!rtn!"
  )
  endlocal
  echo:
  echo Testing :asc argument variations and error conditions
  echo ------------------------------------------------------
  set rtn=
  for %%s in (
    "asc,"
    "asc str,"
    "asc str 0,"
    "asc str 09,ABCXYZ Invalid octal notation"
    "asc str 0,ABCXYZ"
    "asc str 5,ABCXYZ"
    "asc str 6,ABCXYZ"
    "asc str -1,ABCXYZ"
    "asc str 1-2,Test numeric expression ABCXYZ"
    "asc str -6,ABCXYZ"
    "asc str -1000,ABCXYZ Negative position never extends beyond beginning"
  ) do (
    for /f "tokens=1,2 delims=," %%a in (%%s) do (
      setlocal enableDelayedExpansion
      echo ^>set "str=%%b"
      echo ^>call :%%~a
      set "str=%%b"
      call :%%~a
      echo errorlevel=!errorlevel!
      echo:
      endlocal
    )
  )
  
  echo:
  echo Testing :chr error conditions and numeric expresions
  echo ----------------------------------------------------
  for %%c in (
    "chr 64+1 rtn"
    "chr 0 rtn"
    "chr"
    "chr 09 rtn Note this is an invalid octal notation"
    "chr -1 rtn"
    "chr 256 rtn"
  ) do (
    setlocal enableDelayedExpansion
    echo ^>call :%%~c
    call :%%~c
    echo errorlevel=!errorlevel!
    set rtn
    endlocal
    echo:
  )
  
  echo:
  echo Testing :str2Hex and :hex2Str with normal characters
  echo ----------------------------------------------------
  setlocal enableDelayedExpansion
  prompt $g
  echo on
  echo off&call :_fromAsciiMap str1
  set str1 & echo on
  echo off&call :str2hex str1 hex
  set hex & echo on
  echo off&call :hex2str hex str2
  echo errorlevel=%errorlevel%
  set str2
  echo on
  if "!str1!"=="!str2!" (echo OK) else (echo ERROR)
  @echo off
  endlocal
  
  echo:
  echo Testing :hex2Str with problematic characters
  echo ---------------------------------------------------------
  setlocal disableDelayedExpansion
  prompt $g
  set hex=000D1A0AXX
  set hex
  echo on
  echo off&call :hex2str hex _str
  echo errorlevel=%errorlevel%
  set _str
  echo:
  
  set hex=000D1A0AXX
  set hex
  echo on
  echo off&call :hex2str "/n<null>" "/c<cr>" "/l<lf>" "/e<error>" hex
  echo errorlevel=%errorlevel%
  echo:
  
  set hex=000D0AXX
  set hex
  echo on
  echo off&call :hex2str /n /c /l /e hex _str
  echo errorlevel=%errorlevel%
  set _str
  echo:
  
  set hex=00
  set hex
  echo on
  echo off&call :hex2str hex
  echo errorlevel=%errorlevel%
  echo:
  
  set hex=0a
  set hex
  echo on
  echo off&call :hex2str "/l<LF>" hex
  echo errorlevel=%errorlevel%
  echo:
  
  set hex=0d
  set hex
  echo on
  echo off&call :hex2str "/c<CR>" hex
  echo errorlevel=%errorlevel%
  echo:
  
  set hex=XX
  set hex
  echo on
  echo off&call :hex2str hex
  echo errorlevel=%errorlevel%
  echo:
  
  set hex=oddLength
  set hex
  echo on
  echo off&call :hex2str hex
  echo errorlevel=%errorlevel%
  echo:

  endlocal

  echo:
  echo Testing :str2hex with problematic characters
  echo ---------------------------------------------------------
  setlocal enableDelayedExpansion
  prompt $g
  set hex1=0D0A1A
  set hex1
  echo:
  echo on
  echo off&call :hex2str hex1 _str
  echo errorlevel=%errorlevel%
  set _str
  echo on
  echo off&call :str2hex _str hex2
  set hex2
  echo on
  if "!hex1!"=="!hex2!" (echo OK) else (echo ERROR)
  @echo off
  endlocal

  echo:
  echo Testing :rot13
  echo --------------------------------------------------------
  setlocal disableDelayedExpansion
  set alpha=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz
  set alpha
  call :rot13 alpha rot13
  set rot13
  endlocal

  echo:
  echo Testing :rot13F
  echo --------------------------------------------------------
  echo on
  echo off & call :rot13F "%~f0" "%temp%\rot13F_Test1.txt"
  echo on
  echo off & call :rot13F "%temp%\rot13F_Test1.txt" "%temp%\rot13F_Test2.txt"
  fc "%~f0" "%temp%\rot13F_Test2.txt"
  del "%temp%\rot13F_Test?.txt"

exit /b
