'--this one will tell you the drive free space for drive C and then open the recycle bin.
'-- the freespace property of the Drive object is based on an old Windows function - it will only return
'-- up to 2 GB. That is, a 10 GB drive will still be reported as 2 GB.


  dim dfs, mb, fso, sh
 Set fso = CreateObject("Scripting.FileSystemObject")
 Set sh = CreateObject("WScript.Shell")
ON ERROR RESUME NEXT
 
  Set dfs = fso.getdrive("C:\")
  mb = dfs.freespace

   '--divide freespace by 1024 to get KB and again to get MB.
  mb = mb / 1024 / 1024 / 1024
  mb = FormatNumber(mb, 2)

    MsgBox "C drive has " & mb & " Gigabytes free.", 64, "DRIVE INFO"

   r = MsgBox("Are you through with this box now?", 36, "All Done?")
   If r = 7 Then
       MsgBox "Sorry, that's all the tricks we've got!", 0, "End Of The Show"
   Else
      sh.run "C:\RECYCLED", 1
   End If
 










