"use strict";

dk.fileassociation = new DKPlugin("dk_fileassociation");

dk.fileassociation.edit = function dk_fileAssociation_edit(file) {
    dk.fileassociation.opentext(file);
    return true;
}

dk.fileassociation.open = function dk_fileAssociation_open(file) {
    if (!file)
        return error("file invalid");
    if (!file.includes("."))
        return error("no file extension");
    if (file.includes(".js")) {
        dk.fileassociation.openjs(file);
        return true;
    }
    if (file.includes(".html")) {
        dk.fileassociation.openhtml(file);
        return true;
    }
    if (file.includes(".css")) {
        dk.fileassociation.opencss(file);
        return true;
    }
    if (file.includes(".png")) {
        dk.fileassociation.openimage(file);
        return true;
    }
    if (file.includes(".bmp")) {
        dk.fileassociation.openimage(file);
        return true;
    }
    if (file.includes(".gif")) {
        dk.fileassociation.openimage(file);
        return true;
    }
    if (file.includes(".jpeg")) {
        dk.fileassociation.openimage(file);
        return true;
    }
    if (file.includes(".jpg")) {
        dk.fileassociation.openimage(file);
        return true;
    }
    if (file.includes(".tiff")) {
        dk.fileassociation.openimage(file);
        return true;
    }
    if (file.includes(".tif")) {
        dk.fileassociation.openimage(file);
        return true;
    }
    if (file.includes(".osgt")) {
        dk.fileassociation.openmodel(file);
        return true;
    }
    if (file.includes(".osg")) {
        dk.fileassociation.openmodel(file);
        return true;
    }
    if (file.includes(".wav")) {
        dk.fileassociation.openaudio(file);
        return true;
    }
    if (file.includes(".mp3")) {
        dk.fileassociation.openaudio(file);
        return true;
    }
    if (file.includes(".avi")) {
        dk.fileassociation.openvideo(file);
        return true;
    }
    if (file.includes(".mkv")) {
        dk.fileassociation.openvideo(file);
        return true;
    }
    if (file.includes(".mp4")) {
        dk.fileassociation.openvideo(file);
        return true;
    }
    dk.fileassociation.opentext(file);
    return true;
}

dk.fileassociation.openhtml = function dk_fileassociation_openHtml(path) {
    //path = path.replace(absolutepath, "");

    var id = path.replace(CPP_DKAssets_LocalAssets(), "");
    //var id = DKFile_GetFilename(path);
    if (dk.create(id)) {
        //dk.fileassociation.AddDragHandles(id);
        dk.frame.create(id);
        //dk.fileassociation.SelectElement(id);
    }
    //FIXME
    return error("FIXME");

    //TODO - to use files outside of the data directory, we need to append the datapath
    //var the_path = path.replace(id, "");
    //console.log("DK_AppendDataPath("+the_path+")");
    //AppendDataPath(the_path);

    dk.file.fileToString(path, function dk_file_fileToString_callback(str) {
        filedata = str;

        if (!filedata)
            return error("filedata invalid");
        //if(!HtmlToRml(filedata)){ return false; }

        //Parse the sting into an element
        var temp = dk.createElement(document.body, "temp", "temporary");
        temp.innerHTML = filedata;

        //if(DK_GetNumChildren(temp) === 0){
        //	return error("Error loading path: "+id+": could not create node");
        //}

        //Make sure there is only 1 child
        //if(DK_GetNumChildren(temp) > 1){
        //	return error("Error loading path: "+id+" has more than one root node");
        //}

        console.log("temp: " + temp.id);
        var element = temp.firstChild;
        //console.log("element = "+element);
        //DKElement* element = temp->GetFirstChild();
        //byId(element).id = id;

        document.body.appendChild(element);
        temp.parentNode.removeChild(temp);
        //Show(id);
        //dk.fileassociation.AddDragHandles(id);
        //dk.fileassociation.SelectElement(id);
    });
}

dk.fileassociation.openjs = function dk_fileassociation_openjs(path) {
    //path = path.replace(absolutepath, "");

    var id = path.replace(DKAssets_LocalAssets(), "");
    dk.create(id, function dk_create_callback(rval) {
        if (!rval)
            return error("rval invalid");
        id = id.replace(".js", ".html");
        dk.frame.create(id);
    });
}

dk.fileassociation.opencss = function dk_fileAssociation_opencss(path) {
    var id = path.replace(CPP_DKAssets_LocalAssets(), "");
    dk.create(id, function dk_create_callback(rval) {
        if (!rval)
            return error("rval invalid");
    });
}

dk.fileassociation.opentext = function dk_fileassociation_opentext(path) {
    dk.create("DKNotepad/DKNotepad.js", function dk_create_callback() {
        dk.notepad.createOpen(path);
    });
}

dk.fileassociation.openimage = function dk_fileassociation_openimage(path) {
    dk.create("DKPaint/DKPaint.js", function dk_create_callback() {
        dk.paint.createOpen(path);
    });
}

dk.fileassociation.openmodel = function dk_fileAssociation_openmodel(path) {
    dk.create("DKOSGManipulator,,DKOSGWindow", function dk_create_callback() {});
    dk.create("DKOSGModel,,DKWindow," + path, function dk_create_callback() {});
}

dk.fileassociation.openaudio = function dkfileassociation_openaudio(path) {
    //var file = DKFile_GetFilename(path);
    dk.create("DKAudio", function dk_create_callback() {
        dk.audio.playSound(path);
    });

    //dk.create("DKOSGAudio,"+file+",DKOSGWindow,"+path);
    //DKOSGAudio_Play("DKOSGAudio,"+file);

    //dk.create("DKSDLAudio,"+file+",DKSDLWindow,"+path);
    //DKSDLAudio_Play("DKSDLAudio,"+file);
}

dk.fileassociation.openvideo = function dkfileassociation_openvideo(path) {
    //FIXME
    dk.video.play(path);
}
