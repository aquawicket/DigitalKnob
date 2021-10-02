//"use strict";

function DKFileManager() {}

DKFileManager.prototype.init = function DKFileManager_init(callback) {
    DKPlugin("DKFile/DKFileAssociation.js");
    dk.create("DKFile/filemanager.css");
    callback && callback(true);
}

DKFileManager.prototype.end = function DKFileManager_end() {
    dk.close("DKFile/filemanager.css");
    dk.close("DKFile/DKFileAssociation.js");
}

DKFileManager.prototype.create = function DKFileManager_create(DKFileManager_create_callback) {
    const instance = new DKPlugin(DKFileManager)
    if (!instance)
        return error("instance invalid", DKFileManager_create_callback);

    dk.create("DKFile/filemanager.html", function dk_create_callback(html) {
        if (!html)
            return error("html invalid");
        instance.html = html;
        instance.box = html.querySelector("[dk_filemanager='box']");
        instance.up = html.querySelector("[dk_filemanager='up']");
        instance.path = html.querySelector("[dk_filemanager='path']");
        instance.list = html.querySelector("[dk_filemanager='list']");
        instance.cancel = html.querySelector("[dk_filemanager='cancel']");
        instance.ok = html.querySelector("[dk_filemanager='ok']");
        instance.up.onclick = function() {
            instance.upDir(instance, event);
        }
        instance.list.onclick = function() {
            instance.highlight(instance, event);
        }
        instance.path.onkeypress = function() {
            instance.onPath(instance, event);
        }
        instance.openFolder(instance, instance.path.value);
        instance.dkFrame = DKFrame.prototype.create(instance);
        instance.dkFrame.setTitle("File Manager");
        DKFileManager_create_callback && DKFileManager_create_callback(instance);
        return instance;
    });
}

DKFileManager.prototype.createOpen = function DKFileManager_getfile(DKFileManager_createOpen_callback) {
    instance.create(function(instance) {
        instance.dkFrame.setTitle("Open");
        instance.cancel.style.visibility = "visible";
        instance.ok.style.visibility = "visible";
        instance.cancel.onclick = function() {
            instance.close(instance);
            return true;
        }
        instance.ok.onclick = function() {
            DKFileManager_createOpen_callback(instance.currentFile);
            instance.close(instance);
            return true;
        }
    });
}

DKFileManager.prototype.createSaveAs = function DKFileManager_savefile(DKFileManager_createSaveAs_callback) {
    instance.create(function(instance) {
        instance.dkFrame.setTitle("Save As");
        instance.cancel.style.visibility = "visible";
        instance.ok.style.visibility = "visible";
        instance.cancel.onclick = function() {
            instance.close(instance);
            return true;
        }
        instance.ok.onclick = function() {
            DKFileManager_createSaveAs_callback(instance.currentFile);
            instance.close(instance);
            return true;
        }
    });
}

DKFileManager.prototype.upDir = function(instance) {
    var up = instance.path.value + "../";
    instance.openFolder(instance, up);
}

DKFileManager.prototype.onPath = function(instance) {
    if (event.code === 'Enter')
        instance.openFolder(instance, instance.path.value);
}

DKFileManager.prototype.highlight = function DKFileManager_highlight(instance, event) {
    if (event instanceof Event)
        event.stopPropagation();
    var nodes = instance.list.childNodes;
    for (let n = 0; n < nodes.length; n++) {
        if (!nodes[n])
            console.error("nodes[" + n + "] invalid\n");
        nodes[n].style.backgroundColor = instance.list.style.backgroundColor;
        nodes[n].style.color = instance.list.style.color;
    }
    if (event.currentTarget.getAttribute("dk_filemanager") === "folder" || event.currentTarget.getAttribute("dk_filemanager") === "file") {
        event.currentTarget.style.backgroundColor = "rgb(123,157,212)";
        event.currentTarget.style.color = "rgb(255,255,255)";
    }
    instance.currentFile = event.currentTarget.getAttribute("path");
}

