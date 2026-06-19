@echo off
setlocal enableDelayedExpansion

set str=EXAMPLE Content-Disposition: attachment; filename=VC_redist.x86.exe; filename*=UTF-8''VC_redist.x86.exe
echo %str%
for %%a in (%str%) do (
	echo a = %%a
	if not defined filename (
		if defined getNext (set filename=%%a)
		if "%%a" equ "filename" set getNext=%%a
	)
)
echo filename = '%filename%'








set i=1
set "str!i!=!str:; =" & set /a i+=1 & set "str!i!=!"
set str


pause