'-- very, very simple script to count words in a file dropped onto the script.
'-- This script is somewhat primitive. It just removes blocks of
'-- spaces, up to a block of 8, then splits the file into lines.
'-- next it splits each line by spaces and counts the ubound of the resulting array.
'-- it's not foolproof. For instance, a long string of spaces would affect the count.


Dim FSO, TS, s2, s1, Arg, A1, i2, iCnt, A2
Set FSO = CreateObject("Scripting.FileSystemObject")
  On Error Resume Next
Arg = WScript.Arguments(0)

Set TS = FSO.OpenTextFile(Arg, 1)
  s2 = TS.ReadAll
  TS.Close
Set TS = Nothing

A1 = Split(s2, vbCrLf)
For i2 = 0 to ubound(A1)
  s1 = A1(i2)
  If Len(s1) > 0 Then
     s1 = CleanWord(s1)
     s1 = Trim(s1)
     If Len(s1) > 0 Then
      A2 = Split(s1, " ")
      iCnt = iCnt + (UBound(A2) + 1)
     End If    
  End If    
Next

MsgBox iCnt
WScript.quit

Function CleanWord(sWordIn)
  Dim i, sRet
    sRet = sWordIn
   For i = 0 to 7
     sRet = Replace(sRet, "  ", " ")
   Next  
   CleanWord = sRet
End Function