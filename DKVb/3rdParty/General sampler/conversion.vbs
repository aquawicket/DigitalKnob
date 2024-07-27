'--use this script to obtain the ascii code for a character or the character for an ascii code.

dim r, m
m = msgbox("YES: Enter ascii code and get character." & vbcrlf & "NO: Enter character and get ascii code.", 36, "Chr and Asc Conversion")
   if m = 6 then
         r = inputbox("Enter ascii code.", "Chr conversion")
               if isnumeric(r) = false then
                  msgbox "Not a valid entry.", 16, "Cannot convert"
                   wscript.Quit
               end if
              if r > -1 and r < 256 then
                    msgbox chr(r)
              else
                     msgbox "Not a valid entry.", 16, "Cannot convert"
              end if
    else
        r = inputbox("Enter character.", "Asc conversion")
            if len(r) = 1 then
              msgbox asc(r)
           else
              msgbox "Must be only 1 character.", 16, "Cannot Convert"
           end if
     end if

