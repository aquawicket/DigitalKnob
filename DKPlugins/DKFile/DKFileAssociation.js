"use strict";

dk.fileassociation = DKPlugin(DKFile)
function DKFileAssociation() {}

DKFileAssociation.prototype.edit = function DKFileAssociation_edit(file) {
    dk.fileassociation.opentext(file);
    return true;
}

DKFileAssociation.prototype.open = function DKFileAssociation_open(instance, file) {
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

DKFileAssociation.prototype.openhtml = function DKFileAssociation_openHtml(path) {
    if (!dk.hasCPP())
        path = path.replace(dk.file.onlineAssets, "");
    else
        path = path.replace(CPP_DKAssets_LocalAssets(), "");
    dk.create(path, function(node) {
        const css = path.replace(".html", ".css");
        css && dk.create(css);
        node && dk.frame.create(node);
    });
}

DKFileAssociation.prototype.openjs = function DKFileAssociation_openjs(path) {
    if (!dk.hasCPP())
        path = path.replace(dk.file.onlineAssets, "");
    else
        path = path.replace(CPP_DKAssets_LocalAssets(), "");
    dk.create(path, function(node) {
        const html = path.replace(".js", ".html");
        dk.create(html, function() {
            dk.frame.create(html);
        });
    });
}

DKFileAssociation.prototype.opencss = function DKFileAssociation_opencss(path) {
    if (!dk.hasCPP())
        path = path.replace(dk.file.onlineAssets, "");
    else
        path = path.replace(CPP_DKAssets_LocalAssets(), "");
    dk.create(path);
}

DKFileAssociation.prototype.opentext = function DKFileAssociation_opentext(path) {
    dk.create("DKNotepad/DKNotepad.js", function dk_create_callback(val) {
        dk.notepad.createOpen(path);
    });
}

DKFileAssociation.prototype.openimage = function DKFileAssociation_openimage(path) {
    dk.create("DKPaint/DKPaint.js", function dk_create_callback() {
        dk.paint.createOpen(path);
    });
}

DKFileAssociation.prototype.openmodel = function DKFileAssociation_openmodel(path) {
    dk.create("DKOSGManipulator,,DKOSGWindow", function dk_create_callback() {});
    dk.create("DKOSGModel,,DKWindow," + path, function dk_create_callback() {});
}

DKFileAssociation.prototype.openaudio = function DKFileAssociation_openaudio(path) {
    if (!dk.hasCPP())
        path = path.replace(dk.file.onlineAssets, "");
    else
        path = path.replace(CPP_DKAssets_LocalAssets(), "");
    dk.create("DKAudio", function dk_create_callback() {
        dk.audio.playSound(path);
    });

    //dk.create("DKOSGAudio,"+file+",DKOSGWindow,"+path);
    //DKOSGAudio_Play("DKOSGAudio,"+file);

    //dk.create("DKSDLAudio,"+file+",DKSDLWindow,"+path);
    //DKSDLAudio_Play("DKSDLAudio,"+file);
}

DKFileAssociation.prototype.openvideo = function DKFileAssociation_openvideo(path) {
    if (!dk.hasCPP())
        path = path.replace(dk.file.onlineAssets, "");
    else
        path = path.replace(CPP_DKAssets_LocalAssets(), "");
    dk.video.play(path);
}
