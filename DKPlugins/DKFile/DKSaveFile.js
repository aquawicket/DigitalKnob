var event_type;
var event_id;
var event_data1;
var event_data2;
var aPath;
var rPath;

//var DKSaveFile_callback;

//////////////////////////
function DKSaveFile_Init() {
    dk.create("DKFile/DKSaveFile.css");
    dk.create("DKFile/DKSaveFile.html");
    byId("DKFile/DKSaveFile.html").addEventListener("SetFile", DKSaveFile_onevent);
    byId("DKSaveFileCancel").addEventListener("click", DKSaveFile_onevent);
    byId("DKSaveFileOK").addEventListener("click", DKSaveFile_onevent);
    byId("DKSaveFileUp").addEventListener("click", DKSaveFile_onevent);
    byId("DKSaveFilePath").addEventListener("input", DKSaveFile_onevent);

    aPath = "";
    rPath = "";

    //TODO
    var drives = CPP_DKFile_GetDrives();
    console.log(drives);
}

/////////////////////////
function DKSaveFile_End() {
    byId("DKFile/DKSaveFile.html").removeEventListener("SetFile", DKSaveFile_onevent);
    byId("DKSaveFileCancel").removeEventListener("click", DKSaveFile_onevent);
    byId("DKSaveFileOK").removeEventListener("click", DKSaveFile_onevent);
    byId("DKSaveFileUp").removeEventListener("click", DKSaveFile_onevent);
    byId("DKSaveFilePath").removeEventListener("input", DKSaveFile_onevent);
    dk.close("DKFile/DKSaveFile.html");
    dk.close("DKFile/DKSaveFile.css");
}

//////////////////////////////////
function DKSaveFile_OnEvent(event) {
    //console.log("DKSaveFile_OnEvent("+event+")"); 
    //console.log("DKSaveFile_OnEvent("+event.type+","+event.value+")");
    if (!event.currentTarget)
        return error("event.currentTarger invalid");

    console.log("DKSaveFile_OnEvent(" + event.currentTarget.id + "," + event.type + "," + event.value + ")");
    if (event.currentTarget.id.includes("DKSaveFileDrive")) {
        DKSaveFile_OpenFolder(DK_GetValue(event));
    }
    if (event.currentTarget.id.includes("DKSaveFileFolder")) {
        //console.log("DKSaveFileFolder");
        DKSaveFile_OpenFolder(DK_GetValue(event));
    }
    if (event.currentTarget.id.includes("DKSaveFileFile")) {
        DKSaveFile_OpenFile(DK_GetValue(event));
    }

    if (event.currentTarget.id === "DKSaveFileUp") {
        var up = byId("DKSaveFilePath").value + "/..";
        //console.log(up);
        DKSaveFile_OpenFolder(up);
    }
    if (event.currentTarget.id === "DKSaveFileOK") {
        if (rPath && event_data2 === "relative") {
            if (CPP_DKFile_IsDirectory(rPath)) {
                rPath = rPath + "/" + byId("DKSaveFileName").value;
            }
            console.log("DKSendEvent(" + event_id + "," + event_type + "," + rPath + ")");
            DKSendEvent(event_id, event_type, rPath);
        } else if (aPath && event_data2 === "absolute") {
            if (CPP_DKFile_IsDirectory(aPath)) {
                aPath = aPath + "/" + byId("DKSaveFileName").value;
            }
            //console.log("DKSendEvent("+event_id+","+event_type+","+aPath+")");
            var event = new Object();
            event.currentTarget = byId(event_id);
            event.type = event_type;
            event.value = aPath;
            event.currentTarget.dispatchEvent(event);
            //DKSendEvent(event_id, event_type, aPath);
        } else {//console.error("DKSaveFile::ProcessEvent(): return_path_type incorrect");
        }

        DKFrame_Close("DKFile/DKSaveFile.html");
        return;
    }

    if (event.currentTarget.id === "DKSaveFileCancel") {
        DKFrame_Close("DKFile/DKSaveFile.html");
        return;
    }

    if (event.type === "SetFile") {
        //console.log("event.value = "+event.value);

        //var params = DK_GetValue(event).split(",");
        var params = event.value.split(",");
        event_id = params[0];
        event_type = params[1];
        event_data1 = params[2];
        event_data2 = params[3];
        console.log("event_id:" + event_id);
        console.log("event_type:" + event_type);
        console.log("event_data1:" + event_data1);
        console.log("event_data2:" + event_data2);
        DKSaveFile_UpdatePath(event_data1);
    }

    if (event.currentTarget.id === "DKSaveFilePath") {
        console.log("DKSaveFilePath");
        //var path = byId("DKSaveFilePath").value;
        //DKSaveFile_UpdatePath(path);
    }
}

