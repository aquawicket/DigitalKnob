"use strict";

dk.notepadfile = new DKWidget("dk.notepadfile");

dk.notepadfile.init = function dk_notepad_file_init() {

    const menu = dk.menu.createInstance(dk.notepad.html.container);
    dk.menu.addItem(menu, "New", function() {
        dk.notepadfile.new();
    });
    dk.menu.addItem(menu, "Open", function() {
        console.log("Open");
        dk.notepadfile.open();
    });
    dk.menu.addItem(menu, "Save", function() {
        console.log("Save");
    });
    dk.menu.addItem(menu, "SaveAs", function() {
        console.log("SaveAs");
    });
    dk.menu.addItem(menu, "Print", function() {
        console.log("Print");
    });
    dk.menu.addItem(menu, "Exit", function(event) {
        dk.frame.close(dk.notepad.html);
    });
    menu.style.top = "0rem";
    menu.style.left = "0rem";
    menu.style.width = "80rem";

    /*
	dk.create("DKNotepad/DKNotepadFile.html,DKNotepad/DKNotepad.html");
	document.addEventListener("mousedown", DKNotepadFile_onevent);
	byId("DKNotepadFile_New").addEventListener("click", DKNotepadFile_onevent);
	byId("DKNotepadFile_Open").addEventListener("click", DKNotepadFile_onevent);
	byId("DKNotepadFile_Save").addEventListener("click", DKNotepadFile_onevent);
	byId("DKNotepadFile_SaveAs").addEventListener("click", DKNotepadFile_onevent);
	byId("DKNotepadFile_Print").addEventListener("click", DKNotepadFile_onevent);
	byId("DKNotepadFile_Exit").addEventListener("click", DKNotepadFile_onevent);
	*/
}

/*
////////////////////////////
function DKNotepadFile_End() {/*
	document.removeEventListener("mousedown", DKNotepadFile_onevent);
	byId("DKNotepadFile_New").removeEventListener("click", DKNotepadFile_onevent); //FIXME:   DKNotepadFile_New undefined
	byId("DKNotepadFile_Open").removeEventListener("click", DKNotepadFile_onevent);
	byId("DKNotepadFile_Save").removeEventListener("click", DKNotepadFile_onevent);
	byId("DKNotepadFile_SaveAs").removeEventListener("click", DKNotepadFile_onevent);
	byId("DKNotepadFile_Print").removeEventListener("click", DKNotepadFile_onevent);
	byId("DKNotepadFile_Exit").removeEventListener("click", DKNotepadFile_onevent);
	dk.close("DKNotepad/DKNotepadFile.html");
}

/////////////////////////////////////
function DKNotepadFile_OnEvent(event) {
	//console.warn("DKNotepadFile_OnEvent("+event.currentTarget.id+","+event.type+","+event.value+")");
	if(event.currentTarget.id === "DKNotepadFile_New"){
		DKNotepadFile_New();
	}
	if(event.currentTarget.id === "DKNotepadFile_Open"){
		DKNotepadFile_Open();
	}
	if(event.currentTarget.id === "DKNotepadFile_Save"){
		DKNotepadFile_Save();
	}
	if(event.currentTarget.id === "DKNotepadFile_SaveAs"){
		DKNotepadFile_SaveAs();
	}
	if(event.currentTarget.id === "DKNotepadFile_Print"){
		DKNotepadFile_Print();
	}
	if(event.currentTarget.id === "DKNotepadFile_Exit"){
		dk.close("DKNotepad/DKNotepadFile.js");
		DKFrame_Close("DKNotepad/DKNotepad.html");
	}
	
	//FIXME
	if(event.currentTarget === document){
		if(byId("DKNotepad/DKNotepadFile.html").contains(document.elementFromPoint(window.mouseX, window.mouseY))){
			return;
		}
	}
	dk.close("DKNotepad/DKNotepadFile.js");
}
*/

dk.notepadfile.new = function dk_notepad_file_new() {
    console.debug("dk.notepadfile.new()");
    dk.notepad.html.text.value = "";
    dk.notepad.currentFile = "";
}

/////////////////////////////
function DKNotepadFile_New() {
    byId("DKNotepad_Text").value = "";
    currentFile = "";
}

/////////////////////////////
function DKNotepadFile_Open() {
    dk.create("DKFile/DKOpenFile.js", function() {
        DKFrame_Html("DKFile/DKOpenFile.html");
        DKOpenFile_UpdatePath("/");
        //DKSendEvent("DKFile/DKOpenFile.html", "GetFile", "DKNotepad/DKNotepad.html,OpenFile,/,absolute"); // To -> DKOpenFile
    });
}

/////////////////////////////
function DKNotepadFile_Save() {
    if (!currentFile) {
        DKNotepadFile_SaveAs();
        return;
    }
    var text = byId("DKNotepad_Text").value;
    //var assets = DKAssets_LocalAssets();
    //console.log("DKNotepadFile_Save(): text = "+text);
    dk.file.stringToFile(text, currentFile);
    dk.create("DKGui/DKMessageBox.js", function() {
        DKFrame_Html("DKGui/DKMessageBox.html");
        DKMessageBox_Message("File Saved");
    });
}

///////////////////////////////
function DKNotepadFile_SaveAs() {
    dk.create("DKFile/DKSaveFile.js", function() {
        DKFrame_Html("DKFile/DKSaveFile.html");

        var event = new Object("SetFile");
        //var event = new Event("SetFile"); //FIXME
        event.currentTarget = byId("DKFile/DKSaveFile.html");
        event.type = "SetFile";
        event.value = "DKNotepad/DKNotepad.html,SaveFile,/,absolute";
        window.addEventListener("SetFile", function() {
            console.log("Creating events is working!")
        }, false);
        window.dispatchEvent(event);
        byId("DKFile/DKSaveFile.html").dispatchEvent(event);

        //DKSendEvent("DKFile/DKSaveFile.html", "SetFile", "DKNotepad/DKNotepad.html,SaveFile,/,absolute"); // To -> DKFileDialog
    });
}

//////////////////////////////
function DKNotepadFile_Print() {
    CPP_DKCef_Print(0);
}

/////////////////////////////////////
function DKNotepadFile_CheckForSave() {
    console.log("TODO\n");
}
