Windows Registry Editor Version 5.00
;@(cls & %__AppDir__%reg.exe import "%~f0" & pause & goto :eof)

[-HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.bat]
[-HKCU\Software\Classes\.bat]
[-HKCU\SOFTWARE\Classes\batfile]

[HKLM\SOFTWARE\Classes\.bat]
@="batfile"

[HKLM\SOFTWARE\Classes\batfile\shell\open\command]
@="\"%1\" %*"


[-HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cmd]
[-HKCU\Software\Classes\.cmd]
[-HKCU\SOFTWARE\Classes\cmdfile]

[HKLM\SOFTWARE\Classes\.cmd]
@="cmdfile"

[HKLM\SOFTWARE\Classes\cmdfile\shell\open\command]
@="\"%1\" %*"