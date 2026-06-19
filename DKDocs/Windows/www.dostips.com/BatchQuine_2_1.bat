@Echo Off
Set "Src=www.Dostips.com"
Setlocal Disabledelayedexpansion
Set "T=Echo @Echo Off&Echo Set "Src=www.Dostips.com"&Echo Setlocal Disabledelayedexpansion&Echo Set "T=!T!"&Echo Set "U=!U!""
Set "U=Echo Cmd /V:On /C Cmd /V:On /C !T!&Cmd /V:On /C !U!"
Cmd /V:On /C Cmd /V:On /C !T!&Cmd /V:On /C !U!
