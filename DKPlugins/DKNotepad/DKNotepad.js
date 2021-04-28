"use strict";

dk.notepad = new DKWidget();

dk.notepad.init = function dk_notepad_init() {
    dk.create("DKNotepad/DKNotepadShortcuts.js");
    dk.create("DKNotepad/DKNotepad.css");
    dk.create("DKNotepad/DKNotepad.html", function dk_create_callback(html) {
        if (!html)
            return error("html invalid");
        dk.notepad.html = html;
        html.menubar = html.querySelector("[dk_notepad='menubar']");
        html.file = html.querySelector("[dk_notepad='file']");
        html.edit = html.querySelector("[dk_notepad='edit']");
        html.format = html.querySelector("[dk_notepad='format']");
        html.view = html.querySelector("[dk_notepad='view']");
        html.help = html.querySelector("[dk_notepad='help']");
        html.container = html.querySelector("[dk_notepad='container']");
        html.text = html.querySelector("[dk_notepad='text']");

        //byId("DKNotepad.html").addEventListener("SetFile", dk.notepad.onevent);
        //byId("DKNotepad/DKNotepad.html").addEventListener("OpenFile", dk.notepad.onevent);
        //byId("DKNotepad/DKNotepad.html").addEventListener("SaveFile", dk.notepad.onevent);
        //byId("DKNotepad_Text").addEventListener("contextmenu", dk.notepad.onevent);
        html.file.onclick = function(event) {
            event.preventDefault();
            dk.create("DKNotepad/dk.notepad.file.js");
        }
        dk.notepad.currentFile = "";
        
        dk.notepad.setElement(html);
        dk.frame.create(dk.notepad);
    });
}

dk.notepad.end = function dk_notepad_end() {
    /*
    byId("DKNotepad/DKNotepad.html").removeEventListener("OpenFile", dk.notepad.onevent);
    byId("DKNotepad/DKNotepad.html").removeEventListener("SaveFile", dk.notepad.onevent);
    byId("DKNotepad_Text").removeEventListener("contextmenu", dk.notepad.onevent);
    byId("DKNotepad_File").removeEventListener("click", dk.notepad.onevent);
    byId("DKNotepad_Edit").removeEventListener("click", dk.notepad.onevent);
    byId("DKNotepad_Format").removeEventListener("click", dk.notepad.onevent);
    byId("DKNotepad_View").removeEventListener("click", dk.notepad.onevent);
    byId("DKNotepad_Help").removeEventListener("click", dk.notepad.onevent);
    */
    dk.notepad.file.close();
    dk.close("DKNotepad/DKNotepad.html");
    dk.close("DKNotepad/DKNotepad.css");
    dk.close("DKNotepad/DKNotepadShortcuts.js");
}

dk.notepad.onevent = function dk_notepad_onevent(event) {
    if (event.type === "contextmenu") {
        dk.create("DKNotepad/DKNotepadMenu.js", function() {
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
        dk.create("DKNotepad/DKNotepadFile.js", function() {});
    }
    if (event.currentTarget.id === "DKNotepad_Edit") {
        dk.create("DKNotepad/DKNotepadEdit.js", function() {});
    }
    if (event.currentTarget.id === "DKNotepad_Format") {
        dk.create("DKNotepad/DKNotepadFormat.js", function() {});
    }
    if (event.currentTarget.id === "DKNotepad_View") {
        dk.create("DKNotepad/DKNotepadView.js", function() {});
    }
    if (event.currentTarget.id === "DKNotepad_Help") {
        dk.create("DKNotepad/DKNotepadHelp.js", function() {});
    }
}

dk.notepad.open = function dk_notepad_open(file) {
    //TODO - set the frame title with the filename
    currentFile = file;
    dk.file.fileToString(currentFile, function(str) {
        byId("DKNotepad_Text").value = str;
    });
}

dk.notepad.save = function dk_notepad_save(file) {
    var text = byId("DKNotepad_Text").value;
    //console.log(("DKNotepad_Save("+file+"): text = "+text+"\n");
    DKFile_StringToFile(text, file);
}
