dk.solution = new Object;

dk.solution.init = function dk_solution_init() {
    dk.create("DKFile/DKSolution.css");
    dk.create("DKFile/DKSolution.html", function(){
       byId("DKSolutionUp").addEventListener("click", dk.solution.onevent);
        byId("DKSolutionMenu").addEventListener("click", dk.solution.onevent);
        byId("DKSolutionMenu").addEventListener("contextmenu", dk.solution.onevent);
        byId("DKSolutionPath").addEventListener("keypress", dk.solution.onevent); 
        //dk.solution.openFolder(byId("DKSolutionPath").value);
    });
    dk.create("DKFile/DKFileAssociation.js");
}

dk.solution.end = function dk_solution_end() {
    byId("DKSolutionUp").removeEventListener("click", dk.solution.onevent);
    byId("DKSolutionMenu").removeEventListener("click", dk.solution.onevent);
    byId("DKSolutionMenu").removeEventListener("contextmenu", dk.solution.onevent);
    byId("DKSolutionPath").removeEventListener("keypress", dk.solution.onevent);
    DK_Close("DKFile/DKSolution.html");
    DK_Close("DKFile/DKSolution.css");
}

dk.solution.onevent = function dk_solution_onevent(event) {
    console.debug("dk.solution.onevent(" + event.currentTarget.id + "," + event.type + "," + event.value + ")");
    dk.solution.select(event.currentTarget.id);

    if (event.currentTarget.id === "click") {
        DK_StopPropagation(event);
    }

    if (event.type === "contextmenu") {

        var id = event.currentTarget.id;
        event.stopPropagation();
        event.preventDefault();
        dk.create("DKFile/DKSolutionMenu.js", function() {
            DKMenu_ValidatePosition("DKFile/DKSolutionMenu.html");
            var file = byId(id).value;
            if (!file) {
                file = byId("DKSolutionPath").value + "/";
            }
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
            dk.solution.openFolder(byId(event.currentTarget.id).value);
            return;
        }

        dk.solution.openFile(byId(event.currentTarget.id).value);
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
    var elements = dk.getElements(byId("DKSolutionMenu"));
    var arry = elements.split(",");
    for (var i = 0; i < arry.length - 1; i++) {
        if (!arry[i]) {
            console.error("dk_solution_Select(id): arry[" + i + "] invalid\n");
        }
        byId(arry[i]).style.backgroundColor = "rgb(255,255,255)";
        byId(arry[i]).style.color = "rgb(0,0,0)";
    }
    if (id.indexOf("DKSolutionFolder") > -1 || id.indexOf("DKSolutionFile") > -1) {
        byId(id).style.backgroundColor = "rgb(123,157,212)";
        byId(id).style.color = "rgb(255,255,255)";
    }
}

dk.solution.openFolder = function dk_solution_openFolder(path) {
    if (dk.solution.updatePath(path)) {
        return true;
    }
    return false;
}

dk.solution.openFile = function dk_solution_openFile(path) {
    var aPath = path;
    if (DK_GetOS() !== "Android") {
        aPath = DKFile_GetAbsolutePath(path);
    }
    if (!CPP_DKDuktape_Run(aPath, ""))
        return error("CPP_DKDuktape_Run() failed");
    return true;
}

dk.solution.openHere = function dk_solution_openHere(path) {
    var aPath = path;
    if (DK_GetOS() !== "Android") {
        aPath = CPP_DKFile_GetAbsolutePath(path);
        if (typeof (absolutepath) === 'string') {
            aPath = aPath.replace(absolutepath, "");
        }
    }
    //console.log("aPath:"+aPath+"\n");
    if (CPP_DKFile_IsDirectory(aPath)) {
        //Folder
        if (!dk.solution.updatePath(aPath)) {
            return false;
        }
        return true;
    } else {
        //File
        if (!DKFileAssociation_Open(aPath)) {
            return false;
        }
        return true;
    }

    return error("dk.solution.openHere() failed");
}


dk.solution.updatePath = function dk_solution_updatePath(path) {
    //reload events
    byId("DKSolutionUp").addEventListener("click", dk.solution.onevent);
    byId("DKSolutionMenu").addEventListener("click", dk.solution.onevent);
    byId("DKSolutionMenu").addEventListener("contextmenu", dk.solution.onevent);
    byId("DKSolutionPath").addEventListener("keypress", dk.solution.onevent);

    if (!path) {
        path = "";
    }
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

    var temp = DKFile_DirectoryContents(aPath);
    if (!temp) {
        return false;
    }
    var files = temp.split(",");

    byId("DKSolutionMenu").innerHTML = "";
    //Clear it

    for (var d = 0; d < files.length; d++) {
        if (DKFile_IsDirectory(aPath + "/" + files[d])) {
            //Folders
            var element2 = DK_CreateElement(byId("DKSolutionMenu"), "div", "DKSolutionFolder");
            element2.setAttribute("class", "option");
            var value = aPath + "/" + files[d] + "/";
            element2.setAttribute("value", value);
            element2.style.whiteSpace = "nowrap";
            element2.addEventListener("click", dk.solution.onevent);
            element2.style.paddingLeft = "17px";
            element2.innerHTML = files[d];
            element2.style.backgroundImage = "url(\"DKFile/folder.png\")";
            element2.style.backgroundRepeat = "no-repeat";
            element2.addEventListener("click", dk.solution.onevent);
            element2.addEventListener("dblclick", dk.solution.onevent);
            element2.addEventListener("contextmenu", dk.solution.onevent);
        }
    }

    for (var f = 0; f < files.length; f++) {
        if (!DKFile_IsDirectory(aPath + "/" + files[f])) {
            //Files
            var element3 = DK_CreateElement(byId("DKSolutionMenu"), "div", "DKSolutionFile");
            element3.setAttribute("class", "option");
            var value = aPath + "/" + files[f];
            element3.setAttribute("value", value);
            element3.style.whiteSpace = "nowrap";
            element3.style.paddingLeft = "17px";
            element3.style.backgroundRepeat = "no-repeat";
            element3.innerHTML = files[f];
            element3.addEventListener("click", dk.solution.onevent);
            element3.addEventListener("dblclick", dk.solution.onevent);
            element3.addEventListener("contextmenu", dk.solution.onevent);

            var extension = DKFile_GetExtention(files[f]);
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
    }

    byId("DKSolutionPath").value = aPath;
    return true;
}
