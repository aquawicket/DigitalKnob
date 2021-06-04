"use strict";

function DKNotepadEdit_init() {
    dk.create("DKNotepad/DKNotepadEdit.html,DKNotepad/DKNotepad.html");
    document.addEventListener("mousedown", DKNotepadEdit_onevent);
    byId("DKNotepadEdit_Undo").addEventListener("click", DKNotepadEdit_onevent);
    byId("DKNotepadEdit_Cut").addEventListener("click", DKNotepadEdit_onevent);
    byId("DKNotepadEdit_Copy").addEventListener("click", DKNotepadEdit_onevent);
    byId("DKNotepadEdit_Paste").addEventListener("click", DKNotepadEdit_onevent);
    byId("DKNotepadEdit_Delete").addEventListener("click", DKNotepadEdit_onevent);
    byId("DKNotepadEdit_Find").addEventListener("click", DKNotepadEdit_onevent);
}

function DKNotepadEdit_end() {
    document.removeEventListener("mousedown", DKNotepadEdit_onevent);
    byId("DKNotepadEdit_Undo").removeEventListener("click", DKNotepadEdit_onevent);
    byId("DKNotepadEdit_Cut").removeEventListener("click", DKNotepadEdit_onevent);
    byId("DKNotepadEdit_Copy").removeEventListener("click", DKNotepadEdit_onevent);
    byId("DKNotepadEdit_Paste").removeEventListener("click", DKNotepadEdit_onevent);
    byId("DKNotepadEdit_Delete").removeEventListener("click", DKNotepadEdit_onevent);
    byId("DKNotepadEdit_Find").removeEventListener("click", DKNotepadEdit_onevent);
    dk.close("DKNotepad/DKNotepadEdit.html");
}

function DKNotepadEdit_OnEvent(event) {
    if (event.currentTarget.id === "DKNotepadEdit_Undo") {
        console.log("DKNotepadEdit_Undo\n");
    }
    if (event.currentTarget.id === "DKNotepadEdit_Cut") {
        console.log("DKNotepadEdit_Cut\n");
    }
    if (event.currentTarget.id === "DKNotepadEdit_Copy") {
        console.log("DKNotepadEdit_Copy\n");
    }
    if (event.currentTarget.id === "DKNotepadEdit_Paste") {
        console.log("DKNotepadEdit_Paste\n");
    }
    if (event.currentTarget.id === "DKNotepadEdit_Delete") {
        console.log("DKNotepadEdit_Delete\n");
    }
    if (event.currentTarget.id === "DKNotepadEdit_Find") {
        console.log("DKNotepadEdit_Find\n");
    }

    // FIXME
    if (event.currentTarget === document) {
        if (byId("DKNotepad/DKNotepadEdit.html").contains(document.elementFromPoint(window.mouseX, window.mouseY))) {
            return;
        }
    }
    dk.close("DKNotepad/DKNotepadEdit.js");
}
