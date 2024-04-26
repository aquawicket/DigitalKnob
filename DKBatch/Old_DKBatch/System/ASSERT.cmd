@echo off

::	0
echo|set /p= "ASSERT  0		"
call:ASSERT 0

::	1
echo|set /p= "ASSERT  1		"
call:ASSERT 1

::	'0'
echo|set /p= "ASSERT '0'		"
call:ASSERT '0'

::	'1'
echo|set /p= "ASSERT '1'		"
call:ASSERT '1'

::	"0"
echo|set /p= "ASSERT "0"		"
call:ASSERT "0"

::	"1"
echo|set /p= "ASSERT "1"		"
call:ASSERT "1"

::	stringA
echo|set /p= "ASSERT stringA		"
call:ASSERT stringA

::	'stringB'
echo|set /p= "ASSERT 'stringB'	"
call:ASSERT 'stringB'

::	"stringC"
echo|set /p= "ASSERT "stringC"	"
call:ASSERT "stringC"

::	%var%
set "var="
echo|set /p= "ASSERT %%var		"
call:ASSERT %var%

::	%var_A%
set "var_A=a"
echo|set /p= "ASSERT %%var_A		"
call:ASSERT %var_A%

::	'%vaB%'
set "var_B=b"
echo|set /p= "ASSERT '%%var_B'		"
call:ASSERT '%var_B%'

::	"%var_C%"
set "var_C=c"
echo|set /p= "ASSERT "%%var_C"		"
call:ASSERT "%var_C%"

::	%%var_D%%
set "var_D=d"
echo|set /p= "ASSERT %%%var_D		"
call:ASSERT %%var_D%%

::	'%%vaE%%'
set "var_E=e"
echo|set /p= "ASSERT '%%%var_E'		"
call:ASSERT '%%var_E%%'

::	"%%var_F%%"
set "var_F=f"
echo|set /p= "ASSERT "%%%var_F"		"
call:ASSERT "%%var_F%%"

::	%var_G%
set "var_G="
echo|set /p= "ASSERT %%var_G		"
call:ASSERT %var_G%

::	'%vaH%'
set "var_H="
echo|set /p= "ASSERT '%%var_H'		"
call:ASSERT '%var_H%'

::	"%var_I%"
set "var_I="
echo|set /p= "ASSERT "%%var_I"		"
call:ASSERT "%var_I%"

::
echo|set /p= "ASSERT  		"
call:ASSERT

pause & goto:eof


:ASSERT
	if [%1]==[] goto:is_false
	if [%1]==[''] goto:is_false
	if [%1]==[""] goto:is_false
	
	if not %~1 LSS 1 echo ^[32m %1 = true ^[0m & goto:eof
	
	:is_false
	echo ^[31m %1 = false ^[0m
goto:eof