DKFileManager.prototype.dblclick = function(instance, event) {
    const folder = event.currentTarget.getAttribute("folder");
    const file = event.currentTarget.getAttribute("file");
    const path = event.currentTarget.getAttribute("path");
    if (event.currentTarget.getAttribute("dk_filemanager") === "folder")
        instance.openFolder(instance, path);
    else if (event.currentTarget.getAttribute("dk_filemanager") === "file")
        instance.openFile(instance, path);
}

DKFileManager.prototype.rightclickmenu = function(instance, event) {
    event.preventDefault();
    instance.highlight(instance, event);
    const folder = event.currentTarget.getAttribute("dk_filemanager") === "folder";
    const file = event.currentTarget.getAttribute("dk_filemanager") === "file";
    const node = event.currentTarget;
    const path = event.currentTarget.getAttribute("path");
    DKPlugin("DKGui/DKMenu.js", function(DKClass) {
        const dkmenu = DKClass.prototype.create();
        file && dkmenu.addItem("Edit", function dk_menu_edit() {
            instance.editFile(instance, path);
        });
        dkmenu.addItem("Open", function dk_menu_open() {
            folder && instance.openFolder(instance, path);
            file && instance.openFile(instance, path);
        });
        dkmenu.addItem("Open In OS", function dk_menu_openinos() {
            folder && instance.openFolderInOS(instance, path);
            file && instance.openFileInOS(instance, path);
        });
        dkmenu.addItem("New File", function dk_menu_newfile() {
            instance.newFile(instance);
        });
        dkmenu.addItem("New Folder", function dk_menu_newFolder() {
            instance.newFolder(instance);
        });
        dkmenu.addItem("Rename", function dk_menu_rename() {
            instance.rename(instance, node);
        });
        dkmenu.addItem("Delete", function dk_menu_delete() {
            instance.delete(instance, path);
        });
        dkmenu.addItem("Copy", function dk_menu_copy() {
            instance.copy(instance, path);
        });
        dkmenu.addItem("Cut", function dk_menu_cut() {
            instance.cut(instance, path);
        });
        dkmenu.addItem("Paste", function dk_menu_paste() {
            instance.paste(instance);
        });
        dkmenu.addItem("Import", function dk_menu_import() {
            instance.import(instance, path);
        });
        dkmenu.addItem("Git Add", function dk_menu_gitAdd() {
            instance.GitAdd(instance, path);
        });
        dkmenu.addItem("upxCompress", function dk_menu_upxCompress() {
            instance.upxCompress(instance, path);
        });
    })
}

DKFileManager.prototype.editFile = function DKFileManager_editFile(instance, path) {
    return dk.fileassociation.edit(path);
}
DKFileManager.prototype.openFolder = function DKFileManager_openFolder(instance, path) {
    return instance.updatePath(instance, path);
}
DKFileManager.prototype.openFile = function DKFileManager_openFile(instance, path) {
    return dk.fileassociation.open(instance, path);
}
DKFileManager.prototype.openFolderInOS = function DKFileManager_openFolderInOS(instance, path) {
    console.debug("TODO: DKFileManager.prototype.openFolderInOS(" + path + ")");
}
DKFileManager.prototype.openFileInOS = function DKFileManager_openFolderInOS(instance, path) {
    console.debug("TODO: DKFileManager.prototype.openFileInOS(" + path + ")");
}
DKFileManager.prototype.newFile = function DKFileManager_newFile(instance) {
    const filename = "NewFile.txt";
    const path = instance.path.value + filename;
    dk.file.stringToFile("", path, 0, function(result) {
        console.log(result);
    });
    const newFile = dk.gui.createElement(instance.list, "div", "managerFile");
    newFile.setAttribute("dk_filemanager", "file");
    newFile.setAttribute("path", path);
    newFile.style.whiteSpace = "nowrap";
    newFile.style.paddingLeft = "17px";
    newFile.style.backgroundRepeat = "no-repeat";
    newFile.style.cursor = "default";
    newFile.innerHTML = filename;
    newFile.onclick = instance.highlight;
    newFile.ondblclick = instance.dblclick
    newFile.oncontextmenu = instance.rightclickmenu;
    const event = {
        currentTarget: newFile
    }
    instance.highlight(instance, event);
    instance.rename(instance, newFile);
}

