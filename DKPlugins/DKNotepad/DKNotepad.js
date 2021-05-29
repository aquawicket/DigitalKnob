"use strict";

dk.notepad = new DKPlugin("dk_notepad");

dk.notepad.init = function dk_notepad_init(callback) {
    dk.create("DKNotepad/DKNotepadShortcuts.js");
    dk.create("DKNotepad/DKNotepad.css");
    callback(true);
}

dk.notepad.end = function dk_notepad_end() {
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
        return dk_notepad_create_callback(instance);
    });
}

dk.notepad.close = function dk_notepad_close(instance) {
    dk.frame.close(instance);
}

dk.notepad.createOpen = function dk_notepad_createOpen(file) {
    dk.notepad.create(function(instance) {
        dk.frame.setTitle(instance, "DKNotepad - "+file);
        instance.currentFile = file;
        dk.file.fileToString(file, function(str) {
            instance.text.value = str;
        });
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
        dk.create("DKFile/filemanager.js", function() {
            dk.filemanager.createOpen(function(file) {
                dk.frame.setTitle(instance, "DKNotepad - "+file);
                instance.currentFile = file;
                dk.file.fileToString(file, function(str) {
                    instance.text.value = str;
                });
            });
        });
    });
    dk.menu.addItem(menu, "Save", function dk_menu_save() {
        if (!instance.currentFile) {
            dk.notepad.saveAs();
            return;
        }
        var str = instance.text.value;
        dk.file.stringToFile(str, instance.currentFile, 0, function(result) {
            alert("File Saved");
        });
    });
    dk.menu.addItem(menu, "Save As", function dk_menu_saveas() {
        dk.create("DKFile/filemanager.js", function() {
            dk.filemanager.createSaveAs(function(file) {
                console.debug("dk.filemanager.saveFile: " + file);
                dk.file.StringToFile(instance.text.value, file, 0, function(result){
                    alert("File Saved");
                });
            });
        });
    });
    dk.menu.addItem(menu, "Print", function dk_menu_saveas() {//CPP_DKCef_Print(0);
    });
    dk.menu.addItem(menu, "Exit", function dk_menu_exit() {
        dk.notepad.close(instance);
    });
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
