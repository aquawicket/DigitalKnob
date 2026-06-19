@echo off
setlocal EnableDelayedExpansion

set "cols=A.B.C.D.E.F.G.H"
set "rows=1 2 3 4 5 "  & rem <- a space at end!

set "R=%rows: =" & echo Row !R! - Cols: ^<!cols:.=^>  ^<!^> & set "R=%"


pause