DKFileManager.prototype.newFolder = function DKFileManager_newFolder(instance) {
    const foldername = "NewFolder";
    const path = instance.path.value + foldername;
    dk.file.makeDir(path, 0, true, function(result) {
        console.log(result);
    });
    const newFolder = dk.gui.createElement(instance.list, "div", "managerFolder");
    newFolder.setAttribute("dk_filemanager", "folder");
    newFolder.setAttribute("path", path);
    newFolder.style.whiteSpace = "nowrap";
    newFolder.style.paddingLeft = "17px";
    newFolder.style.backgroundRepeat = "no-repeat";
    newFolder.style.cursor = "default";
    newFolder.innerHTML = foldername;
    newFolder.onclick = instance.highlight;
    newFolder.ondblclick = instance.dblclick
    newFolder.oncontextmenu = instance.rightclickmenu;
    const event = {
        currentTarget: newFolder
    }
    instance.highlight(instance, event);
    instance.rename(instance, newFolder);
}

DKFileManager.prototype.rename = function DKFileManager_rename(instance, node) {
    const renamer = dk.gui.createElement(instance.list, "div", "renamer");
    renamer.style.position = "absolute";
    renamer.style.top = node.offsetTop;
    renamer.style.width = "100%";
    renamer.style.height = "14rem";
    const renamerInput = dk.gui.createElement(renamer, "input", "renameInput");
    renamerInput.type = "text";
    renamerInput.style.position = "absolute";
    renamerInput.style.width = "100%";
    renamerInput.style.height = "100%";
    renamerInput.value = node.innerHTML;
    setTimeout(function() {
        if (renamerInput)
            renamerInput.focus();
        document.addEventListener('mousedown', function(event) {
            doRename();
        }, {
            once: true
        });
    }, 100);
    renamerInput.onkeydown = function(event) {
        if (event.code === "Enter")
            doRename();
    }

    function doRename() {
        const oldfilename = node.innerHTML;
        const oldpath = node.getAttribute("path");
        const newfilename = renamerInput.value;
        const newpath = oldpath.replace(oldfilename, newfilename);
        if (dk.file.rename(oldpath, newpath, true) === false)
            return false;
        node.path = newpath;
        node.innerHTML = newfilename;
        renamer.remove();
        //TODO: set associated icon
    }
}

DKFileManager.prototype.delete = function DKFileManager_delete(instance, path) {
    DKPlugin("DKGui/DKMessageBox.js", function() {
        dk.messagebox.createConfirm("Delete this file?", function(result) {
            dk.file.delete(path, function(result) {
                console.log(path);
                const element = instance.list.querySelector("[path='" + path + "']");
                element.parentNode.removeChild(element);
            });
        });
    });
}
DKFileManager.prototype.copy = function DKFileManager_copy(instance, path) {
    console.debug("TODO: instance.copy(" + path + ")");
}
DKFileManager.prototype.cut = function DKFileManager_cut(instance, path) {
    console.debug("TODO: instance.cut(" + path + ")");
}
DKFileManager.prototype.paste = function DKFileManager_paste(instance, path) {
    console.debug("TODO: instance.paste");
}
DKFileManager.prototype.import = function DKFileManager_import(instance, path) {
    console.debug("TODO: instance.import(" + path + ")");
}
DKFileManager.prototype.gitAdd = function DKFileManager_gitAdd(instance, path) {
    console.debug("TODO: instance.gitAdd(" + path + ")");
}
DKFileManager.prototype.upxCompress = function DKFileManager_upxCompress(instance, path) {
    console.debug("TODO: instance.upxCompress(" + path + ")");
}

