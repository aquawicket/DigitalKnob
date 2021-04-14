var currentFile;

/////////////////////////
function DKNotepad_Init() {
    DK_Create("DKNotepad/DKNotepad.html", function() {
        DK_Create("DKNotepad/DKNotepadShortcuts.js");
        DK_Create("DKNotepad/DKNotepad.css");
        //byId("DKNotepad.html").addEventListener("SetFile", DKNotepad_OnEvent);
        byId("DKNotepad/DKNotepad.html").addEventListener("OpenFile", DKNotepad_OnEvent);
        byId("DKNotepad/DKNotepad.html").addEventListener("SaveFile", DKNotepad_OnEvent);
        byId("DKNotepad_Text").addEventListener("contextmenu", DKNotepad_OnEvent);
        byId("DKNotepad_File").addEventListener("click", DKNotepad_OnEvent);
        byId("DKNotepad_Edit").addEventListener("click", DKNotepad_OnEvent);
        byId("DKNotepad_Format").addEventListener("click", DKNotepad_OnEvent);
        byId("DKNotepad_View").addEventListener("click", DKNotepad_OnEvent);
        byId("DKNotepad_Help").addEventListener("click", DKNotepad_OnEvent);
    });
}

////////////////////////
function DKNotepad_End() {
    byId("DKNotepad/DKNotepad.html").removeEventListener("OpenFile", DKNotepad_OnEvent);
    byId("DKNotepad/DKNotepad.html").removeEventListener("SaveFile", DKNotepad_OnEvent);
    byId("DKNotepad_Text").removeEventListener("contextmenu", DKNotepad_OnEvent);
    byId("DKNotepad_File").removeEventListener("click", DKNotepad_OnEvent);
    byId("DKNotepad_Edit").removeEventListener("click", DKNotepad_OnEvent);
    byId("DKNotepad_Format").removeEventListener("click", DKNotepad_OnEvent);
    byId("DKNotepad_View").removeEventListener("click", DKNotepad_OnEvent);
    byId("DKNotepad_Help").removeEventListener("click", DKNotepad_OnEvent);
    //DK_Close("DKNotepad/DKNotepad.html");
    //DK_Close("DKNotepad/DKNotepad.css");
}

/////////////////////////////////
function DKNotepad_OnEvent(event) {
    if (event.type === "contextmenu") {
        DK_Create("DKNotepad/DKNotepadMenu.js", function() {
            DKMenu_ValidatePosition("DKNotepad/DKNotepadMenu.html");
        });
    }
    if (event.type === "OpenFile") {
        DKNotepad_Open(event.value);
    }
    if (event.type === "SaveFile") {
        DKNotepad_Save(event.value);
    }
    //if(event.type === "SetFile"){
    //	DKNotepad_Open(event.value);
    //}
    if (event.currentTarget.id === "DKNotepad_File") {
        DK_Create("DKNotepad/DKNotepadFile.js", function() {});
    }
    if (event.currentTarget.id === "DKNotepad_Edit") {
        DK_Create("DKNotepad/DKNotepadEdit.js", function() {});
    }
    if (event.currentTarget.id === "DKNotepad_Format") {
        DK_Create("DKNotepad/DKNotepadFormat.js", function() {});
    }
    if (event.currentTarget.id === "DKNotepad_View") {
        DK_Create("DKNotepad/DKNotepadView.js", function() {});
    }
    if (event.currentTarget.id === "DKNotepad_Help") {
        DK_Create("DKNotepad/DKNotepadHelp.js", function() {});
    }
}

/////////////////////////////
function DKNotepad_Open(file) {
    //TODO - only open files under 5mb
    //TODO - set the frame title with the filename
    currentFile = file;
    PHP_FileToString(currentFile, function(str) {
        byId("DKNotepad_Text").value = str;
    });
}

/////////////////////////////
function DKNotepad_Save(file) {
    var text = byId("DKNotepad_Text").value;
    //console.log(("DKNotepad_Save("+file+"): text = "+text+"\n");
    DKFile_StringToFile(text, file);
}
