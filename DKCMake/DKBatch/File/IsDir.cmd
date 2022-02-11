%dkbatch%



for /f "tokens=1,2 delims=d" %%A in ("-%~a1") do if "%%B" neq "" (
  echo %1 is a folder
) else  (
  echo %1 is a file
) 
 
%DKEND% 
