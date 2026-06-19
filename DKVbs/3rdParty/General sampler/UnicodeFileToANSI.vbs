'-- drop a unicode text file onto this script and get an ANSI version.
'-- note that this is Microsoft unicode16.


Dim FSO, s1, s2, arg, sFilP, Pt1

Set FSO = CreateObject("Scripting.FileSystemObject")

arg = WScript.Arguments(0)
  s2 = ReadFile(arg)
  s1 = GetANSIString(s2)
  Pt1 = InStrRev(arg, ".")
  sFilP = Left(arg, (Pt1 - 1)) & "-ANSI" & Right(arg, (Len(arg) - (Pt1 - 1)))
  WriteFile sFilP, s1

Set FSO = Nothing  
  MsgBox "OK"
  
Sub WriteFile(sFil, sText)
Dim TS
Set TS = FSO.CreateTextFile(sFil, True)
  TS.Write sText
   TS.Close
Set TS = Nothing
End Sub

Function ReadFile(FPath)
Dim oFil1, LenF, TS
Set oFil1 = FSO.GetFile(FPath)
LenF = oFil1.Size
Set oFil1 = Nothing

Set TS = FSO.OpenTextFile(FPath, 1)
  ReadFile = TS.Read(LenF)
   TS.Close
Set TS = Nothing
End Function

 Function GetANSIString(sStr)
  Dim sRet, iLen, iA, iLen2, A2()
      iLen2 = 0
     ReDim A2(len(sStr))
      For iLen = 1 to Len(sStr) step 2
         iA = Asc(Mid(sStr, iLen, 1))
          If (iA <> 0) Then 
                A2(iLen2) = Chr(iA)
                iLen2 = iLen2 + 1
          End If          
       Next      
        ReDim Preserve A2(iLen2 - 1)
        GetANSIString = Join(A2, "")
End Function