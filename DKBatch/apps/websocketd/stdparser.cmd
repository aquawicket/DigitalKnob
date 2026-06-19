@ECHO OFF

(set ESC=)
(set CSI=%ESC%[)
(set clr=%CSI%0m)
(set red=%CSI%31m)
(
echo stdout
echo %red%stderr%clr% 1>&2
echo fd3 1>&3
echo con >CON
cmd 
) 2>&1 


::(cmd | echo prefix) 2>&1
::cmd 2>>&3 3>&1
::cmd echo prefix >>&2 2>&1