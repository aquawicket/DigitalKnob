"use strict";

dk.solution = new DKPlugin("dk_solution");

dk.solution.init = function dk_solution_init() {
    dk.create("DKFile/DKSolution.css");
    dk.create("DKFile/DKFileAssociation.js");
    dk.solution.create();
}

dk.solution.end = function dk_solution_end() {
    dk.close("DKFile/DKSolution.html");
    dk.close("DKFile/DKSolution.css");
}

dk.solution.create = function dk_solution_create() {
     dk.create("DKFile/DKSolution.html", function dk_create_callback(html) {
        if (!html)
            return error("html invalid");
        dk.solution.html = html;
        dk.solution.setAccessNode(html);
        dk.solution.box = html.querySelector("[dk_solution='box']");
        dk.solution.up = html.querySelector("[dk_solution='up']");
        dk.solution.path = html.querySelector("[dk_solution='path']");
        dk.solution.list = html.querySelector("[dk_solution='list']");
        dk.solution.up.onclick = dk.solution.upDir;
        dk.solution.list.onclick = dk.solution.highlight;
        //dk.solution.list.oncontextmenu = dk.solution.menu;
        dk.solution.path.onkeypress = dk.solution.onPath;
        dk.solution.openFolder(dk.solution.path.value);
        dk.frame.create(dk.solution);
    });
}

dk.solution.upDir = function(event) {
    var up = dk.solution.path.value + "../";
    dk.solution.openFolder(up);
}

dk.solution.onPath = function(event) {
    if (event.code === 'Enter') {
        dk.solution.openFolder(dk.solution.path.value);
    }
}

dk.solution.highlight = function dk_solution_select(event) {
    if (event instanceof Event)
        event.stopPropagation();
    var nodes = dk.solution.list.childNodes;
    for (let n = 0; n < nodes.length; n++) {
        if (!nodes[n])
            console.error("nodes[" + n + "] invalid\n");
        nodes[n].style.backgroundColor = "rgb(255,255,255)";
        nodes[n].style.color = "rgb(0,0,0)";
    }
    if (event.currentTarget.getAttribute("dk_solution") === "folder" || event.currentTarget.getAttribute("dk_solution") === "file") {
        event.currentTarget.style.backgroundColor = "rgb(123,157,212)";
        event.currentTarget.style.color = "rgb(255,255,255)";
    }
}

dk.solution.dblclick = function(event) {
    const folder = event.currentTarget.getAttribute("folder");
    const file = event.currentTarget.getAttribute("file");
    const path = event.currentTarget.getAttribute("path");
    if (event.currentTarget.getAttribute("dk_solution") === "folder")
        dk.solution.openFolder(path);
    else if (event.currentTarget.getAttribute("dk_solution") === "file")
        dk.solution.openFile(path);
}

dk.solution.rightclickmenu = function(event) {
    event.preventDefault();
    dk.solution.highlight(event);
    const folder = event.currentTarget.getAttribute("dk_solution") === "folder";
    const file = event.currentTarget.getAttribute("dk_solution") === "file";
    const path = event.currentTarget.getAttribute("path");
    const menu = dk.menu.createInstance();
    dk.menu.addItem(menu, "Open", function dk_menu_open() {
        if (folder)
            dk.solution.openFolder(path);
        if (file)
            dk.solution.openFile(path);
    });
    dk.menu.addItem(menu, "Open In OS", function dk_menu_openinos() {
        if (folder)
            dk.solution.openFolderInOS(path);
        if (file)
            dk.solution.openFileInOS(path);
    });
    dk.menu.addItem(menu, "New File", function dk_menu_newfile() {
        dk.solution.newFile();
    });
    dk.menu.addItem(menu, "New Folder", function dk_menu_newFolder() {
        dk.solution.newFolder();
    });
    dk.menu.addItem(menu, "Rename", function dk_menu_rename() {
        dk.solution.rename(path);
    });
    dk.menu.addItem(menu, "Delete", function dk_menu_delete() {
        dk.solution.delete(path);
    });
    dk.menu.addItem(menu, "Copy", function dk_menu_copy() {
        dk.solution.copy(path);
    });
    dk.menu.addItem(menu, "Cut", function dk_menu_cut() {
        dk.solution.cut(path);
    });
    dk.menu.addItem(menu, "Paste", function dk_menu_paste() {
        dk.solution.paste();
    });
    dk.menu.addItem(menu, "Import", function dk_menu_import() {
        dk.solution.import(path);
    });
    dk.menu.addItem(menu, "Git Add", function dk_menu_gitAdd() {
        dk.solution.GitAdd(path);
    });
    dk.menu.addItem(menu, "upxCompress", function dk_menu_upxCompress() {
        dk.solution.upxCompress(path);
    });
}

