imports System.Runtime.InteropServices 
Public Module MyApplication  

Public Declare Function GetConsoleProcessList Lib "Kernel32" (ByRef ProcessList as Integer, ByVal Count as Integer) As Integer

Public Sub Main ()
                Dim ProcessList(0 To 9) As Integer
                Dim Count As Integer
                Dim Ret As Integer
                Dim x as Integer
                Dim ColItems as Object
                Dim objWMIService As Object
                objWMIService = GetObject("winmgmts:\\.\root\cimv2")
                Count = 10
                'subtract one to account for this program
                Ret = GetConsoleProcessList(ProcessList(0), 10) - 1
                Console.Writeline("Level = " & Ret)

                For x = Ret  to 1 step -1
                    colItems = objWMIService.ExecQuery("Select * From Win32_Process where ProcessID=" & ProcessList(x))
                    For Each objItem in colItems
                        Console.writeline("PID : " & objItem.ProcessID & "  Command line : " &  objItem.CommandLine)
                    Next
                Next
                Environment.ExitCode = Ret  
End Sub
End Module 