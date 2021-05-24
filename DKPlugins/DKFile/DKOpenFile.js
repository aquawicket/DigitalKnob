//"use_strict";

dk.openfile = new DKPlugin("dk_openfile");

//var event_type;
//var event_id;
//var event_data1;
//var event_data2;
//var aPath;
//var rPath;

dk.openfile.init = function dk_openfile_init(callback) {
    dk.create("DKFile/DKOpenFile.css");
    dk.create("DKFile/DKOpenFile.html");

    dk.openfile.box = html.querySelector("[dk_openfile='box']");
    dk.openfile.up = html.querySelector("[dk_openfile='up']");
    dk.openfile.pathdiv = html.querySelector("[dk_openfile='pathdiv']");
    dk.openfile.path = html.querySelector("[dk_openfile='path']");
    dk.openfile.menu = html.querySelector("[dk_openfile='menu']");
    dk.openfile.menu2 = html.querySelector("[dk_openfile='menu2']");
    dk.openfile.cancel = html.querySelector("[dk_openfile='cancel']");
    dk.openfile.ok = html.querySelector("[dk_openfile='ok']");

    dk.openfile.up.onclick = function() {
    }
    dk.openfile.path.onchange = function() {
    }
    dk.openfile.cancel = function() {
    }
    dk.openfile.ok = function() {
    }

    //byId("DKFile/DKOpenFile.html").addEventListener("GetFile", DKOpenFile_onevent);
    //byId("DKFile/DKOpenFile.html").addEventListener("GetFile", DKOpenFile_onevent);
    //byId("DKOpenFileCancel").addEventListener("click", DKOpenFile_onevent);
    //byId("DKOpenFileOK").addEventListener("click", DKOpenFile_onevent);
    //byId("DKOpenFileUp").addEventListener("click", DKOpenFile_onevent);
    //byId("DKOpenFilePath").addEventListener("change", DKOpenFile_onevent);

    //TODO
    //var drives = CPP_DKFile_GetDrives();
    //console.log(drives);
    callback(true);
}

dk.openfile.end = function dk_openfile_end() {
    //byId("DKFile/DKOpenFile.html").removeEventListener("GetFile", DKOpenFile_onevent);
    //byId("DKFile/DKOpenFile.html").removeEventListener("GetFile", DKOpenFile_onevent);
    dk.close("DKFile/DKOpenFile.html");
    dk.close("DKFile/DKOpenFile.css");
}

dk.openfile.onevent = function dk_openfile_onevent(event) {

    if (event.currentTarget.id.includes("DKOpenFileDrive"))
        DKOpenFile_OpenFolder(DK_GetValue(event));
    if (event.currentTarget.id.includes("DKOpenFileFolder"))
        DKOpenFile_OpenFolder(DK_GetValue(event));
    if (event.currentTarget.id && event.currentTarget.id.includes("DKOpenFileFile"))
        DKOpenFile_OpenFile(DK_GetValue(event));
    if (event.currentTarget.id === "DKOpenFileUp") {
        var up = byId("DKOpenFilePath").value + "/..";
        DKOpenFile_OpenFolder(up);
    }
    if (event.currentTarget.id === "DKOpenFileOK") {
        if (rPath && event_data2 === "relative") {
            //console.log("DKSendEvent("+event_id+","+event_type+","+rPath+")");
            DKSendEvent(event_id, event_type, rPath);
        } else if (aPath && event_data2 === "absolute") {
            //console.log("DKSendEvent("+event_id+","+event_type+","+aPath+")");
            DKSendEvent(event_id, event_type, aPath);
        } else {//console.error("DKOpenFile::ProcessEvent(): return_path_type incorrect");
        }
        DKFrame_Close("DKFile/DKOpenFile.html");
        return;
    }

    if (event.currentTarget.id === "DKOpenFileCancel") {
        DKFrame_Close("DKFile/DKOpenFile.html");
        return;
    }

    if (event.currentTarget.id === "GetFile") {
        console.log("GetFile was called");
        var params = event.value.split(",");
        event_id = params[0];
        event_type = params[1];
        event_data1 = params[2];
        event_data2 = params[3];
        //console.log("event_type:"+event_type);
        //console.log("event_id:"+event_id);
        //console.log("event_data1:"+event_data1);
        //console.log("event_data2:"+event_data2);

        DKOpenFile_UpdatePath(event_data1);
    }

    if (event.currentTarget.id === "DKOpenFilePath") {
        console.log("DKOpenFilePath");
        //var path = byId("DKOpenFilePath").value;
        //DKOpenFile_UpdatePath(path);
    }
}

