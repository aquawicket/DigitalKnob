//"use strict";
	
function DKNotepad(){}

DKNotepad.prototype.init = function dk_notepad_init(callback) {
    DKPlugin("DKNotepad/DKNotepadShortcuts.js", function(){
        dk.create("DKNotepad/DKNotepad.css");
        callback && callback(true);
    });
}

DKNotepad.prototype.end = function dk_notepad_end() {
    dk.close("DKNotepad/DKNotepad.css");
    dk.close("DKNotepad/DKNotepadShortcuts.js");
}

DKNotepad.prototype.create = function dk_notepad_create(dk_notepad_create_callback) {
    const instance = new DKPlugin(DKNotepad)
    if (!instance)
        return error("instance invalid", dk_notepad_create_callback);
    dk.create("DKNotepad/DKNotepad.html", function dk_create_callback(html) {
        if(!html)
            return error("html invalid")
		if(!instance)
			return error("instance invalid")
        instance.html = html
        instance.menubar = html.querySelector("[dk_notepad='menubar']")
        instance.file = html.querySelector("[dk_notepad='file']")
        instance.edit = html.querySelector("[dk_notepad='edit']")
        instance.format = html.querySelector("[dk_notepad='format']")
        instance.view = html.querySelector("[dk_notepad='view']")
        instance.help = html.querySelector("[dk_notepad='help']")
        instance.container = html.querySelector("[dk_notepad='container']")
        instance.text = html.querySelector("[dk_notepad='text']")
        instance.file.onclick = function(event) {
            instance.filemenu(instance, event)
        }
        instance.edit.onclick = function(event) {
            instance.editmenu(instance, event)
        }
        instance.format.onclick = function(event) {
            instance.formatmenu(instance, event)
        }
        instance.view.onclick = function(event) {
            instance.viewmenu(instance, event)
        }
        instance.help.onclick = function(event) {
            instance.helpmenu(instance, event)
        }
        instance.container.oncontextmenu = function(event) {
            instance.rightclickmenu(instance, event)
        }
        instance.currentFile = ""
        instance.dkframe = DKFrame.prototype.create(instance)
        dk_notepad_create_callback && dk_notepad_create_callback(instance)
        return instance
    });
}

DKNotepad.prototype.createOpen = function dk_notepad_createOpen(file) {
    this.create(function(instance) {
        instance.dkframe.setTitle("DKNotepad - " + file);
        instance.dkframe.dkplugin.currentfile = file;
        dk.file.fileToString(file, function(str) {
            frame.dkplugin.text.value = str;
        });
    });
}

DKNotepad.prototype.filemenu = function dk_notepad_filemenu(REMOVEME, event) {
    const instance = this;
    const menu = dk.menu.createInstance();
    dk.menu.addItem(menu, "New", function dk_menu_new() {
        instance.text.value = "";
        instance.currentFile = "";
    });
    dk.menu.addItem(menu, "Open", function dk_menu_open() {
        DKPlugin("DKFile/filemanager.js", function() {
            dk.filemanager.createOpen(function(file) {
                dk.frame.setTitle(instance, "DKNotepad - " + file);
                instance.currentFile = file;
                dk.file.fileToString(file, function(str) {
                    instance.text.value = str;
                });
            });
        });
    });
    dk.menu.addItem(menu, "Save", function dk_menu_save() {
        if (!instance.currentFile) {
            instance.saveAs();
            return;
        }
        var str = instance.text.value;
        dk.file.stringToFile(str, instance.currentFile, 0, function(result) {
            alert("File Saved");
        });
    });
    dk.menu.addItem(menu, "Save As", function dk_menu_saveas() {
        DKPlugin("DKFile/filemanager.js", function() {
            dk.filemanager.createSaveAs(function(file) {
                console.debug("dk.filemanager.saveFile: " + file);
                dk.file.StringToFile(instance.text.value, file, 0, function(result) {
                    alert("File Saved");
                });
            });
        });
    });
    dk.menu.addItem(menu, "Print", function dk_menu_saveas() {//CPP_DKCef_Print(0);
    });
    dk.menu.addItem(menu, "Exit", function dk_menu_exit() {
        instance.close(instance);
    });
}
DKNotepad.prototype.editmenu = function dk_notepad_editmenu(instance, event) {
    console.debug("DKNotepad.prototype.editmenu");
}
DKNotepad.prototype.formatmenu = function dk_notepad_formatmenu(instance, event) {
    console.debug("DKNotepad.prototype.formatmenu");
}
DKNotepad.prototype.viewmenu = function dk_notepad_viewmenu(instance, event) {
    console.debug("DKNotepad.prototype.viewmenu");
}
DKNotepad.prototype.helpmenu = function dk_notepad_helpmenu(instance, event) {
    console.debug("DKNotepad.prototype.helpmenu");
}
DKNotepad.prototype.rightclickmenu = function dk_notepad_rightclickmeny(instance, event) {
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
