'-- This is a sample script using the pasted Msg class.

Dim Box, r, sFruit
  Set Box = New Msg
  With Box
    .Title = "Pick a Fruit"
    .Caption = "Select a fruit from list or enter name of a fruit not listed."
    .Font = "arial"
    .AddButton "OK"
    .AddList "", ""
    .AddList "Apple", ""
    .AddList "Tangerine", ""
    .AddList "Peach", ""
    .AddList "Mango", ""
    .AddTextBox 16
  End With
      r = Box.ShowMsg
            If (r > 0) Then
              sFruit = Box.ListText
              If (len(sFruit) = 0) Then sFruit = Box.Text
              If (len(sFruit) > 0) Then
                  MsgBox "Fruit: " & sFruit
              Else
                 MsgBox "No fruit selected."
              End If    
           End If   
           If r = -1 Then MsgBox "-1"  '--temp
   Set Box = Nothing   

'-- Class for creating custom MsgBox.
 '-- Properties:  
        '-  Title - window title.
        '-  Caption - message in window.
        '-  Icon - icon file for window. JPG, GIF, BMP up to 60 px.
        '-  IconWidth - pixel size of icon.
        '-  Font (def. MS Sans Serif)
        '-  ListText - After ShowMsg returns, this will hold the text of selected list item if there was one.
        '-  ListData - After ShowMsg returns, this will hold the hidden data that was stored with selected list item.
        '-  ListIndex - After ShowMsg returns, returns index of selected item.
        '-  Text - After ShowMsg returns, this returns any text entered into textbox.
        
 '-- Subs:          
       '-  AddButton(caption)  
       '-  AddList(item, hidden data) - Add dropdown selector item.
       '- AddTextBox(Columns)  - adds a text input of character width "columns". 
       '-  Clear

 '-- Function:     
'-  Number = ShowMsg  - returns number of  button was clicked.

'-- ========================= Class Msg - custom message Box Class - UPDATED 11/2012 ========================
Class Msg
Private SHCls
Private BackColor, TextColor, ButtonTextColor, Q2C
Private sTitleC, sCaptionC, sIconC, IcoWidth, sFontC, sLB, sID
Private BooListC, CHR1, sListC, sDataC, ListRetC, ListDatC, ListiC, LSize '-- list box variables.
Private BooTextBoxC, BooPasswordC, sTextC, TextColumns, sPasswordC
Private AButs(), iButs

Public Sub Init()  '-- This sub is a brief version of the main ShowMsg function. It's only here to initialize.
                          '-- See help for explanation. This deals with a bug in IE8. For explanation of how the code works see comments in ShowMsg function.
  Dim Cls_IE, Cls_HTA, Cls_SHAp, Cls_iCount
    On Error Resume Next
  sID = "ID_" & CStr(minute(Now)) & CStr(Second(Now))
  Set Cls_SHAp = CreateObject("Shell.Application")    
  SHCls.Run "MSHTA.EXE ""javascript:new ActiveXObject('InternetExplorer.Application').PutProperty('" & sID & "', window);""", 0, False  
      Cls_iCount = 1
          Do Until Cls_iCount = 10
             For Each Cls_IE In Cls_SHAp.Windows
                If IsObject(Cls_IE.GetProperty(sID)) Then
                    Set Cls_HTA = Cls_IE.GetProperty(sID)
                    Cls_HTA.moveTo 2900, 2900
                   Exit For
                End If   
             Next 
                WScript.sleep 100
                Cls_iCount = Cls_iCount + 1
                If IsObject(Cls_HTA) = True Then Exit Do
          Loop   
      Set Cls_SHAp = Nothing
      If IsObject(Cls_HTA) Then Cls_HTA.close
      Set Cls_HTA = Nothing
      Cls_IE.Quit
      Set Cls_IE = Nothing
End Sub

Public Function ShowMsg()
  Dim s1C, i2C, Ret, Cls_IE, Cls_HTA, Cls_SHAp, sSpc, Cls_iCount
  Dim APage(13)
    On Error Resume Next
      ShowMessage = -1  '--failed to work.
