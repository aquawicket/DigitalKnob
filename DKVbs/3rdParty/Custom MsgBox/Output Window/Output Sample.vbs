'--simple demo of basic output window.

 
'--- demo: ------------------------------------------------------------------------
 
Dim Box, Ret, Pt1, sPar, sPath
Set Box = New OutputWindow
Box.Init  '-- initialize to deal with IE8 bug.

  '-- 3 different samples of display style.
With Box
    .Title = "console style"
    .OutputFontColor = "FFFFFF"
    .OutputBackColor = "000000"
    .width = 60
    .height = 16
    .Show
    .Output "This window will close itself when done."
   For i = 0 to 3
      .Output vbCrLf & Now
       WScript.sleep 2000
   Next
       .CloseWindow
End With

With Box
    .Title = "color style"
    .OutputFontColor = "FF0000"
    .OutputBackColor = "FFFFDD"
    .width = 100
    .height = 8
    .Show
    .Output "This window will close itself when done."
    WScript.sleep 2000
    .Output vbCrLf & "This sample demonstrates options."
    WScript.sleep 2000
    .Output vbCrLf & "Text and background can be any color."
    WScript.sleep 2000
    .Output vbCrLf & "Also, the column width and number of rows can be set."
    WScript.sleep 2000
    .Output vbCrLf & "Those settings determine the window size."
    WScript.sleep 3000

   .CloseWindow
End With

With Box
    .Title = "MsgBox style"
    .OutputFontColor = "FF0000"
    .OutputBackColor = "FFFFDD"
    .width = 60
    .height = 4
    .MsgStyle = True
     .Show
     .Output "This window will NOT close itself for 10 seconds when done."
    WScript.sleep 2000
     .Output vbCrLf & vbCrLf & "It can be closed by clicking the x "
     .Output "or by waiting." 
    WScript.sleep 2000
     .Output vbCrLf & vbCrLf & "This sample demonstrates the MsgBox style."
     WScript.sleep 2000
     .Output vbCrLf & vbCrLf & "It also demonstrates how the scrollbar and word wrap will work if the window does not fit the content in either direction."

 End With

WScript.sleep 10000
 Box.CloseWindow


Set Box = Nothing

'-- ========================= Class OutputWindow - custom output window class ========================

Class OutputWindow
Private SHCls, Cls_HTA
Private BackColorC, ButtonTextColor, OutputFontColorC, OutputBackColorC, Q2C, BoxWC, BoxHC, sTitleC, sID, BooMsgStyle
Private Doc1_C

Public Sub Init()  '-- This sub is a brief version of the main Show function. It's only here to initialize.
                          '-- See help for explanation. This deals with a bug in IE8. For explanation of how the code works see comments in Show function.
  Dim Cls_IE, Cls_SHAp, Cls_iCount, Cls_HTAInit
    On Error Resume Next
  sID = "ID_" & CStr(minute(Now)) & CStr(Second(Now))

  Set Cls_SHAp = CreateObject("Shell.Application")    
  SHCls.Run "MSHTA.EXE ""javascript:new ActiveXObject('InternetExplorer.Application').PutProperty('" & sID & "', window);""", 0, False  
      Cls_iCount = 1
          Do Until Cls_iCount = 10
             For Each Cls_IE In Cls_SHAp.Windows
                If IsObject(Cls_IE.GetProperty(sID)) Then
                    Set Cls_HTAInit = Cls_IE.GetProperty(sID)
                    Cls_HTAInit.moveTo 2900, 2900
                   Exit For
                End If   
             Next 
                WScript.sleep 100
                Cls_iCount = Cls_iCount + 1
                If IsObject(Cls_HTAInit) = True Then Exit Do
          Loop   
       Set Cls_SHAp = Nothing
      If IsObject(Cls_HTAInit) Then Cls_HTAInit.close
      Set Cls_HTAInit = Nothing
      Cls_IE.Quit
      Set Cls_IE = Nothing
  End Sub

Public Sub Show()
  Dim s1C, i2C, Ret, Cls_IE, Cls_SHAp, Cls_iCount, WidBox, HtBox, CapOffset, Cls_HTA1
  Dim APage(6)
  On Error Resume Next
 Clear