dk.openfile.getfile = function dk_openfile_getfile(path, callback) {//TODO
//DKOpenFile_UpdatePath(path);
//DKOpenFile_callback = callback;
}

dk.openfile.openfolder = function dk_openfile_openfolder(path) {
    if (dk.openfile.updatepath(path))
        return true;
    return false;
}

dk.openfile.openfile = function dk_openfile_openfile(path) {
    if (DK_GetOS() === "Android")
        aPath = path;
    else
        aPath = CPP_DKFile_GetAbsolutePath(path);
    //console.log("aPath:"+aPath);
    var assets = CPP_DKAssets_LocalAssets();
    //console.log("assets:"+assets);
    rPath = CPP_DKFile_GetRelativePath(aPath, assets);
    //console.log("rPath:"+rPath);
    byId("DKOpenFilePath").value = aPath;
}

dk.openfile.updatepath = function dk_openfile_updatepath(path) {
    console.debug("dk.openfile.updatepath(" + path + ")");
    if (dk.getOS() === "Android")
        aPath = path;
    else
        aPath = dk.file.getAbsolutePath(path);
    rPath = dk.file.getRelativePath(aPath, path);
    var temp = dk.file.directoryContents(aPath);
    var files = temp.split(",");
    dk.openfile.menu1.innerHTML = "";
    dk.openfile.menu2.innerHTML = "";
    for (let n = 0; n < files.length; n++) {
        if (dk.file.isDir(aPath + "/" + files[n])) {
            //Folders
            var folder = DK_CreateElement(dk.openfile.menu1, "option", "DKOpenFileFolder");
            var value = aPath + "/" + files[n];
            folder.value = value;
            folder.style.whiteSpace = "nowrap";
            folder.onclick = function() {
                dk.openfile.highlight(instance, event);
            }
            folder.ondblclick = function() {
                dk.openfile.dbl(instance, event);
            }
            folder.style.paddingLeft = "17px";
            folder.innerHTML = files[n];
            folder.style.backgroundImage = "url(\"DKFile/folder.png\")";
            folder.style.backgroundRepeat = "no-repeat";
        }
    }

    for (var n = 0; n < files.length; n++) {
        if (!dk.file.isDir(aPath + "/" + files[n])) {
            //Files
            var file = DK_CreateElement(dk.openfile.menu2, "option", "DKOpenFileFile");
            var value = aPath + "/" + files[n];
            file.value = value;
            file.style.whiteSpace = "nowrap";
            file.style.paddingLeft = "17px";
            file.style.backgroundRepeat = "no-repeat";
            file.innerHTML = files[n];
            file.onclick = function() {
                dk.openfile.highlight(instance, event);
            }
            file.ondblclick = function() {
                dk.openfile.dblclick(instance, event);
            }
            var extension = CPP_DKFile_GetExtention(files[n]);
            if ((extension === "png") || (extension === "jpeg") || (extension === "jpg") || (extension === "bmp") || (extension === "tiff") || (extension === "tif") || (extension === "gif") || (extension === "tga") || (extension === "ico"))
                file.style.backgroundImage = "url(\"DKFile/picture.png\")";
            else if ((extension === "osg") || (extension === "osgb") || (extension === "osgt") || (extension === "3dm") || (extension === "3ds") || (extension === "ac") || (extension === "ascii") || (extension === "blend") || (extension === "bvh") || (extension === "c4d") || (extension === "dae") || (extension === "dds") || (extension === "dgn") || (extension === "dwg") || (extension === "dxf") || (extension === "fbx") || (extension === "lwo") || (extension === "lws") || (extension === "ma") || (extension === "max") || (extension === "mb") || (extension === "mesh") || (extension === "mtl") || (extension === "obj") || (extension === "pov") || (extension === "skp") || (extension === "stl") || (extension === "ztl"))
                file.style.backgroundImage = "url(\"DKFile/cube.png\")";
            else if ((extension === "html") || (extension === "htm"))
                file.style.backgroundImage = "url(\"DKFile/html.png\")";
            else
                file.style.backgroundImage = "url(\"DKFile/file.png\")";
        }
    }

    dk.openfile.path.value = aPath;
    return true;
}
