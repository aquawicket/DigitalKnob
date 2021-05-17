"use strict";

dk.solution = new DKPlugin("dk_solution");

dk.solution.init = function dk_solution_init() {
    dk.create("DKFile/DKSolution.css");
    dk.create("DKFile/DKFileAssociation.js");
    dk.create("DKFile/DKSolution.html", function dk_create_callback(html) {
        if (!html)
            return error("html invalid");
        dk.solution.html = html;
        byId("DKSolutionUp").onclick = dk.solution.onevent;
        byId("DKSolutionMenu").onclick = dk.solution.onevent;
        byId("DKSolutionMenu").oncontextmenu = dk.solution.onevent;
        byId("DKSolutionPath").onkeypress = dk.solution.onevent;
        dk.solution.openFolder(byId("DKSolutionPath").value);

        dk.solution.setAccessNode(html);
        dk.frame.create(dk.solution);
    });
}

dk.solution.end = function dk_solution_end() {
    //byId("DKSolutionUp").removeEventListener("click", dk.solution.onevent);
    //byId("DKSolutionMenu").removeEventListener("click", dk.solution.onevent);
    //byId("DKSolutionMenu").removeEventListener("contextmenu", dk.solution.onevent);
    //byId("DKSolutionPath").removeEventListener("keypress", dk.solution.onevent);
    dk.close("DKFile/DKSolution.html");
    dk.close("DKFile/DKSolution.css");
}

dk.solution.onevent = function dk_solution_onevent(event) {
    console.debug("dk.solution.onevent(" + event.currentTarget.id + "," + event.type + "," + event.value + ")");
    dk.solution.select(event.currentTarget.id);

    if (event.currentTarget.id === "click") {
        dk.stopPropagation(event);
    }

    if (event.type === "contextmenu") {
        event.stopPropagation();
        event.preventDefault();
        const path = event.currentTarget.getAttribute("path");
        const menu = dk.menu.createInstance();
        dk.menu.addItem(menu, "Open", function dk_menu_open() {
            dk.file.getPathObject(path, function(pObj) {
                dk.solution.open(pObj.aPath);
            });
        });

        /*
        var id = event.currentTarget.id;
        event.stopPropagation();
        event.preventDefault();
        dk.create("DKFile/DKSolutionMenu.js", function dk_create_callback() {
            dk.menu.validatePosition(byId("DKFile/DKSolutionMenu.html"));
            var file = byId(id).value;
            if (!file)
                file = byId("DKSolutionPath").value + "/";
            dk.solutionMenu.setId(id);
            dk.solutionMenu.setFile(file);
        });
        */
        return;
    }

    if (event.currentTarget.id === "DKSolutionUp") {
        var up = byId("DKSolutionPath").value + "/../";
        //console.log(up+"\n");
        dk.solution.openFolder(up);
    }

    if (event.type === "dblclick") {
        //console.log(DK_GetId(event)+"\n");
        //console.log(DK_GetValue(DK_GetId(event))+"\n");
        if (event.currentTarget.id.includes("DKSolutionFolder")) {
            //console.log("DKSolutionFolder\n");
            console.log("dk.solution.openFolder(byId(event.currentTarget.id).value = " + dk.solution.openFolder(byId(event.currentTarget.id).value));
            const value = byId(event.currentTarget.id).getAttribute('value');
            dk.solution.openFolder(value);
            return;
        }
        if (!byId(event.currentTarget.id).value)
            return error("value seems to be unsert")
        dk.solution.openFile(value);
        //byId(event.currentTarget.id).value);
        //DK_ClearSelection();
        return;
    }

    if (event.currentTarget.id === "DKSolutionPath") {
        if (DK_GetValue(event) === 13) {
            //enter
            dk.solution.OpenFolder(byId("DKSolutionPath").value);
        }
    }
}

dk.solution.select = function dk_solution_select(id) {
    var arry = byId("DKSolutionMenu").childNodes;
    for (var i = 0; i < arry.length - 1; i++) {
        if (!arry[i])
            console.error("dk_solution_Select(id): arry[" + i + "] invalid\n");
    }
    arry[i].style.backgroundColor = "rgb(255,255,255)";
    arry[i].style.color = "rgb(0,0,0)";

    if (id.indexOf("DKSolutionFolder") > -1 || id.indexOf("DKSolutionFile") > -1) {
        byId(id).style.backgroundColor = "rgb(123,157,212)";
        byId(id).style.color = "rgb(255,255,255)";
    }
}

dk.solution.open = function dk_solution_openFile(path) {
    console.debug("dk.solution.open(" + path + ")");
    dk.file.isDir(path, function(dir) {
        if (dir)
            dk.solution.openFolder(path);
        else
            console.log("Run " + path + " on OS");
    });
}

dk.solution.openHere = function dk_solution_openHere(path) {
    dk.file.isDir(path, function(dir) {
        if (dir)
            dk.solution.openFolder(path);
        else
            dk.fileassociation.open(path);
    });
}

dk.solution.openFolder = function dk_solution_openFolder(path) {
    if (!dk.solution.updatePath(path))
        return false;
    return true;
}

dk.solution.updatePath = function dk_solution_updatePath(_path) {
    !_path && (_path = "");
    //reload events
    byId("DKSolutionUp").onclick = dk.solution.onevent;
    byId("DKSolutionMenu").onclick = dk.solution.onevent;
    byId("DKSolutionMenu").oncontextmenu = dk.solution.onevent;
    byId("DKSolutionPath").onkeypress = dk.solution.onevent;

    console.debug("dk.solution.updatPath(" + _path + ")");
    dk.file.getPathObject(_path, function dk_file_getPathObject(path) {

        byId("DKSolutionPath").value = path.aPath;
        byId("DKSolutionMenu").innerHTML = "";
        dk.file.directoryContents(path.aPath, function dk_file_directoryContents_callback(results) {
            if (!results)
                return error("results invalid");
            const items = results.split(",");
            for (let d = 0; d < items.length; d++) {
                dk.file.isDir(path.aPath + items[d], function dk_file_isDir_callback(dir) {
                    if (dir) {
                        //Folders
                        var folder = dk.gui.createElement(byId("DKSolutionMenu"), "div", "DKSolutionFolder");
                        folder.setAttribute("class", "option");
                        const folderpath = path.aPath + items[d] + "/";
                        folder.setAttribute("path", folderpath);
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
                        var file = dk.gui.createElement(byId("DKSolutionMenu"), "div", "DKSolutionFile");
                        file.setAttribute("class", "option");
                        const filepath = path.aPath + items[f];
                        file.setAttribute("path", filepath);
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
