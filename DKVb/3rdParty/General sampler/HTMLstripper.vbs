
'-- This script will remove all HTML tags from a file. Enter the full path of the HTML or HTM file
'-- and click OK. If the file was named, for example, index.html then a file will appear in the
'-- same folder called index.txt. This will be the same file but without the HTML tags.
'--you might use this if you were downloading an information page and wanted to have it as a text file.
'--this script does only a basic stripping of HTML tags. It won't get character constants or
'--adjust spacing.
'---------------------------------------------------------------------


Dim fso, f, fname, sfil, fpath, fdot
Set fso = CreateObject("Scripting.FileSystemObject")

on error resume next
  fname = inputbox("Enter the path of the file to process.", "Filepath")
     if fname = "" then
       set fso = nothing
       wscript.quit
     end if

  if fso.fileexists(fname) = false then
      msgbox "The path is wrong. There's no such file.", 16, "Woops!"
      set fso = nothing
      wscript.quit
  end if

  '--open the file and read it into sfil:
  set f = fso.opentextfile(fname, 1)
     sfil = f.readall
     f.close
  set f = nothing
 
  '--get the file name without ext. then create a new file.
  '--the stripit sub does the work of writing the new text.
 
    fdot = instrrev(fname, ".")
    fpath = left(fname, fdot)
      set f = fso.createtextfile(fpath & "txt")
        call stripit
        f.close
      set f = nothing
     set fso = nothing
     msgbox "All done.", 0, "done"

sub stripit()
 dim rb, lb, s, lt, sb, srb, slb
   sb = 1
   rb = 1
   lt = len(sfil)

                        '--find a right bracket:
   do while rb <> 0
      rb = instr(sb, sfil, ">", 1)
        if rb  >= lt then
             exit do
        end if
                           '--from there, find a left bracket:
      lb = instr(rb, sfil, "<", 1)
         if lb >= lt then
           exit do
         end if
                            '--if there's anything in between, write it to the new file:
          If (lb - (rb + 1)) > 0 then 
             s = mid(sfil, (rb + 1), (lb - (rb + 1)))
             f.write s
          end if
      sb = lb
   loop
 end sub