'-- New version that uses an HTA to work on Vista/7/8.
 sID = "ID__" & CStr(Minute(Now)) & CStr(Second(Now))
 Set Cls_SHAp = CreateObject("Shell.Application")  '-- different things were tried to prevent a full-size IE window from flashing by before msgbox
                                                    ' window. Oddly, this seems to help: Just creating Shell.App before creating the IE window. Apparently the time
                                                    ' required to initialize Shell.App is much greater than the time required to write the IE doc and size/position the IE window.
   SHCls.Run "MSHTA.EXE ""javascript:new ActiveXObject('InternetExplorer.Application').PutProperty('" & sID & "', window);""", 0, False 

     '-- Next step: go through open windows and retrieve the window object for just-created HTA.   
      Cls_iCount = 1
          Do Until Cls_iCount = 10
             For Each Cls_IE In Cls_SHAp.Windows
                If IsObject(Cls_IE.GetProperty(sID)) Then
                    Set Cls_HTA1 = Cls_IE.GetProperty(sID)
                    Cls_HTA1.moveTo 2900, 2900 '-- second part of method to stop IE window flashing by. Move window offscreen before doing anything else.
                    Exit For
                End If   
             Next 
                WScript.sleep 100
                Cls_iCount = Cls_iCount + 1
                If IsObject(Cls_HTA1) = True Then Exit Do
          Loop  
      Set Cls_SHAp = Nothing '-- done with Shell.Application. 
        If Not IsObject(Cls_HTA1) Then Exit Sub
   
   APage(0) = "<HTML><HEAD><HTA:Application scroll=no contextmenu=no border=thin minimizebutton=no maximizebutton=no sysmenu=yes></HTA>"
   APage(1) = vbCrLf & "<STYLE TYPE=" & Q2C & "text/css" & Q2C & ">" & vbCrLf
   APage(2) = "BODY {padding: 0px; margin: 0px; font-family: verdana; font-size: 12px;}" & vbCrLf
   APage(3) = "#TBox {padding: 10px; margin: 0px; position: relative; font-family: verdana; font-size: 12px; background: " 
     If BooMsgStyle = False Then
        APage(4) = OutputBackColorC & "; color: " & OutputFontColorC & "; border-style: solid; border-width: 1px;}" & vbCrLf 
     Else
        APage(4) = BackColorC & "; color: " & ButtonTextColor & "; border-style: none;}" & vbCrLf 
     End If
   APage(5) = "</STYLE>" & vbCrLf & "</HEAD>" & vbCrLf & "<BODY BGCOLOR=" & Q2C & BackColorC & Q2C & " SCROLL=" & Q2C & "no" & Q2C & ">"
   APage(6) = "<TEXTAREA ID=" & Q2C & "TBox" & Q2C & " READONLY COLS=" & BoxWC & " ROWS=" & BoxHC & "></TEXTAREA></BODY></HTML>"
  
   s1C = Join(APage, "")
  Cls_HTA1.document.write s1C
  
  With Cls_HTA1
      .document.title = sTitleC       
     WidBox = .document.all("TBox").offsetWidth + 10
   HtBox = .document.all("TBox").offsetTop + .document.all("TBox").offsetHeight + 30
        .document.body.Style.pixelWidth = WidBox
        .document.body.Style.pixelHeight = HtBox
        .resizeTo WidBox, HtBox 
        .moveTo (.document.parentWindow.screen.Width - WidBox) \ 2, (.document.parentWindow.screen.Height - HtBox) \ 2       
    End With
    
    Set Doc1_C = Cls_HTA1.document
    Set Cls_HTA = Cls_HTA1
    Cls_IE.Quit
 End Sub

Public Property Let Title(sTitleText)
  sTitleC = sTitleText
End Property

Public Property Let Width(iWidth)  'columns
   BoxWC = iWidth
End Property

Public Property Let Height(iHeight) 'rows
  BoxHC = iHeight
End Property

Public Property Let MsgStyle(IfMsg) 
  BooMsgStyle = IfMsg
End Property


Public Property Let OutputFontColor(sHexColor)
   If Left(sHexColor, 1) <> "#" Then sHexColor = "#" & sHexColor
    If Len(sHexColor) = 7 Then OutputFontColorC = sHexColor
End Property

Public Property Let  OutputBackColor(sHexColor)
    If Left(sHexColor, 1) <> "#" Then sHexColor = "#" & sHexColor
    If Len(sHexColor) = 7 Then OutputBackColorC = sHexColor
End Property 

Public Sub Output(sOutput)
  On Error Resume Next
    If IsObject(Cls_HTA) Then 
      If IsObject(Doc1_C) Then
         Doc1_C.all("TBox").innerText = Doc1_C.all("TBox").innerText & sOutput
      End If
    End If
End Sub

Public Sub ClearOutput()
  On Error Resume Next
    If IsObject(Cls_HTA) Then 
      If IsObject(Doc1_C) Then
         Doc1_C.all("TBox").innerText = ""
      End If
    End If
End Sub

Public Sub CloseWindow()
     Clear
End Sub

Private Sub Clear()
    On Error Resume Next
  If IsObject(Cls_HTA) Then 
      If IsObject(Doc1_C) Then Set Doc1_C = Nothing
      Cls_HTA.close
      Set Cls_HTA = Nothing
   End If  
End Sub

 Private Sub Class_Initialize()
    On Error Resume Next
      Q2C = Chr(34)
      Set SHCls = CreateObject("WScript.Shell")
      BackColorC = GetColor("ButtonFace") '--also use this for background color.
         If Len(BackColorC) = 0 Then BackColorC = "#DDDDDD"
     ButtonTextColor = GetColor("ButtonText") 
       If Len(ButtonTextColor) = 0 Then ButtonTextColor = "#000000"
       OutputBackColorC = "#FFFFFF"
      OutputFontColorC = "#000000" 
  End Sub
          
  Private Sub Class_Terminate()
    On Error Resume Next
        Set SHCls = Nothing
        Clear
         If IsObject(Cls_HTAInit) Then Cls_HTAInit.close
         Set Cls_HTAInit = Nothing  
   End Sub

 Private Function GetColor(sColName)
   Dim sRegCol, sColCls, AColCls
       Err.Clear
    On Error Resume Next
    GetColor = ""
   sRegCol = "HKCU\Control Panel\Colors\" & sColName
   sColCls = SHCls.RegRead(sRegCol)
        If (Err.number <> 0) Then Exit Function
   AColCls = Split(sColCls, " ")
      If UBound(AColCls) = 2 Then
         GetColor = "#" & Right(("00" & Hex(AColCls(0))), 2) & Right(("00" & Hex(AColCls(1))), 2) & Right(("00" & Hex(AColCls(2))), 2) 
      End If
 End Function

End Class