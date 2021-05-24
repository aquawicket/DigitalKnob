"use strict";

dk.notepad = new DKPlugin("dk_notepad");

dk.notepad.init = function dk_notepad_init(callback) {
    dk.create("DKNotepad/DKNotepadShortcuts.js");
    dk.create("DKNotepad/DKNotepad.css");
    callback(true);
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
    //dk.notepad.file.close();
    //dk.close("DKNotepad/DKNotepad.html");
    dk.close("DKNotepad/DKNotepad.css");
    dk.close("DKNotepad/DKNotepadShortcuts.js");
}

dk.notepad.create = function dk_notepad_create(dk_notepad_create_callback) {
    const instance = new DKPlugin("new");
    if (!instance)
        return error("instance invalid", dk_notepad_create_callback);

    dk.create("DKNotepad/DKNotepad.html", function dk_create_callback(html) {
        if (!html)
            return error("html invalid");
        instance.html = html;
        instance.setAccessNode(html);
        instance.menubar = html.querySelector("[dk_notepad='menubar']");
        instance.file = html.querySelector("[dk_notepad='file']");
        instance.edit = html.querySelector("[dk_notepad='edit']");
        instance.format = html.querySelector("[dk_notepad='format']");
        instance.view = html.querySelector("[dk_notepad='view']");
        instance.help = html.querySelector("[dk_notepad='help']");
        instance.container = html.querySelector("[dk_notepad='container']");
        instance.text = html.querySelector("[dk_notepad='text']");
        instance.file.onclick = function() {
            dk.notepad.filemenu(instance, event);
        }
        instance.edit.onclick = function() {
            dk.notepad.editmenu(instance, event);
        }
        instance.format.onclick = function() {
            dk.notepad.formatmenu(instance, event);
        }
        instance.view.onclick = function() {
            dk.notepad.viewmenu(instance, event);
        }
        instance.help.onclick = function() {
            dk.notepad.helpmenu(instance, event);
        }
        instance.container.oncontextmenu = function() {
            dk.notepad.rightclickmenu(instance, event);
        }
        instance.currentFile = "";
        dk.frame.create(instance);
        return dk_notepad_create_callback && dk_notepad_create_callback(instance);
    });
}

dk.notepad.filemenu = function dk_notepad_filemenu(instance, event) {
    console.debug("dk.notepad.filemenu");
    const menu = dk.menu.createInstance();
    dk.menu.addItem(menu, "New", function dk_menu_new() {
        instance.text.value = "";
        instance.currentFile = "";
    });
    dk.menu.addItem(menu, "Open", function dk_menu_open() {
        dk.create("DKFile/DKOpenFile.js", function() {
            dk.openfile.create();
            dk.openfile.updatePath("/");
            //DKSendEvent("DKFile/DKOpenFile.html", "GetFile", "DKNotepad/DKNotepad.html,OpenFile,/,absolute"); // To -> DKOpenFile
        });
    });
    dk.menu.addItem(menu, "Save", function dk_menu_save() {
        if (!currentFile) {
            DKNotepadFile_SaveAs();
            return;
        }
        var text = byId("DKNotepad_Text").value;
        //var assets = DKAssets_LocalAssets();
        //console.log("DKNotepadFile_Save(): text = "+text);
        DKFile_StringToFile(text, currentFile);
        dk.create("DKGui/DKMessageBox.js", function() {
            DKFrame_Html("DKGui/DKMessageBox.html");
            DKMessageBox_Message("File Saved");
        });
    });
    dk.menu.addItem(menu, "Save As", function dk_menu_saveas() {
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
    });
    dk.menu.addItem(menu, "Print", function dk_menu_saveas() {//CPP_DKCef_Print(0);
    });
    dk.menu.addItem(menu, "Exit", function dk_menu_exit() {});
}
dk.notepad.editmenu = function dk_notepad_editmenu(instance, event) {
    console.debug("dk.notepad.editmenu");
}
dk.notepad.formatmenu = function dk_notepad_formatmenu(instance, event) {
    console.debug("dk.notepad.formatmenu");
}
dk.notepad.viewmenu = function dk_notepad_viewmenu(instance, event) {
    console.debug("dk.notepad.viewmenu");
}
dk.notepad.helpmenu = function dk_notepad_helpmenu(instance, event) {
    console.debug("dk.notepad.helpmenu");
}
dk.notepad.rightclickmenu = function dk_notepad_rightclickmeny(instance, event) {
    event.preventDefault();
    const menu = dk.menu.createInstance();
    dk.menu.addItem(menu, "Cut", function dk_menu_cut() {
        dk.clipboard.cut(instance.text);
    });
    dk.menu.addItem(menu, "Copy", function dk_menu_copy() {
        dk.clipboard.copy(instance.text);
    });
    dk.menu.addItem(menu, "Paste", function dk_menu_paste() {
        dk.clipboard.paste(instance.text);
    });
}

dk.notepad.onevent = function dk_notepad_onevent(event) {
    if (event.type === "OpenFile") {
        DKNotepad_Open(event.value);
    }
    if (event.type === "SaveFile") {
        DKNotepad_Save(event.value);
    }
    //if(event.type === "SetFile"){
    //	DKNotepad_Open(event.value);
    //}
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
