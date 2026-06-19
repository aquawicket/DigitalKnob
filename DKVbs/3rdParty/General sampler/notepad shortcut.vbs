'--this is the full version of making a shortcut. You don't necessarily need to use all parameters.

dim r
r = msgbox("Would you like a shortcut to Notepad on the Desktop?", 36, "Create Shortcut?")
if r = 7 then
   wscript.quit
else
   Dim oshell, fso
   Set oshell = WScript.CreateObject("WScript.Shell")
   Set fso = CreateObject("Scripting.FileSystemObject")
   Dim shcut, d, dpath, wpath
   
      dpath = oshell.SpecialFolders("Desktop")
      wpath = fso.GetSpecialFolder(0)
   Set shcut = oshell.CreateShortcut(dpath & "\Notepad.lnk")
   shcut.TargetPath = oshell.ExpandEnvironmentStrings(wpath & "\Notepad.exe")
   shcut.WorkingDirectory = oshell.ExpandEnvironmentStrings(wpath)
   shcut.WindowStyle = 4
   shcut.IconLocation = oshell.ExpandEnvironmentStrings(wpath & "\Notepad.exe, 0")
   shcut.Save
end if