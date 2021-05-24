"use strict";

dk.filemanager = new DKPlugin("dk_filemanager");

dk.filemanager.init = function dk_filemanager_init(callback) {
    dk.create("DKFile/DKFileAssociation.js");
    dk.create("DKFile/filemanager.css");
    callback(true);
}

dk.filemanager.end = function dk_filemanager_end() {
    //dk.close("DKFile/manager.html");
    dk.close("DKFile/filemanager.css");
    dk.create("DKFile/DKFileAssociation.js");
}

dk.filemanager.create = function dk_filemanager_create(dk_filemanager_create_callback) {
    const instance = new DKPlugin("new");
    if (!instance)
        return error("instance invalid", dk_filemanager_create_callback);

    dk.create("DKFile/filemanager.html", function dk_create_callback(html) {
        if (!html)
            return error("html invalid");
        instance.html = html;
        instance.setAccessNode(html);
        instance.box = html.querySelector("[dk_filemanager='box']");
        instance.up = html.querySelector("[dk_filemanager='up']");
        instance.path = html.querySelector("[dk_filemanager='path']");
        instance.list = html.querySelector("[dk_filemanager='list']");
        instance.cancel = html.querySelector("[dk_filemanager='cancel']");
        instance.ok = html.querySelector("[dk_filemanager='ok']");
        instance.up.onclick = function() {
            dk.filemanager.upDir(instance, event);
        }
        instance.list.onclick = function() {
            dk.filemanager.highlight(instance, event);
        }
        instance.path.onkeypress = function() {
            dk.filemanager.onPath(instance, event);
        }
        dk.filemanager.openFolder(instance, instance.path.value);
        dk.frame.create(instance);
        return dk_filemanager_create_callback && dk_filemanager_create_callback(instance);
    });
}

dk.filemanager.getFile = function dk_filemanager_getfile(callback){
    dk.filemanager.create(function(instance){
        //TODO - cancel and ok buttons here
        instance.cancel.style.visibility = "visible";
        instance.ok.style.visibility = "visible";
    });
}

dk.filemanager.upDir = function(instance) {
    var up = instance.path.value + "../";
    dk.filemanager.openFolder(instance, up);
}

dk.filemanager.onPath = function(instance) {
    if (event.code === 'Enter')
        dk.filemanager.openFolder(instance, instance.path.value);
}

dk.filemanager.highlight = function dk_filemanager_highlight(instance, event) {
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
}

dk.filemanager.dblclick = function(instance, event) {
    const folder = event.currentTarget.getAttribute("folder");
    const file = event.currentTarget.getAttribute("file");
    const path = event.currentTarget.getAttribute("path");
    if (event.currentTarget.getAttribute("dk_filemanager") === "folder")
        dk.filemanager.openFolder(instance, path);
    else if (event.currentTarget.getAttribute("dk_filemanager") === "file")
        dk.filemanager.openFile(instance, path);
}

dk.filemanager.rightclickmenu = function(instance, event) {
    event.preventDefault();
    dk.filemanager.highlight(instance, event);
    const folder = event.currentTarget.getAttribute("dk_filemanager") === "folder";
    const file = event.currentTarget.getAttribute("dk_filemanager") === "file";
    const node = event.currentTarget;
    const path = event.currentTarget.getAttribute("path");
    const menu = dk.menu.createInstance();
    file && dk.menu.addItem(menu, "Edit", function dk_menu_edit() {
            dk.filemanager.editFile(instance, path);
        });
    dk.menu.addItem(menu, "Open", function dk_menu_open() {
        folder && dk.filemanager.openFolder(instance, path);
        file && dk.filemanager.openFile(instance, path);
    });
    dk.menu.addItem(menu, "Open In OS", function dk_menu_openinos() {
        folder && dk.filemanager.openFolderInOS(instance, path);
        file && dk.filemanager.openFileInOS(instance, path);
    });
    dk.menu.addItem(menu, "New File", function dk_menu_newfile() {
        dk.filemanager.newFile(instance);
    });
    dk.menu.addItem(menu, "New Folder", function dk_menu_newFolder() {
        dk.filemanager.newFolder(instance);
    });
    dk.menu.addItem(menu, "Rename", function dk_menu_rename() {
        dk.filemanager.rename(instance, node);
    });
    dk.menu.addItem(menu, "Delete", function dk_menu_delete() {
        dk.filemanager.delete(instance, path);
    });
    dk.menu.addItem(menu, "Copy", function dk_menu_copy() {
        dk.filemanager.copy(instance, path);
    });
    dk.menu.addItem(menu, "Cut", function dk_menu_cut() {
        dk.filemanager.cut(instance, path);
    });
    dk.menu.addItem(menu, "Paste", function dk_menu_paste() {
        dk.filemanager.paste(instance);
    });
    dk.menu.addItem(menu, "Import", function dk_menu_import() {
        dk.filemanager.import(instance, path);
    });
    dk.menu.addItem(menu, "Git Add", function dk_menu_gitAdd() {
        dk.filemanager.GitAdd(instance, path);
    });
    dk.menu.addItem(menu, "upxCompress", function dk_menu_upxCompress() {
        dk.filemanager.upxCompress(instance, path);
    });
}

