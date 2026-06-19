' (c) niall@windows-noob.com 2014/7/24
' This script allows you to sync the time in WinPE with a local server using a prestart command
' Fill in the user/password/domain/server details below
' For more guides see http://www.windows-noob.com/forums/index.php?/topic/4045-system-center-2012-configuration-manager-guides/ 
' for troubleshooting, review the log files created
' net use (to see all existing connections)
' net use * /del /yes (to delete all existing connections) 

Option Explicit
DIM ComSpec, WshShell, strUser, strPassword, strDomain, strServer, strCommand, LogFileName, logfile, objFSO, objFile, outFile

Set WshShell = CREATEOBJECT("WScript.Shell")
strUser = "hongsheng.yang@ivanti.com"
strPassword = "444"
strDomain = "ld.landesk.com"
strServer = "WIN-LHCO2PPENKQ"

PrepLogFile
Logtext "Starting logging process."
LogText "sleeping for 15 seconds.."
WScript.Sleep 15000
LogText "Using NET USE to Connect to " & strServer & " as a Domain user.."
strCommand = ComSpec & ("cmd /c net use \\") & strServer & ("\ipc$") & (" ") & strPassword & (" ") & ("/user:") & strUser & (" ") & (">") & (" ") & ("x:\WinPE_net_use.log")
wscript.echo strCommand

		If WshShell.Run (strCommand, 0, True) = 0 then
			LogText "...NET USE connected ok, continuing."
			'On Error GoTo 0
		else
			LogText "...NET USE had an error."
			ExitScript -1
		end if

LogText "Using the NET TIME command to sync with the Server time.."
strCommand = ("cmd /c net time \\") & strServer & (" /SET /Y") & (">") & (" ") & ("x:\WinPE_net_time.log")
wscript.echo strCommand
WshShell.Run strCommand

'wait for 5 seconds so the new time is registered before talking to the mp
LogText "Waiting for 5 seconds so the new time is registered before talking to the mp.."

WScript.Sleep 5000
LogText "all done, exiting.." 

' =====================================================
' PrepLogFile Subroutine
' =====================================================

Sub PrepLogFile
	
	Dim objFSO

	Set wShShell = WScript.CreateObject("WScript.Shell")
	LogFileName = "X:\WinPE_TimeSync.log"

	'On Error Resume Next
	Err.Clear

	Set objFSO = CreateObject("Scripting.FileSystemObject")
	
	If Err.number <> 0 Then
		MsgBox("****   ERROR (" & Err.Number & ") Could not create Logfile - exiting script")
		ExitScript 0
	Else
		If objFSO.FileExists(LogFileName) Then
			objFSO.DeleteFile(LogFileName) 
		End If
		Err.Clear
		Set logfile = objFSO.CreateTextFile(LogFileName)
		If Err.number <> 0 Then
			MsgBox "ERROR (" & Err.Number & ") Could not create logfile (File) - exiting script"
			ExitScript 0
		End If
	End If
	
	Err.Clear
	
	'On Error GoTo 0
	
	logfile.writeline "##############################################"
	logfile.writeline "    windows-noob.com WinPE Time sync Script   "
	logfile.writeline "##############################################"
End Sub

' =====================================================
' LogText Subroutine
' =====================================================

Sub LogText (TextToLog)
	logfile.writeline "" & Now() & " " & TextToLog
End Sub

' =====================================================
' Exit function
' =====================================================

Function ExitScript(iStatus)
'	if iStatus <> 0 then
'		set WshShell = WScript.CreateObject("WScript.Shell")
'		ComSpec = WshShell.ExpandEnvironmentStrings("%COMSPEC%")
'		WshShell.Run "cmtrace.exe " & LogFileName , 1, False
'	End if

	LogText "All done, exiting successfully"
	wscript.quit(iStatus)
End Function



