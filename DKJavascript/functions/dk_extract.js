// shebang
/*
//#####################################################################################################
if(typeof ActiveXObject === "function"){
	if(typeof wscript_shell !== "object")	{ var wscript_shell = new ActiveXObject("WScript.Shell"); }
	if(typeof ENV !== "object")				{ var ENV = wscript_shell.Environment("Process"); }
	if(typeof ENV === "object" && typeof wscript_shell === "object" && ENV("DKINIT_js") === "") {	
		ENV("DKINIT_js") = WScript.ScriptFullName;
		wscript_shell.Run("cmd /k mshta.exe \"file:///C:/Users/Administrator/DigitalKnob/Development/DKHta/functions/DK.hta\" | for /f \"delims=\" %a in ('findstr \"^\"') do 	@echo %a", 1, 1);
		throw new Error('Program Terminated');
	}
}
//#####################################################################################################
*/

//################################################################################
//# dk_extract(file ExtractTo)
//#
//#
//#
dk_extract = function dk_extract_f(ZipFile, ExtractTo) {
	//dk_debugFunc(0 1);
	
	if(arguments[0]){
		console.log(arguments[0]);
	}	
	

    // Create FileSystemObject to manage folders
    fso = new ActiveXObject("Scripting.FileSystemObject");

    // Create the extraction folder if it does not exist
    if(!fso.FolderExists(ExtractTo)) {
        fso.CreateFolder(ExtractTo);
    }

    // Create a Shell Application object
    var objShell = new ActiveXObject("Shell.Application");

    // Get a reference to the zip file's contents
    var FilesInZip = objShell.NameSpace(ZipFile).items;

    // Copy the contents to the destination folder
    // The '16' option overwrites files without prompting (optional, remove for prompts)
    objShell.NameSpace(ExtractTo).CopyHere(FilesInZip, 16);

    new ActiveXObject('Scripting.FileSystemObject').GetStandardStream(1).WriteLine("Extraction complete!");

    // Clean up objects
    fso = undefined;
    objShell = undefined;
    FilesInZip = undefined;
}





//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST = function DKTEST_f(){
	//dk_debugFunc(0);
	
	dk_extract("X:\Users\Default\Digital Knob\download\npp.8.6.5.portable.x64.zip", "X:\Users\Default\Digital Knob\download\npp.8.6.5.portable.x64");
}
