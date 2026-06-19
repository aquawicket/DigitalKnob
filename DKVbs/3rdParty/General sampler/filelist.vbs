'--this script will open a message box with a list of files in My Documents.

Dim DocsFol, DocsFil, finame, filist, DocsFils, sh, sdocfol
Dim fso
Set fso = CreateObject("Scripting.FileSystemObject")
Set sh = CreateObject("WScript.Shell")

filist = ""

    '--get My Documents folder. From that get the folder's files.
    '-- then get name of each file and add it to filist variable, with a carriage return:
  
   sdocfol = sh.SpecialFolders("MyDocuments")
   set DocsFol = fso.GetFolder(sdocfol)
   set DocsFils = DocsFol.files
       For Each DocsFil In DocsFils
           finame = fso.GetAbsolutePathName(DocsFil)
           filist = filist & finame & VbCrLf
       Next

Msgbox filist
