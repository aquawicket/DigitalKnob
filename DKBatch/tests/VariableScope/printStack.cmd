@echo off

echo ######### stack #########
for /l %%n in (1, 1, !lvl!) do echo %%n: !STACK%_%%n!