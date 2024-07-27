'--this script demonstrates a simple input box. The 64 gives the message box
'-- an "information" icon (a blue "i").

dim response
response = inputbox("Type anything in the box and click OK.", "Input box demo")
   if response <> "" then
      msgbox "You typed " & response & ".", 64, "Your Input"
  end if