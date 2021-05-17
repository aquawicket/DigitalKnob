"use strict";

dk.solution = new DKPlugin("dk_solution");

dk.solution.init = function dk_solution_init() {
    dk.create("DKFile/DKSolution.css");
    dk.create("DKFile/DKFileAssociation.js");
    dk.create("DKFile/DKSolution.html", function dk_create_callback(html) {
        if (!html)
            return error("html invalid");
        dk.solution.html = html;
        dk.solution.setAccessNode(html);
        dk.solution.box = html.querySelector("[dk_solution='box']");
        dk.solution.up = html.querySelector("[dk_solution='up']");
        dk.solution.path = html.querySelector("[dk_solution='path']");
        dk.solution.list = html.querySelector("[dk_solution='list']");
        dk.solution.up.onclick = dk.solution.onevent;
        dk.solution.list.onclick = dk.solution.onevent;
        dk.solution.list.oncontextmenu = dk.solution.onevent;
        dk.solution.path.onkeypress = dk.solution.onevent;
        dk.solution.openFolder(dk.solution.path.value);
        dk.frame.create(dk.solution);
    });
}

dk.solution.end = function dk_solution_end() {
    dk.close("DKFile/DKSolution.html");
    dk.close("DKFile/DKSolution.css");
}

dk.solution.onevent = function dk_solution_onevent(event) {
    dk.solution.select(event.currentTarget.id);

    //if (event.currentTarget.id === "click") {
    //    dk.stopPropagation(event);
    //}

    if (event.type === "contextmenu") {
        event.stopPropagation();
        event.preventDefault();
        const folder = event.currentTarget.getAttribute("folder");
        const file = event.currentTarget.getAttribute("file");
        const menu = dk.menu.createInstance();
        dk.menu.addItem(menu, "Open", function dk_menu_open() {
            if (folder)
                dk.solution.openFolder(folder);
            if (file)
                dk.solution.openFile(file);
        });
        return;
    }

    if (event.currentTarget === dk.solution.up) {
        var up = dk.solution.path.value + "../";
        dk.solution.openFolder(up);
    }

    if (event.type === "dblclick") {
        const folder = event.currentTarget.getAttribute("folder");
        const file = event.currentTarget.getAttribute("file");
        if (folder)
            dk.solution.openFolder(folder);
        if (file)
            dk.solution.openFile(file);

        //DK_ClearSelection();
        return;
    }

    if (event.currentTarget === dk.solution.path) {
        //enter key
        if (event.key === 13) {
            dk.solution.OpenFolder(dk.solution.path.value);
        }
    }
}

dk.solution.select = function dk_solution_select(id) {
    var arry = dk.solution.list.childNodes;
    for (var i = 0; i < arry.length - 1; i++) {
        if (!arry[i])
            console.error("dk.solution.select(id): arry[" + i + "] invalid\n");
    }
    arry[i].style.backgroundColor = "rgb(255,255,255)";
    arry[i].style.color = "rgb(0,0,0)";

    if (id.includes("DKSolutionFolder") || id.includes("DKSolutionFile")) {
        byId(id).style.backgroundColor = "rgb(123,157,212)";
        byId(id).style.color = "rgb(255,255,255)";
    }
}

dk.solution.openFolder = function dk_solution_openFolder(path) {
    return dk.solution.updatePath(path);
}

dk.solution.openFile = function dk_solution_openFolder(path) {
    return dk.fileassociation.open(path);
}

dk.solution.updatePath = function dk_solution_updatePath(_path) {

    //reload events
    //byId("DKSolutionUp").onclick = dk.solution.onevent;
    //byId("DKSolutionMenu").onclick = dk.solution.onevent;
    //byId("DKSolutionMenu").oncontextmenu = dk.solution.onevent;
    //byId("DKSolutionPath").onkeypress = dk.solution.onevent;

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
                        var folder = dk.gui.createElement(dk.solution.list, "div", "DKSolutionFolder");
                        //folder.setAttribute("class", "option");
                        const folderpath = path.aPath + items[d] + "/";
                        folder.setAttribute("folder", folderpath);
                        folder.style.whiteSpace = "nowrap";
                        folder.style.paddingLeft = "17px";
                        folder.innerHTML = items[d];
                        folder.style.backgroundImage = "url(\"DKFile/folder.png\")";
                        folder.style.backgroundRepeat = "no-repeat";
                        folder.cursor = "pointer";
                        folder.onclick = dk.solution.onevent;
                        folder.ondblclick = dk.solution.onevent;
                        folder.oncontextmenu = dk.solution.onevent;
                    }
                });
            }
            for (let f = 0; f < items.length; f++) {
                dk.file.isDir(path.aPath + items[f], function dk_file_isDir_callback(dir) {
                    if (!dir) {
                        //Files
                        var file = dk.gui.createElement(dk.solution.list, "div", "DKSolutionFile");
                        //file.setAttribute("class", "option");
                        const filepath = path.aPath + items[f];
                        file.setAttribute("file", filepath);
                        file.style.whiteSpace = "nowrap";
                        file.style.paddingLeft = "17px";
                        file.style.backgroundRepeat = "no-repeat";
                        file.cursor = "pointer";
                        file.innerHTML = items[f];
                        file.onclick = dk.solution.onevent;
                        file.ondblclick = dk.solution.onevent;
                        file.oncontextmenu = dk.solution.onevent;

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
