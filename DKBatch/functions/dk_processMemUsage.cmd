@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::############################################################################
::# dk_processMemUsage(procName)
::#
::#		Reference: https://superuser.com/a/1128696
::#		Reference: https://en.wikipedia.org/wiki/Data-rate_units
::#
::#	 ############ BINARY ############    ############# DECIMAL ############
::#             								   Nibble =     4 Bits
::#              (Bit) =    1 or 0               Byte (B) =     8 Bits
::#     Kilobit (Kbit) = 1,000 Bits         Kilobyte (KB) = 1,024 Bytes
::#     Megabit (Mbit) = 1,000 Kbits        Megabyte (MB) = 1,024 KB
::#     Gigabit (Gbit) = 1,000 Mbits        Gigabyte (GB) = 1,024 MB
::#     Terabit (Tbit) = 1,000 Gbits        Terabyte (TB) = 1,024 GB
::#     Petabit (Pbit) = 1,000 Tbits        Petabyte (PB) = 1,024 TB
::#      Exabit (Ebit) = 1,000 Pbits         Exabyte (GB) = 1,024 PB
::#    Zettabit (Zbit) = 1,000 Ebits       Zettabyte (ZB) = 1,024 EB
::#    Yottabit (Ybit) = 1,000 Zbits       Yottabyte (YB) = 1,024 ZB
::#   Brontobit (Bbit) = 1,000 Ybits      Brontobyte (BB) = 1,024 YB
::#
::#		Name		Symbol		bit					byte				bit (formula)	byte (formula)
::#		bit			Bit			1					0.125				1				1/8
::#		byte 		B			8					1					8				1
::#		kilobit 	kbit		1,000				125					10^3	⁠		1/8⁠ × 10^3
::#		kibibit		Kibit		1,024				128					210				27
::#		kilobyte	kB			8,000				1,000				8 × 10^3		10^3
::#		kibibyte	KiB			8,192				1,024				2^13			2^10
::#		megabit		Mbit		1,000,000			125,000				10^6	⁠		1/8⁠ × 10^6
::#		mebibit		Mibit		1,048,576			131,072				2^20			2^17
::#		megabyte	MB			8,000,000			1,000,000			8 × 10^6		10^6
::#		mebibyte	MiB			8,388,608			1,048,576			2^23			2^20
::#		gigabit		Gbit		1,000,000,000		125,000,000			10^9			1/8⁠ × 10^9
::#		gibibit		Gibit		1,073,741,824		134,217,728			2^30			2^27
::#		gigabyte	GB			8,000,000,000		1,000,000,000		8 × 10^9		10^9
::#		gibibyte	GiB			8,589,934,592		1,073,741,824		2^33			2^30
::#		terabit		Tbit		1,000,000,000,000	125,000,000,000		1012			⁠1/8⁠ × 1012
::#		tebibit		Tibit		1,099,511,627,776	137,438,953,472		2^40			2^37
::#		terabyte	TB			8,000,000,000,000	1,000,000,000,000	8 × 1012		1012
::#		tebibyte	TiB			8,796,093,022,208	1,099,511,627,776	2^43			2^40

:dk_processMemUsage
%setlocal%

	set "procName=%~1"
	set /a "dk_processMemUsage=0"
	for /f %%G in ('wmic process where "Name='%procName%'" get WorkingSetSize^|findstr [0-9]') do set /a "dk_processMemUsage+=%%G / 1024"
	
	::### memory usage returned in Kibibytes (KiB)
	endlocal & (
		set "dk_processMemUsage=%dk_processMemUsage%"
	)

%endfunction%











::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_processMemUsage cmd.exe
	echo cmd.exe memory usage = %dk_processMemUsage% KiB
%endfunction%

