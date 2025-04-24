$source = @'
Imports Microsoft.VisualBasic
Imports System
Imports System.Collections.Generic
Imports System.Collections.ObjectModel
imports System.Diagnostics
Imports System.IO
imports System.Linq
Imports System.Text

Public NotInheritable Class MainClass

    Public Shared Sub Main()
        Dim dict As New Dictionary(Of String(), String) From {
            {{Environment.ExpandEnvironmentVariables("%SystemRoot%\System32\en-US\cmd.exe.mui"),
              Environment.ExpandEnvironmentVariables("%SystemRoot%\SysWOW64\en-US\cmd.exe.mui")},
              "Administrator: "},
            {{Environment.ExpandEnvironmentVariables("%SystemRoot%\System32\es-ES\cmd.exe.mui"),
              Environment.ExpandEnvironmentVariables("%SystemRoot%\SysWOW64\es-ES\cmd.exe.mui")},
              "Administrador: "}
        }

        For Each key As String() In dict.Keys
            For Each filepath As String In key
                If File.Exists(filepath) Then
                    Console.WriteLine(String.Format("Searching for string: '{0}' in file: '{1}'", dict(key), filepath))
                    ReplaceBytes(filepath, Encoding.GetEncoding("UTF-16").GetBytes(dict(key)), {&H81, &H0})
                End If
            Next filepath
        Next key
    End Sub

    Private Shared Sub ReplaceBytes(filepath As String, find As Byte(), replace As Byte())
        Dim buffer As Byte() = File.ReadAllBytes(filepath)
        Dim index As Integer = FindByteSequence(buffer, find, 0).DefaultIfEmpty(-1).SingleOrDefault()

        If (index <> -1) Then
            If Not File.Exists(String.Format("{0}.bak", filepath)) Then
                Console.WriteLine(String.Format("Creating backup file: '{0}.bak'", filepath))
                File.Copy(filepath, String.Format("{0}.bak", filepath), overwrite:=False)
            End If

            buffer = buffer.Take(index).Concat(replace).Concat(buffer.Skip(index + find.Length)).ToArray()

            Console.WriteLine(String.Format("Rebuilding file: '{0}'", filepath))
            Using fs As New FileStream(filepath, FileMode.Create, FileAccess.Write, FileShare.None)
                fs.Write(buffer, 0, buffer.Length)
            End Using

        Else
            Console.WriteLine(String.Format("String not found in file: '{0}'", filepath))

        End If
    End Sub

    ' Original author: https://stackoverflow.com/a/332667/1248295
    Private Shared Function FindByteSequence(buffer As Byte(), pattern As Byte(), startIndex As Integer) As ReadOnlyCollection(Of Integer)
        Dim positions As New List(Of Integer)
        Dim i As Integer = Array.IndexOf(buffer, pattern(0), startIndex)

        Do While (i >= 0) AndAlso (i <= (buffer.Length - pattern.Length))
            Dim segment(pattern.Length - 1) As Byte
            System.Buffer.BlockCopy(buffer, i, segment, 0, pattern.Length)
            If segment.SequenceEqual(pattern) Then
                positions.Add(i)
            End If
            i = Array.IndexOf(buffer, pattern(0), i + 1)
        Loop

        Return positions.AsReadOnly()
    End Function

End Class
'@ 

$vbType = Add-Type -TypeDefinition $source `
                   -CodeDomProvider (New-Object Microsoft.VisualBasic.VBCodeProvider) `
                   -PassThru `
                   -ReferencedAssemblies "Microsoft.VisualBasic.dll", `
                                         "System.dll" `
                                         | where { $_.IsPublic }

[MainClass]::Main()

$Console = [System.Console]
$Console::WriteLine("All done. Press any key to exit...")
$Console::ReadKey($true)
Exit(0)