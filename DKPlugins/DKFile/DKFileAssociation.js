"use strict";

dk.fileassociation = new DKWidget("dk.fileassociation");

dk.fileassociation.init = function dk_fileassociation_init()() {}

dk.fileassociation.end = function dk_fileassociation_end() {}

dk.fileassociation.onevent = function dk_fileassociation_onevent(event) {
    console.debug("dk.fileassociation.onevent(" + event.currentTarget.id + "," + event.type + "," + event.value + ")");
}

dk.fileassociation.open = function dk_fileAssociation_open(file) {
    if (file.indexOf(".") === -1) {
        return false;
    }
    if (file.indexOf(".js") !== -1) {
        dk.fileassociation.openjs(file);
        return true;
    }
    if (file.indexOf(".html") !== -1) {
        dk.fileassociation.openhtml(file);
        return true;
    }
    if (file.indexOf(".css") !== -1) {
        dk.fileassociation.opencss(file);
        return true;
    }
    if (file.indexOf(".png") !== -1) {
        dk.fileassociation.openimage(file);
        return true;
    }
    if (file.indexOf(".bmp") !== -1) {
        dk.fileassociation.openimage(file);
        return true;
    }
    if (file.indexOf(".gif") !== -1) {
        dk.fileassociation.openimage(file);
        return true;
    }
    if (file.indexOf(".jpeg") !== -1) {
        dk.fileassociation.openimage(file);
        return true;
    }
    if (file.indexOf(".jpg") !== -1) {
        dk.fileassociation.openimage(file);
        return true;
    }
    if (file.indexOf(".tiff") !== -1) {
        dk.fileassociation.openimage(file);
        return true;
    }
    if (file.indexOf(".tif") !== -1) {
        dk.fileassociation.openimage(file);
        return true;
    }
    if (file.indexOf(".osgt") !== -1) {
        dk.fileassociation.openmodel(file);
        return true;
    }
    if (file.indexOf(".osg") !== -1) {
        dk.fileassociation.openmodel(file);
        return true;
    }
    if (file.indexOf(".wav") !== -1) {
        dk.fileassociation.openaudio(file);
        return true;
    }
    if (file.indexOf(".mp3") !== -1) {
        dk.fileassociation.openaudio(file);
        return true;
    }
    if (file.indexOf(".avi") !== -1) {
        dk.fileassociation.openvideo(file);
        return true;
    }
    if (file.indexOf(".mkv") !== -1) {
        dk.fileassociation.openvideo(file);
        return true;
    }
    if (file.indexOf(".mp4") !== -1) {
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

    dk.file.fileToString(path, function(str){
        filedata = str;
    });
    if (!filedata)
        return false;
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
}

dk.fileassociation.openjs = function dk_fileassociation_openjs(path) {
    //path = path.replace(absolutepath, "");

    var id = path.replace(DKAssets_LocalAssets(), "");
    dk.create(id, function(rval) {
        if (!rval) {
            return;
        }
        id = id.replace(".js", ".html");
        dk.frame.create(id);
    });
}

dk.fileassociation.opencss = function dk_fileAssociation_opencss(path) {
    var id = path.replace(CPP_DKAssets_LocalAssets(), "");
    dk.create(id, function(rval) {
        if (!rval)
            return;
    });
}

dk.fileassociation.opentext = function dk_fileassociation_opentext(path) {
    //DK_Toggle("DKNotepad.html");
    dk.create("DKNotepad/DKNotepad.js", function() {
        dk.frame.create("DKNotepad/DKNotepad.html");
        dk.notepad.open(path);
    });
}

dk.fileassociation.openimage = function dk_fileassociation_openimage(path) {
    dk.create("DKPaint/DKPaint.js", function() {
        dk.frame.create(byId("DKPaint/DKPaint.html"));
        dk.paint.open(path);
    });
}

dk.fileassociation.openmodel = function dk_fileAssociation_openmodel(path) {
    dk.create("DKOSGManipulator,,DKOSGWindow", function() {});
    dk.create("DKOSGModel,,DKWindow," + path, function() {});
}

dk.fileassociation.openaudio = function dkfileassociation_openaudio(path) {
    //var file = DKFile_GetFilename(path);
    dk.create("DKAudio", function() {
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