'-- New version that uses an HTA to work on Vista/7/8.
 sID = "ID__" & CStr(minute(Now)) & CStr(Second(Now))
 Set Cls_SHAp = CreateObject("Shell.Application")  '-- different things were tried to prevent a full-size IE window from flashing by before msgbox
                                                    ' window. Oddly, this seems to help: Just creating Shell.App before creating the IE window. Apparently the time
                                                    ' required to initialize Shell.App is much greater than the time required to write the IE doc and size/position the IE window.
   SHCls.Run "MSHTA.EXE ""javascript:new ActiveXObject('InternetExplorer.Application').PutProperty('" & sID & "', window);""", 0, False 

     '-- Next step: go through open windows and retrieve the window object for just-created HTA.   
      Cls_iCount = 1
          Do Until Cls_iCount = 10
             For Each Cls_IE In Cls_SHAp.Windows
                If IsObject(Cls_IE.GetProperty(sID)) Then
                    Set Cls_HTA = Cls_IE.GetProperty(sID)
                    Cls_HTA.moveTo 2900, 2900 '-- second part of method to stop IE window flashing by. Move window offscreen before doing anything else.
                    Exit For
                End If   
             Next 
                WScript.sleep 100
                Cls_iCount = Cls_iCount + 1
                If IsObject(Cls_HTA) = True Then Exit Do
          Loop  
      Set Cls_SHAp = Nothing '-- done with Shell.Application. 
        If Not IsObject(Cls_HTA) Then Exit Function  
     
sSpc = "<TD> &#160; &#160; </TD>"
   APage(0) = "<HTML><HEAD><HTA:Application scroll=no contextmenu=no border=thin minimizebutton=no maximizebutton=no sysmenu=no></HTA>"
   APage(1) = vbCrLf & "<STYLE TYPE=" & Q2C & "text/css" & Q2C & ">" & vbCrLf
   APage(2) = "BODY {padding: 4px; font-family: " & sFontC & "; border-style: outset; border-Width: 1px;}" & vbCrLf & "LABEL {font-size: 12px; color: " & TextColor & "; background: " & BackColor & ";}" & vbCrLf
   APage(3) = "#TDBut {padding: 4px 10px 4px 10px; color: " & ButtonTextColor & "; background: " & BackColor & "; border-style: solid; border-width: 2px; border-color: #FFFFFF #666666 #666666 #FFFFFF; font-size: 12px;}" & vbCrLf
   APage(4) = "#TCap {font-size: 12px; color: " & TextColor & "; background: " & BackColor & ";}" & vbCrLf & "#ButBox {padding-bottom: 30px;}" & vbCrLf & "#TBox {font-size: 12px;}" & vbCrLf
   APage(5) = "#PBox {font-size: 12px;}" & vbCrLf & "#IM {padding: 15px;}" & vbCrLf & "</STYLE>" & vbCrLf & "</HEAD>" & vbCrLf
   APage(6) = "<BODY BGCOLOR=" & Q2C & BackColor & Q2C & " SCROLL=" & Q2C & "no" & Q2C & ">"
     If (Len(sIconC) > 0) And (IcoWidth > 0) Then
        APage(7) = "<IMG ID=" & Q2C & "IM" & Q2C & " SRC=" & Q2C & sIconC & Q2C & " ALIGN=" & Q2C & "left" & Q2C & ">"
     Else
        APage(7) = ""
     End If
   APage(8) = "<TABLE Width=100% ID=" & Q2C & "TCap" & Q2C & "><TR><TD>" & sCaptionC & "</TD></TR></TABLE><BR>"   
       s1C = ""  
     For i2C = 0 to iButs
       If AButs(i2C) <> "" Then
           If i2C > 0 Then s1C = s1C & sSpc  '-- add spaces between buttons.
         s1C = s1C & "<TD ALIGN=" & Q2C & "center" & Q2C & " ID=" & Q2C & "TDBut" & Q2C    
         s1C = s1C & " onmousedown=" & Chr(39) & "vbscript:window.event.srcElement.style.borderColor = " & Q2C & "#666666 #FFFFFF #FFFFFF #666666" & Q2C & Chr(39) & " onclick=" & Chr(39) & "vbscript:T1.Value = " & Q2C & CStr(i2C + 1) & Q2C & Chr(39) & ">"
         s1C = s1C & "<LABEL onmousedown=" & Chr(39) & "vbscript:window.event.srcElement.parentElement.style.borderColor = " & Q2C & "#666666 #FFFFFF #FFFFFF #666666" & Q2C & Chr(39) & " onclick=" & Chr(39) & "vbscript:T1.Value = " & Q2C & CStr(i2C + 1) & Q2C & Chr(39) & ">" & AButs(i2C) & "</LABEL></TD>"  '-- LABEL needed to prevent i-beam cursor over TD.
       End If
     Next
   APage(9) = "<TEXTAREA ID=" & Q2C & "T1" & Q2C & " STYLE=" & Q2C & "display: none;" & Q2C & "></TEXTAREA>"
  If (BooTextBoxC = False) Then
      APage(10) = ""
  Else
     APage(10) = "<DIV ALIGN=" & Q2C & "center" & Q2C & "><INPUT TYPE=" & Q2C & "text" & Q2C & " ID=" & Q2C & "TBox" & Q2C & " SIZE=" & TextColumns & "></DIV><BR>"
  End If
  If (BooPasswordC = False) Then
      APage(11) = ""
  Else
     APage(11) = "<DIV ALIGN=" & Q2C & "center" & Q2C & "><INPUT TYPE=" & Q2C & "password" & Q2C & " ID=" & Q2C & "PBox" & Q2C & " SIZE=20></DIV><BR>"
  End If

  If (BooListC = False) Then
     APage(12) = ""
   Else
      sLB = "<DIV ALIGN=" & Q2C & "center" & Q2C & "><SELECT ID=" & Q2C & "List" & Q2C
         If (LSize > 1) Then sLB = sLB & " SIZE=" & CStr(LSize)
      sLB = sLB & "></SELECT></DIV><BR>"
      APage(12) = sLB
   End If
   APage(13) = "<TABLE ID=" & Q2C & "ButBox" & Q2C & " ALIGN=" & Q2C & "center" & Q2C & "><TR><TD><TABLE><TR>" & s1C & "</TR></TABLE></TD></TR></TABLE></BODY></HTML>"
  
   s1C = Join(APage, "")
  
   Cls_HTA.document.write s1C
 
