@echo off
setlocal EnableDelayedExpansion

rem Assemble a two-dimensional rectangular table from two lists of different sizes
rem We need to expand the entire second list in the expansion of *each term* of the first list
rem and each cell should access values from both its column and its row

set "cols=A.B.C.D.E.F.G.H"
set "rows=1 2 3 4 5 "  & rem <- a space at end!

set "allCols=!cols:.=-%%R%%  !-%%R%%"
set "R=%rows: =" & call set "line=!allCols!" & echo !line! & set "R=%"

pause