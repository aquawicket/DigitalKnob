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


rem ############################################################################
rem # dk_processMemUsage(procName)
rem #
rem #	memory usage returned in Kibibytes (KiB)
rem #
rem #		Reference: https://superuser.com/a/1128696
rem #		Reference: https://en.wikipedia.org/wiki/Data-rate_units
rem #
rem #	 ############ BINARY ############    ############# DECIMAL ############
rem #             								   Nibble =     4 Bits
rem #              (Bit) =    1 or 0               Byte (B) =     8 Bits
rem #     Kilobit (Kbit) = 1,000 Bits         Kilobyte (KB) = 1,024 Bytes
rem #     Megabit (Mbit) = 1,000 Kbits        Megabyte (MB) = 1,024 KB
rem #     Gigabit (Gbit) = 1,000 Mbits        Gigabyte (GB) = 1,024 MB
rem #     Terabit (Tbit) = 1,000 Gbits        Terabyte (TB) = 1,024 GB
rem #     Petabit (Pbit) = 1,000 Tbits        Petabyte (PB) = 1,024 TB
rem #      Exabit (Ebit) = 1,000 Pbits         Exabyte (GB) = 1,024 PB
rem #    Zettabit (Zbit) = 1,000 Ebits       Zettabyte (ZB) = 1,024 EB
rem #    Yottabit (Ybit) = 1,000 Zbits       Yottabyte (YB) = 1,024 ZB
rem #   Brontobit (Bbit) = 1,000 Ybits      Brontobyte (BB) = 1,024 YB
rem #
rem #		Name		Symbol		bit					byte				bit (formula)	byte (formula)
rem #		bit			Bit			1					0.125				1				1/8
rem #		byte 		B			8					1					8				1
rem #		kilobit 	kbit		1,000				125					10^3	⁠		1/8⁠ × 10^3
rem #		kibibit		Kibit		1,024				128					210				27
rem #		kilobyte	kB			8,000				1,000				8 × 10^3		10^3
rem #		kibibyte	KiB			8,192				1,024				2^13			2^10
rem #		megabit		Mbit		1,000,000			125,000				10^6	⁠		1/8⁠ × 10^6
rem #		mebibit		Mibit		1,048,576			131,072				2^20			2^17
rem #		megabyte	MB			8,000,000			1,000,000			8 × 10^6		10^6
rem #		mebibyte	MiB			8,388,608			1,048,576			2^23			2^20
rem #		gigabit		Gbit		1,000,000,000		125,000,000			10^9			1/8⁠ × 10^9
rem #		gibibit		Gibit		1,073,741,824		134,217,728			2^30			2^27
rem #		gigabyte	GB			8,000,000,000		1,000,000,000		8 × 10^9		10^9
rem #		gibibyte	GiB			8,589,934,592		1,073,741,824		2^33			2^30
rem #		terabit		Tbit		1,000,000,000,000	125,000,000,000		1012			⁠1/8⁠ × 1012
rem #		tebibit		Tibit		1,099,511,627,776	137,438,953,472		2^40			2^37
rem #		terabyte	TB			8,000,000,000,000	1,000,000,000,000	8 × 1012		1012
rem #		tebibyte	TiB			8,796,093,022,208	1,099,511,627,776	2^43			2^40

:dk_processMemUsage
%setlocal%

	set "procName=%~1"
	set /a "dk_processMemUsage=0"
	%dk_call% dk_validate WMIC.exe %dk_call% dk_findFile WMIC.exe
	%dk_call% dk_validate findstr.exe %dk_call% dk_findFile findstr.exe
	for /f %%G in ('%WMIC.exe:/=\% process where "Name='%procName%'" get WorkingSetSize^|%findstr.exe:/=\% [0-9]') do set /a "dk_processMemUsage+=%%G / 1024"
	
	
	endlocal & (
		set "dk_processMemUsage=%dk_processMemUsage%"
	)

%endfunction%











rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_processMemUsage cmd.exe
	%dk_call% dk_debug "cmd.exe memory usage = %dk_processMemUsage% KiB"
%endfunction%