Dim WidBox, HtBox, CapOffset
  With Cls_HTA
       .document.title = sTitleC       
         If (BooListC = True) And (len(sListC) > 0) Then 
               .document.all("List").style.fontfamily = "arial"
               .document.all("List").style.fontsize = 12
            Dim AList, ADat, i3, Opt
               sListC = Left(sListC, (len(sListC) - 1))
               sDataC = Left(sDataC, (len(sDataC) - 1))
               AList = Split(sListC, CHR1)
               ADat = Split(sDataC, CHR1)
                For i3 = 0 to UBound(AList)
                    Set Opt = .document.createElement("OPTION")
                        If AList(i3) = "-" Then
                            Opt.text = ""
                        Else 
                            Opt.text = AList(i3)
                        End If    
                       Opt.value = ADat(i3) 
                       .document.all("List").Add Opt
                    Set Opt = Nothing   
                Next   
         End If   
         If (BooTextBoxC = True) Then       
            .document.all("TBox").style.fontfamily = "verdana"
            .document.all("TBox").style.fontsize = 12
         End If
          If (BooPasswordC = True) Then       
            .document.all("PBox").style.fontfamily = "verdana"
            .document.all("PBox").style.fontsize = 12
         End If
        
           WidBox = 150 + (60 * iButs)
       If (.document.all("ButBox").offsetWidth + 20) > WidBox Then
           WidBox = .document.all("ButBox").offsetWidth + 20
       End If   
       If (BooTextBoxC = True) Then    
            If (.document.all("TBox").offsetWidth + 20) > WidBox Then
                WidBox = .document.all("TBox").offsetWidth + 20
           End If   
        End If
        CapOffset = 40
         If (Len(sIconC) > 0) Then CapOffset = IcoWidth + 40
       .document.all("TCap").Style.pixelWidth = WidBox - CapOffset
        HtBox = .document.all("ButBox").offsetTop + .document.all("ButBox").offsetHeight
        .document.body.Style.pixelWidth = WidBox
        .document.body.Style.pixelHeight = HtBox
        .resizeTo WidBox + 12, HtBox + 80
        .moveTo (.document.parentWindow.screen.Width - WidBox) \ 2, (.document.parentWindow.screen.Height - HtBox) \ 2
         
    End With
  
    
  Dim sVal, iSel
    Do
        sVal = Cls_HTA.document.all("T1").Value 
         If Len(sVal) > 0 Then   
            With Cls_HTA.document.all("List")  
                 If (BooListC = True) Then   
                      iSel = .selectedindex   
                      ListRetC = .Options(iSel).text
                      ListDatC = .Options(iSel).value
                      ListiC = iSel
                 End If    
              End With   
                If (BooTextBoxC = True) Then
                   sTextC = Cls_HTA.document.all("TBox").value
                End If   
                If (BooPasswordC = True) Then
                   sPasswordC = Cls_HTA.document.all("PBox").value
                End If   
            Cls_HTA.close
            Set Cls_HTA = Nothing
            Cls_IE.Quit
            Set Cls_IE = Nothing
            ShowMsg = CInt(sVal)
            Exit Function
         End If
           WScript.sleep 100
    Loop                  