dk.solution.openFolder = function dk_solution_openFolder(path) {
    return dk.solution.updatePath(path);
}
dk.solution.openFile = function dk_solution_openFolder(path) {
    return dk.fileassociation.open(path);
}
dk.solution.openFolderInOS = function dk_solution_openFolderInOS(path) {
    console.debug("TODO: dk.solution.openFolderInOS(" + path + ")");
}
dk.solution.openFileInOS = function dk_solution_openFolderInOS(path) {
    console.debug("TODO: dk.solution.openFileInOS(" + path + ")");
}
dk.solution.newFile = function dk_solution_newFile() {
    
    //Todo - advance the file number if NewFile.txt already exists
    const filename = "NewFile.txt";
    const path = dk.solution.path.value + filename;
    dk.file.stringToFile("", path, 0, function(result) {
        console.log(result);
    });

    const newFile = dk.gui.createElement(dk.solution.list, "div", "DKSolutionFile");
    newFile.setAttribute("dk_solution", "file");
    newFile.setAttribute("path", path);
    newFile.style.whiteSpace = "nowrap";
    newFile.style.paddingLeft = "17px";
    newFile.style.backgroundRepeat = "no-repeat";
    newFile.style.cursor = "default";
    newFile.innerHTML = filename;
    newFile.onclick = dk.solution.highlight;
    newFile.ondblclick = dk.solution.dblclick
    newFile.oncontextmenu = dk.solution.rightclickmenu;

    const event = {
        currentTarget: newFile
    }
    dk.solution.highlight(event);
    dk.solution.rename(newFile);
}

dk.solution.newFolder = function dk_solution_newFolder() {
    console.debug("TODO: dk.solution.newFolder");
}

dk.solution.rename = function dk_solution_rename(node) {

    const renamer = dk.gui.createElement(dk.solution.list, "div", "renamer");
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

dk.solution.delete = function dk_solution_delete(path) {
    console.debug("TODO: dk.solution.delete(" + path + ")");
}
dk.solution.copy = function dk_solution_copy(path) {
    console.debug("TODO: dk.solution.copy(" + path + ")");
}
dk.solution.cut = function dk_solution_cut(path) {
    console.debug("TODO: dk.solution.cut(" + path + ")");
}
dk.solution.paste = function dk_solution_paste(path) {
    console.debug("TODO: dk.solution.paste");
}
dk.solution.import = function dk_solution_import(path) {
    console.debug("TODO: dk.solution.import(" + path + ")");
}
dk.solution.gitAdd = function dk_solution_gitAdd(path) {
    console.debug("TODO: dk.solution.gitAdd(" + path + ")");
}
dk.solution.upxCompress = function dk_solution_upxCompress(path) {
    console.debug("TODO: dk.solution.upxCompress(" + path + ")");
}

dk.solution.updatePath = function dk_solution_updatePath(_path) {
    console.debug("dk.solution.updatPath(" + _path + ")");
    dk.file.getPathObject(_path, function dk_file_getPathObject(path) {

        dk.solution.path.value = path.aPath;
        dk.solution.list.innerHTML = "";
        dk.file.directoryContents(path.aPath, function dk_file_directoryContents_callback(results) {
            if (!results)
                return error("results invalid");
            const items = results.split(",");
            for (let d = 0; d < items.length; d++) {
                dk.file.isDir(path.aPath + items[d], function dk_file_isDir_callback(dir) {
                    if (dir) {
                        //Folders
                        const folderpath = path.aPath + items[d] + "/";
                        const folder = dk.gui.createTag("div", dk.solution.list, {
                            innerHTML: items[d],
                            onclick: dk.solution.highlight,
                            ondblclick: dk.solution.dblclick,
                            oncontextmenu: dk.solution.rightclickmenu
                        });
                        folder.setAttribute("dk_solution", "folder");
                        folder.setAttribute("path", folderpath);
                    }
                });
            }
            for (let f = 0; f < items.length; f++) {
                dk.file.isDir(path.aPath + items[f], function dk_file_isDir_callback(dir) {
                    if (!dir) {
                        //Files
                        const file = dk.gui.createElement(dk.solution.list, "div", "DKSolutionFile");
                        const filepath = path.aPath + items[f];
                        file.setAttribute("dk_solution", "file");
                        file.setAttribute("path", filepath);
                        file.style.whiteSpace = "nowrap";
                        file.style.paddingLeft = "17px";
                        file.style.backgroundRepeat = "no-repeat";
                        file.style.cursor = "default";
                        file.innerHTML = items[f];
                        file.onclick = dk.solution.highlight;
                        file.ondblclick = dk.solution.dblclick
                        file.oncontextmenu = dk.solution.rightclickmenu;

                        var extension = dk.file.getExtention(items[f]);
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
