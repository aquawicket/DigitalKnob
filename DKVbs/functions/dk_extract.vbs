' shebang

if(NOT DKINIT_vbs = 1) then
	executeGlobal CreateObject("Scripting.FileSystemObject").openTextFile("DK.vbs").readAll()
	'ForceConsole()
end if


'##################################################################################
'# dk_extract(file ExtractTo)
'#
    public function dk_extract(ZipFile, ExtractTo)
    Dim fso, objShell, FilesInZip

    ' Create FileSystemObject to manage folders
    Set fso = CreateObject("Scripting.FileSystemObject")

    ' Create the extraction folder if it does not exist
    If Not fso.FolderExists(ExtractTo) Then
        fso.CreateFolder(ExtractTo)
    End If

    ' Create a Shell Application object
    Set objShell = CreateObject("Shell.Application")

    ' Get a reference to the zip file's contents
    Set FilesInZip = objShell.NameSpace(ZipFile).items

    ' Copy the contents to the destination folder
    ' The '16' option overwrites files without prompting (optional, remove for prompts)
    objShell.NameSpace(ExtractTo).CopyHere FilesInZip, 16 

    ' Clean up objects
    Set fso = Nothing
    Set objShell = Nothing
    Set FilesInZip = Nothing

    WScript.Echo "Extraction complete!"
end function









'###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
if(ENV("DKSCRIPT_PATH") = WScript.ScriptFullName) then
public function DKTEST()
	
	dk_extract "X:\Users\Default\Digital Knob\download\npp.8.6.5.portable.x64.zip", "X:\Users\Default\Digital Knob\download\npp.8.6.5.portable.x64"
	
end function
end if
