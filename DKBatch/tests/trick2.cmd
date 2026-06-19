@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION

SET "cols=A.B.C.D.E.F.G.H."
SET "rows=1 2 3 4 5"

SET str=]!cols:.=-%rows: =[  ]!& SET print=!str:~0,-2! & ECHO !print! & SET str=]!cols:.=-%[  ]! & ECHO !str:~0,-2!

PAUSE
EXIT /B