DKFileManager.prototype.updatePath = function DKFileManager_updatePath(instance, _path) {
    //console.debug("DKFileManager.prototype.updatPath(" + _path + ")");
    dk.file.getPathObject(_path, function dk_file_getPathObject(path) {
        instance.path.value = path.aPath;
        instance.list.innerHTML = "";
        dk.file.directoryContents(path.aPath, function dk_file_directoryContents_callback(results) {
            if (!results)
                return error("results invalid");
            const items = results.split(",");
            for (let n = 0; n < items.length; n++) {
                dk.file.isDir(path.aPath + items[n], function dk_file_isDir_callback(dir) {
                    if (dir) {
                        //Folders
                        const folderpath = path.aPath + items[n] + "/";
                        const folder = dk.gui.createTag("div", instance.list, {
                            innerHTML: items[n],
                            onclick: function onclick() {
                                instance.highlight(instance, event);
                            },
                            ondblclick: function ondblclick() {
                                instance.dblclick(instance, event);
                            },
                            oncontextmenu: function oncontextmenu() {
                                instance.rightclickmenu(instance, event);
                            }
                        });
                        folder.setAttribute("dk_filemanager", "folder");
                        folder.setAttribute("path", folderpath);
                    }
                });
            }
            for (let n = 0; n < items.length; n++) {
                dk.file.isDir(path.aPath + items[n], function dk_file_isDir_callback(dir) {
                    if (!dir) {
                        //Files
                        const filepath = path.aPath + items[n];
                        const file = dk.gui.createElement(instance.list, "div", "managerFile");
                        file.setAttribute("dk_filemanager", "file");
                        file.setAttribute("path", filepath);
                        file.innerHTML = items[n];
                        file.onclick = function() {
                            instance.highlight(instance, event);
                        }
                        file.ondblclick = function() {
                            instance.dblclick(instance, event);
                        }
                        file.oncontextmenu = function() {
                            instance.rightclickmenu(instance, event);
                        }
                        var extension = dk.file.getExtention(items[n]);
                        if ((extension === "png") || (extension === "jpeg") || (extension === "jpg") || (extension === "bmp") || (extension === "tiff") || (extension === "tif") || (extension === "gif") || (extension === "tga") || (extension === "ico"))
                            file.style.backgroundImage = "url(\"DKFile/picture.png\")";
                        else if ((extension === "osg") || (extension === "osgb") || (extension === "osgt") || (extension === "3dm") || (extension === "3ds") || (extension === "ac") || (extension === "ascii") || (extension === "blend") || (extension === "bvh") || (extension === "c4d") || (extension === "dae") || (extension === "dds") || (extension === "dgn") || (extension === "dwg") || (extension === "dxf") || (extension === "fbx") || (extension === "lwo") || (extension === "lws") || (extension === "ma") || (extension === "max") || (extension === "mb") || (extension === "mesh") || (extension === "mtl") || (extension === "obj") || (extension === "pov") || (extension === "skp") || (extension === "stl") || (extension === "ztl"))
                            file.style.backgroundImage = "url(\"DKFile/cube.png\")";
                        else if ((extension === "js"))
                            file.style.backgroundImage = "url(\"DKFile/js.png\")";
                        else if ((extension === "sln"))
                            file.style.backgroundImage = "url(\"DKFile/sln.png\")";
                        else if ((extension === "html") || (extension === "htm"))
                            file.style.backgroundImage = "url(\"DKFile/html.png\")";
                        else
                            file.style.backgroundImage = "url(\"DKFile/file.png\")";
                    }
                });
            }
            return true;
        });
    });
}
