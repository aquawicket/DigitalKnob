@echo off

echo:
echo cmdlvl = %cmdlvl%
echo _0 = %_0%
echo f0 = %f0%
echo n0 = %n0%
echo p0 = %p0%
echo ALL = %ALL%
	
call getGlobal myVar
echo myvar = %myVar%