End Function

Public Property Let Title(sTitleText)
  sTitleC = sTitleText
End Property
Public Property Let Caption(sCaptionText)
  sCaptionC = sCaptionText
End Property
Public Property Let Font(sFontName)
  sFontC = sFontName
End Property
Public Property Let Icon(sIconPath)
  sIconC = sIconPath
End Property
Public Property Let IconWidth(Width)
     IcoWidth = Width 
End Property
Public Property Let ListSize(NumItems)
  LSize = NumItems
End Property
Public Sub AddList(Item, Data) '-- add item to selection box. sItem is text. 
    If Len(Data) = 0 Then Data = "-"
    If (Len(Item) = 0) Then Item = "-"
        sListC = sListC & Item & CHR1
        sDataC = sDataC & Data & CHR1
        BooListC = True
End Sub
Public Sub AddButton(sCaptionC)
  AButs(iButs) = sCaptionC
  iButs = iButs + 1
  ReDim Preserve AButs(iButs)
End Sub
Public Property Get ListText()
   If (ListRetC = "-") Then ListRetC = ""
   ListText = ListRetC
End Property
Public Property Get ListData()
    If (ListDatC = "-") Then ListDatC = ""
    ListData = ListDatC
End Property
Public Property Get ListIndex()
    ListIndex = ListiC
End Property
Public Property Get Password()
 Password = sPasswordC
End Property
Public Sub AddTextBox(Columns)
  BooTextBoxC = True
    If isNumeric(Columns) Then
        TextColumns = Columns
    Else
        TextColumns = 24
    End If    
End Sub
Public Sub AddPasswordInput()
  BooPasswordC = True
End Sub

Public Property Get Text()
  Text = sTextC
End Property
Public Sub Clear()
    On Error Resume Next
  Dim i2C
  sTitleC = ""
  sCaptionC = ""
  sIconC = ""
  sListC = ""     '-- list of select element list box items.
  sDataC = ""    '-- list of hidden data.
  ListRetC = ""  '-- stored selection text. Clear before each call.
  ListDatC = ""   '-- stored selection hidden data.
  ListiC = 0       '-- index of dropdown selection.
  sTextC = ""      '-- textbox variable.
  sPasswordC = "" '-- password entered into password input.
  IcoWidth = 0
  LSize = 1
  sFontC = "MS Sans Serif"
  ReDim AButs(0)
  iButs = 0
  BooListC = False
  BooTextBoxC = False
  BooPasswordC = False
End Sub

 Private Sub Class_Initialize()
    On Error Resume Next
      Q2C = Chr(34)
      CHR1 = chr(149)
      Clear
      Set SHCls = CreateObject("WScript.Shell")
      BackColor = GetColor("ButtonFace") '--also use this for background color.
         If Len(BackColor) = 0 Then BackColor = "#DDDDDD"
      ButtonTextColor = GetColor("ButtonText") 
         If Len(ButtonTextColor) = 0 Then ButtonTextColor = "#000000"
      TextColor = GetColor("WindowText")
        If Len(TextColor) = 0 Then TextColor = "#000000"
  End Sub
          
  Private Sub Class_Terminate()
    On Error Resume Next
        Set SHCls = Nothing
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