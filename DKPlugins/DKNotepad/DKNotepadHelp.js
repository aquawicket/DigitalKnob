"use strict";

dk.notepadhelp = new Object;

dk.notepadhelp.init = function dk_notepadhelp_init() {
    dk.create("DKNotepad/DKNotepadHelp.html,DKNotepad/DKNotepad.html", function() {
        document.addEventListener("mousedown", dk.notepadhelp.onevent);
        byId("DKNotepadHelp_ViewHelp").addEventListener("click", dk.notepadhelp.onevent);
        byId("DKNotepadHelp_About").addEventListener("click", dk.notepadhelp.onevent);
    });
}

dk.notepadhelp.end = function dk_notepadhelp_end() {
    document.removeEventListener("mousedown", dk.notepadhelp.onevent);
    byId("DKNotepadHelp_ViewHelp").removeEventListener("click", dk.notepadhelp.onevent);
    byId("DKNotepadHelp_About").removeEventListener("click", dk.notepadhelp.onevent);
    dk.close("DKNotepad/DKNotepadHelp.html");
}

dk.notepadhelp.onevent = function dk_notepadhelp_onevent(event) {
    if (event.currentTarget.id === "DKNotepadHelp_ViewHelp")
        console.log("DKNotepadHelp_ViewHelp");
    if (event.currentTarget.id === "DKNotepadHelp_About")
        console.log("DKNotepadHelp_About");
    if (event.currentTarget === document) {
        if (byId("DKNotepad/DKNotepadHelp.html").contains(document.elementFromPoint(window.mouseX, window.mouseY)))
            return; 
    }
    dk.close("DKNotepad/DKNotepadHelp.js");
}