/*
//////////////////////////////////////
function DKSaveFile_GetFIle(callback)
{
	DKSaveFile_callback = callback;
}
*/

//////////////////////////////////////
function DKSaveFile_OpenFolder(path) {
    if (DKSaveFile_UpdatePath(path)) {
        return true;
    }
    return false;
}

////////////////////////////////////
function DKSaveFile_OpenFile(path) {
    if (DK_GetOS() === "Android") {
        aPath = path;
    } else {
        aPath = CPP_DKFile_GetAbsolutePath(path);
    }
    console.log("aPath:" + aPath);
    var assets = DKAssets_LocalAssets();
    //console.log("assets:"+assets);
    rPath = CPP_DKFile_GetRelativePath(aPath, assets);
    console.log("rPath:" + rPath);
    byId("DKSaveFilePath").value = aPath;
}

//////////////////////////////////////
function DKSaveFile_UpdatePath(path) {
    if (!path)
        return error("path invalid");
        
    console.log("DKSaveFile_UpdatePath(" + path + ")");
    if (DK_GetOS() === "Android") {
        aPath = path;
    } else {
        aPath = CPP_DKFile_GetAbsolutePath(path);
    }
    console.log("aPath:" + aPath);
    //var assets = DKAssets_LocalAssets();
    //console.log("assets:"+assets);
    rPath = CPP_DKFile_GetRelativePath(aPath, path);
    console.log("rPath:" + rPath);

    var temp = CPP_DKFile_DirectoryContents(aPath);
    var files = temp.split(",");

    byId("DKSaveFileMenu").innerHTML = "";
    byId("DKSaveFileMenu2").innerHTML = "";

    for (var d = 0; d < files.length; d++) {
        if (CPP_DKFile_IsDirectory(aPath + "/" + files[d])) {
            //Folders
            var element2 = DK_CreateElement(byId("DKSaveFileMenu2"), "option", "DKSaveFileFolder");
            var value = aPath + "/" + files[d];
            element2.value = value;
            element2.style.whiteSpace = "nowrap";
            element2.addEventListener("click", DKSaveFile_onevent);
            element2.style.paddingLeft = "17px";
            element2.innerHTML = files[d];
            element2.style.backgroundImage = "url(\"DKFile/folder.png\")";
            element2.style.backgroundRepeat = "no-repeat";
        }
    }

    for (var f = 0; f < files.length; f++) {
        if (!CPP_DKFile_IsDirectory(aPath + "/" + files[f])) {
            //Files
            var element3 = DK_CreateElement(byId("DKSaveFileMenu2"), "option", "DKSaveFileFile");
            var value = aPath + "/" + files[f];
            element3.value = value;
            element3.style.whiteSpace = "nowrap";
            element3.style.paddingLeft = "17px";
            element3.style.backgroundRepeat = "no-repeat";
            element3.innerHTML = files[f];
            element3.addEventListener("click", DKSaveFile_onevent);

            var extension = CPP_DKFile_GetExtention(files[f]);
            if ((extension === "png") || (extension === "jpeg") || (extension === "jpg") || (extension === "bmp") || (extension === "tiff") || (extension === "tif") || (extension === "gif") || (extension === "tga") || (extension === "ico")) {
                element3.style.backgroundImage = "url(\"DKFile/picture.png\")";
            } else if ((extension === "osg") || (extension === "osgb") || (extension === "osgt") || (extension === "3dm") || (extension === "3ds") || (extension === "ac") || (extension === "ascii") || (extension === "blend") || (extension === "bvh") || (extension === "c4d") || (extension === "dae") || (extension === "dds") || (extension === "dgn") || (extension === "dwg") || (extension === "dxf") || (extension === "fbx") || (extension === "lwo") || (extension === "lws") || (extension === "ma") || (extension === "max") || (extension === "mb") || (extension === "mesh") || (extension === "mtl") || (extension === "obj") || (extension === "pov") || (extension === "skp") || (extension === "stl") || (extension === "ztl")) {
                element3.style.backgroundImage = "url(\"DKFile/cube.png\")";
            } else if ((extension === "html") || (extension === "htm")) {
                element3.style.backgroundImage = "url(\"DKFile/html.png\")";
            } else {
                element3.style.backgroundImage = "url(\"DKFile/file.png\")";
            }
        }
    }

    byId("DKSaveFilePath").value = aPath;
    return true;
}
