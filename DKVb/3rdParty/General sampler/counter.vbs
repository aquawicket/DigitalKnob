'--give it a file path and a string. it'll tell you the number of 
'--occurences of that string.
'---------------------------------------------------
Dim fso, f, ftext, r, stext, lstart, i, ls, fok
Set fso = CreateObject("Scripting.FileSystemObject")


   '--get the path of the file. (There's a bug in Inputbox that will cause an error if
   '--Cancel is clicked.)
 on error resume next
 ftext = inputbox("Enter the path of the file for processing.", "FILENAME")
    if ftext = "" then
        set fso = nothing
        wscript.quit
    end if
       '--check whether the path is valid:
 If fso.fileexists(ftext) = false then
        fok = false
   do while fok = false 
      r = msgbox("The path is wrong, there's no such file. Do you want to re-enter?", 36, "Woops!")
         if r = 7 then 
            set fso = nothing
            wscript.quit
         else
            ftext = inputbox("Enter the filename for processing.", "FILENAME")
               if fso.fileexists(ftext) = true then
                   fok = true
                   exit do
              end if
         end if
    loop
end if

 '--by this point there's a valid path.
 '--ask for the string being counted:

fs = inputbox("What is the string you're looking for? This will tell you the number of occurences.", "Enter string to find")
  if fs = "" then
     set fso = nothing
     wscript.quit
  end if

   '--open the file and read it into the variable stext:
set f = fso.opentextfile(ftext)
  stext = f.readall
  f.close
set f = nothing
set fso = nothing

 '--the search - i is the counter. InStr looks for the string, starting at lstart.
'-- every time it's found, i is increased by 1 and lstart is set to ls + 1 
'-- ( 1 character after where the string was found). When InStr returns 0 there are no
'--more instances of the string.

   lstart = 1
      i = 0
      ls = 1
  do until ls = 0
           ls = instr(lstart, stext, fs, 1)
      If ls <> 0 then
          i = i + 1
          lstart = ls + 1
     end if
  loop

  msgbox i
      

