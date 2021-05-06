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

        dk.solution.setElement(html);
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
        event.preventDefault();
        const menu = dk.menu.createInstance();
        dk.menu.addItem(menu, "Open", function DKMenu_Clear() {
            dk.console.clear();
        });

        
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
            console.log("dk.solution.openFolder(byId(event.currentTarget.id).value = "+dk.solution.openFolder(byId(event.currentTarget.id).value));
            const value = byId(event.currentTarget.id).getAttribute('value');
            dk.solution.openFolder(value);
            return;
        }
        if(!byId(event.currentTarget.id).value)
            return error("value seems to be unsert")
        dk.solution.openFile(value);//byId(event.currentTarget.id).value);
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
dk.solution.openFolder = function dk_solution_openFolder(path) {
    if (!dk.solution.updatePath(path))
        return false;
    return true;
}

dk.solution.openFile = function dk_solution_openFile(path) {
    var aPath = path;
    if (dk.getOS() !== "Android") {
        dk.file.getAbsolutePath(path, function(results) {
            aPath = results;
        });
    }
    if (!duktape)
        return;
    if (!CPP_DK_Run(aPath, ""))
        return error("CPP_DK_Run() failed");
    return true;
}

dk.solution.openHere = function dk_solution_openHere(path) {
    var aPath = path;
 
    if (dk.getOS !== "Android") {
        aPath = CPP_DKFile_GetAbsolutePath(path);
        if (typeof (absolutepath) === 'string')
            aPath = aPath.replace(absolutepath, "");
    }
    //console.log("aPath:"+aPath+"\n");
    if (CPP_DKFile_IsDirectory(aPath)) {
        //Folder
        if (!dk.solution.updatePath(aPath))
            return false;
        return true;
    } else {
        //File
        if (!DKFileAssociation_Open(aPath))
            return false;
        return true;
    }

    return error("dk.solution.openHere() failed");
}

dk.solution.updatePath = function dk_solution_updatePath(path) {
    //reload events
    byId("DKSolutionUp").onclick = dk.solution.onevent;
    byId("DKSolutionMenu").onclick = dk.solution.onevent;
    byId("DKSolutionMenu").oncontextmenu = dk.solution.onevent;
    byId("DKSolutionPath").onkeypress = dk.solution.onevent;

    if (!path)
        path = "";
    var aPath = path;
    /*
	var aPath;
	if(DK_GetOS() !== "Android"){
		aPath = DKFile_GetAbsolutePath(path);
	}
	*/

    //console.log("aPath:"+aPath+"\n");
    //var rPath = CPP_DKFile_GetRelativePath(aPath, path);
    //console.log("rPath:"+rPath+"\n");

    dk.file.directoryContents(aPath, function dk_file_directoryContents_callback(results) {
        if (!results)
            return false;
        const files = results.split(",");
        byId("DKSolutionMenu").innerHTML = "";
        //Clear it
        for (let d = 0; d < files.length; d++) {
            dk.file.isDir(aPath + "/" + files[d], function(result) {

                if (result) {
                    //Folders
                    var element2 = dk.gui.createElement(byId("DKSolutionMenu"), "div", "DKSolutionFolder");
                    element2.setAttribute("class", "option");
                    var value = aPath + "/" + files[d] + "/";
                    element2.setAttribute("value", value);
                    element2.style.whiteSpace = "nowrap";
                    element2.addEventListener("click", dk.solution.onevent);
                    element2.style.paddingLeft = "17px";
                    element2.innerHTML = files[d];
                    element2.style.backgroundImage = "url(\"DKFile/folder.png\")";
                    element2.style.backgroundRepeat = "no-repeat";
                    element2.cursor = "pointer";
                    element2.addEventListener("click", dk.solution.onevent);
                    element2.addEventListener("dblclick", dk.solution.onevent);
                    element2.addEventListener("contextmenu", dk.solution.onevent);
                    //element2.onclick = dk.solution.onevent;
                    //element2.ondblclick = dk.solution.onevent;
                    //element2.oncontextmenu = dk.solution.onevent;
                }

            });
        }
        for (let f = 0; f < files.length; f++) {
            dk.file.isDir(aPath + "/" + files[f], function(result) {

                if (!result) {
                    //Files
                    var element3 = dk.gui.createElement(byId("DKSolutionMenu"), "div", "DKSolutionFile");
                    element3.setAttribute("class", "option");
                    var value = aPath + "/" + files[f];
                    element3.setAttribute("value", value);
                    element3.style.whiteSpace = "nowrap";
                    element3.style.paddingLeft = "17px";
                    element3.style.backgroundRepeat = "no-repeat";
                    element3.cursor = "pointer";
                    element3.innerHTML = files[f];
                    element3.addEventListener("click", dk.solution.onevent);
                    element3.addEventListener("dblclick", dk.solution.onevent);
                    element3.addEventListener("contextmenu", dk.solution.onevent);
                    //element3.onclick = dk.solution.onevent;
                    //element3.ondblclick = dk.solution.onevent;
                    //element3.oncontextmenu = dk.solution.onevent;

                    var extension = dk.file.getExtention(files[f]);
                    if ((extension === "png") || (extension === "jpeg") || (extension === "jpg") || (extension === "bmp") || (extension === "tiff") || (extension === "tif") || (extension === "gif") || (extension === "tga") || (extension === "ico")) {
                        element3.style.backgroundImage = "url(\"DKFile/picture.png\")";
                    } else if ((extension === "osg") || (extension === "osgb") || (extension === "osgt") || (extension === "3dm") || (extension === "3ds") || (extension === "ac") || (extension === "ascii") || (extension === "blend") || (extension === "bvh") || (extension === "c4d") || (extension === "dae") || (extension === "dds") || (extension === "dgn") || (extension === "dwg") || (extension === "dxf") || (extension === "fbx") || (extension === "lwo") || (extension === "lws") || (extension === "ma") || (extension === "max") || (extension === "mb") || (extension === "mesh") || (extension === "mtl") || (extension === "obj") || (extension === "pov") || (extension === "skp") || (extension === "stl") || (extension === "ztl")) {
                        element3.style.backgroundImage = "url(\"DKFile/cube.png\")";
                    } else if ((extension === "js")) {
                        element3.style.backgroundImage = "url(\"DKFile/js.png\")";
                    } else if ((extension === "sln")) {
                        element3.style.backgroundImage = "url(\"DKFile/sln.png\")";
                    } else if ((extension === "html") || (extension === "htm")) {
                        element3.style.backgroundImage = "url(\"DKFile/html.png\")";
                    } else {
                        element3.style.backgroundImage = "url(\"DKFile/file.png\")";
                    }
                }

            });
        }

        byId("DKSolutionPath").value = aPath;
        return true;
    });
}
