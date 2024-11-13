if DKINIT = 1 then
	'WScript.Echo "DK.vbs already loaded"
else
	'WScript.Echo "Loading DK.vbs"
	DKINIT = 1

	function ForceConsole()	
		If InStr(LCase(WScript.FullName), "cscript.exe") = 0 Then
			Set oWSH = CreateObject("WScript.Shell")
			oWSH.Run "cmd.exe /k cscript.exe" & " //NoLogo " & Chr(34) & WScript.ScriptFullName & Chr(34)
			WScript.Quit
		End If
	end function
	'Call ForceConsole()

	executeGlobal CreateObject("Scripting.FileSystemObject").openTextFile("dk_source.vbs").readAll()

	'WScript.StdOut.Write Chr(27) & "[34A" 'move cursor to beggining of cmd screen
	'WScript.StdOut.Write Chr(27) & "[2J"  'clear screen

	DKSCRIPT_PATH = WScript.ScriptFullName
	'WScript.StdOut.WriteLine "DKSCRIPT_PATH = "+DKSCRIPT_PATH

	DKSCRIPT_DIR = CreateObject("Scripting.FileSystemObject").GetParentFolderName(DKSCRIPT_PATH)
	'WScript.StdOut.WriteLine "DKSCRIPT_DIR = "+DKSCRIPT_DIR

	DKSCRIPT_FILE = CreateObject("Scripting.FileSystemObject").GetFileName(DKSCRIPT_PATH)
	'WScript.StdOut.WriteLine "DKSCRIPT_FILE = "+DKSCRIPT_FILE

	DKSCRIPT_NAME = CreateObject("Scripting.FileSystemObject").GetBaseName(DKSCRIPT_PATH)
	'WScript.StdOut.WriteLine "DKSCRIPT_NAME = "+DKSCRIPT_NAME

	DKSCRIPT_EXT = "."+CreateObject("Scripting.FileSystemObject").GetExtensionName(DKSCRIPT_PATH)
	'WScript.StdOut.WriteLine "DKSCRIPT_EXT = "+DKSCRIPT_EXT
end if