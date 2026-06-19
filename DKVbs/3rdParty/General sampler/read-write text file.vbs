'--this script is a basic file read/write example.


Dim FSO, TS, Arg, sFil, A1, i2, s2, Path2, Pt1

  On Error Resume Next
  
Arg = WScript.Arguments(0)
 
MsgBox "This script demonstrates basic reading and writing of text files. You can drop a file onto the script or just run the script and enter a text file path for the demo."

If Len(Arg) = 0 Then Arg = InputBox("Enter full path of a text file.", "Read-write demo")

If Len(Arg) = 0 Then WScript.quit '-- no file path.

Set FSO = CreateObject("Scripting.FileSystemObject")
  If FSO.FileExists(Arg) = False Then
     MsgBox "File path entered is not valid. Script must quit.", 64
     DropIt
  End If
 
'----------------------- HERE'S THE READ OPERATION ---------------------------- 

 Set TS = FSO.OpenTextFile(Arg, 1)     '-- OpenTextFile and CreateTextFile both return a Textstream object.
                                                            '-- second parameter: 1-for reading. 2-for writing. 8-for appending.
                                                            
   sFil = TS.ReadAll
   TS.Close
 Set TS = Nothing

'---------------------- END OF READ OPERATION --------------------------------

'-- sFil is now a string copy of the content of the file.

sFil = Replace(sFil, "a", "*") '-- replace all instances of "a" with an asterisk.
  
A1 = Split(sFil, vbCrLf)  ' This will return an array of lines. Each array element will be one line from the file.

' For demonstration purposes, the next step will insert a line between each text line in the file:

For i2 = 0 to UBound(A1) 
  s2 = A1(i2)
  s2 = s2 & vbCrLf & "_____________________________________________________________"
  A1(i2) = s2
Next

  '-- The above just added a return and a line to each text line. Array element strings can't be operated
  '-- on in the array. They must be assigned to a string first and then assigned to overwrite the array element.
  

'-- This next line now puts the string back together. Joining each array element with a vbCrLf.

sFil = Join(A1, vbCrLf) 

'----------------------- HERE'S THE WRITE OPERATION ---------------------------- 

' get a new path for the file. It will be the same file name with "2" added.

Pt1 = InStrRev(Arg, ".")  '-- find the last period.
If Pt1 = 0 Then
   Path2 = Arg & "2"
Else
   Path2 = Left(Arg, (Pt1 - 1)) & "2" & Right(Arg, (len(Arg) - (Pt1 - 1)))
End If   
   

Set TS = FSO.CreateTextFile(Path2, True)
  TS.write sFil
  TS.Close
Set TS = Nothing

DropIt

'-- This is a simple sub to save on repetitive code. It cleans up and ends the script.
'-- Many people say there's no need to use "Set FSO = Nothing". To some extent
'-- that's true. When the script quits any objects are cleaned up automatically. But
'-- in some cases there can be problems. And cleaning up is a good habit to be in.

Sub DropIt()
  Set FSO = Nothing
  WScript.Quit
End Sub

