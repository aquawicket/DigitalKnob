"use strict";

dk.notepadmenu = new DKPlugin("dk_notepadmenu");

dk.notepadmenu.init = function dk_notepadmenu_init() {
    dk.create("DKNotepad/DKNotepadMenu.html", function() {
        document.addEventListener("mousedown", dk.notepadmenu.onevent);
        byId("DKNotepadMenu_Cut").addEventListener("mousedown", dk.notepadmenu.onevent);
        byId("DKNotepadMenu_Copy").addEventListener("mousedown", dk.notepadmenu.onevent);
        byId("DKNotepadMenu_Paste").addEventListener("mousedown", dk.notepadmenu.onevent);
    });
}

dk.notepadmenu.end = function dk_notepadmenu_end() {
    document.removeEventListener("mousedown", dk.notepadmenu.onevent);
    byId("DKNotepadMenu_Cut").removeEventListener("mousedown", dk.notepadmenu.onevent);
    byId("DKNotepadMenu_Copy").removeEventListener("mousedown", dk.notepadmenu.onevent);
    byId("DKNotepadMenu_Paste").removeEventListener("mousedown", dk.notepadmenu.onevent);
    dk.close("DKNotepad/DKNotepadMenu.html");
}

dk.notepadmenu.onevent = function dk_notepadmenu_onevent(event) {
    if (event.currentTarget.id === "DKNotepadMenu_Cut") {
        DKNotepadMenu_Cut();
        PreventDefault(event);
    }
    if (event.currentTarget.id === "DKNotepadMenu_Copy")
        DKNotepadMenu_Copy();
    if (event.currentTarget.id === "DKNotepadMenu_Paste")
        DKNotepadMenu_Paste();
    if (event.currentTarget === document) {
        if (byId("DKNotepad/DKNotepadMenu.html").contains(document.elementFromPoint(window.mouseX, window.mouseY)))
            return;
    }
    dk.close("DKNotepad/DKNotepadMenu.js");
}

dk.notepadmenu.cut = function dk_notepadmenu_cut() {
    dk.clipboard.cut("DKNotepad_Text");
}

dk.notepadmenu.copy = function dk_notepadmenu_copy() {
    dk.clipboard.copy("DKNotepad_Text");
}

dk.notepadmenu.paste = function dk_notepadMenu_paste() {
    dk.clipboard.paste("DKNotepad_Text");
}