dk.filemanager.editFile = function dk_filemanager_editFile(instance, path) {
    return dk.fileassociation.edit(path);
}
dk.filemanager.openFolder = function dk_filemanager_openFolder(instance, path) {
    return dk.filemanager.updatePath(instance, path);
}
dk.filemanager.openFile = function dk_filemanager_openFolder(instance, path) {
    return dk.fileassociation.open(instance, path);
}
dk.filemanager.openFolderInOS = function dk_filemanager_openFolderInOS(instance, path) {
    console.debug("TODO: dk.filemanager.openFolderInOS(" + path + ")");
}
dk.filemanager.openFileInOS = function dk_filemanager_openFolderInOS(instance, path) {
    console.debug("TODO: dk.filemanager.openFileInOS(" + path + ")");
}
dk.filemanager.newFile = function dk_filemanager_newFile(instance) {
    //Todo - advance the file number if NewFile.txt already exists
    const filename = "NewFile.txt";
    const path = instance.path.value + filename;
    dk.file.stringToFile("", path, 0, function(result) {
        console.log(result);
    });
    const newFile = dk.gui.createElement(dk.filemanager.list, "div", "managerFile");
    newFile.setAttribute("dk_filemanager", "file");
    newFile.setAttribute("path", path);
    newFile.style.whiteSpace = "nowrap";
    newFile.style.paddingLeft = "17px";
    newFile.style.backgroundRepeat = "no-repeat";
    newFile.style.cursor = "default";
    newFile.innerHTML = filename;
    newFile.onclick = dk.filemanager.highlight;
    newFile.ondblclick = dk.filemanager.dblclick
    newFile.oncontextmenu = dk.filemanager.rightclickmenu;
    const event = {
        currentTarget: newFile
    }
    dk.filemanager.highlight(instance, event);
    dk.filemanager.rename(instance, newFile);
}

dk.filemanager.newFolder = function dk_filemanager_newFolder(instance) {
    console.debug("TODO: dk.filemanager.newFolder");
}

dk.filemanager.rename = function dk_filemanager_rename(instance, node) {
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
    renamerInput.focus();
    renamerInput.onkeydown = function(event) {
        if (event.code === "Enter") {
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
}

dk.filemanager.delete = function dk_filemanager_delete(instance, path) {
    console.debug("TODO: dk.filemanager.delete(" + path + ")");
}
dk.filemanager.copy = function dk_filemanager_copy(instance, path) {
    console.debug("TODO: dk.filemanager.copy(" + path + ")");
}
dk.filemanager.cut = function dk_filemanager_cut(instance, path) {
    console.debug("TODO: dk.filemanager.cut(" + path + ")");
}
dk.filemanager.paste = function dk_filemanager_paste(instance, path) {
    console.debug("TODO: dk.filemanager.paste");
}
dk.filemanager.import = function dk_filemanager_import(instance, path) {
    console.debug("TODO: dk.filemanager.import(" + path + ")");
}
dk.filemanager.gitAdd = function dk_filemanager_gitAdd(instance, path) {
    console.debug("TODO: dk.filemanager.gitAdd(" + path + ")");
}
dk.filemanager.upxCompress = function dk_filemanager_upxCompress(instance, path) {
    console.debug("TODO: dk.filemanager.upxCompress(" + path + ")");
}

dk.filemanager.updatePath = function dk_filemanager_updatePath(instance, _path) {
    console.debug("dk.filemanager.updatPath(" + _path + ")");
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
                                dk.filemanager.highlight(instance, event);
                            },
                            ondblclick: function ondblclick() {
                                dk.filemanager.dblclick(instance, event);
                            },
                            oncontextmenu: function oncontextmenu() {
                                dk.filemanager.rightclickmenu(instance, event);
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
                            dk.filemanager.highlight(instance, event);
                        }
                        file.ondblclick = function() {
                            dk.filemanager.dblclick(instance, event);
                        }
                        file.oncontextmenu = function() {
                            dk.filemanager.rightclickmenu(instance, event);
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
