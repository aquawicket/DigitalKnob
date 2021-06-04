function DKPaintFile_init() {
    dk.create("DKPaint/DKPaintFile.html,DKPaint/DKPaint.html");
    document.addEventListener("mousedown", DKPaintFile_onevent);
    byId("DKPaintFile_Open").addEventListener("click", DKPaintFile_onevent);
    byId("DKPaintFile_Save").addEventListener("click", DKPaintFile_onevent);
    byId("DKPaintFile_Save As").addEventListener("click", DKPaintFile_onevent);
    byId("DKPaintFile_Exit").addEventListener("click", DKPaintFile_onevent);
}

function DKPaintFile_end() {
    document.removeEventListener("mousedown", DKPaintFile_onevent);
    byId("DKPaintFile_Open").removeEventListener("click", DKPaintFile_onevent);
    byId("DKPaintFile_Save").removeEventListener("click", DKPaintFile_onevent);
    byId("DKPaintFile_Save As").removeEventListener("click", DKPaintFile_onevent);
    byId("DKPaintFile_Exit").removeEventListener("click", DKPaintFile_onevent);
    dk.close("DKPaint/DKPaintFile.html");
}

function DKPaintFile_OnEvent(event) {
    if (event.currentTarget.id === "DKPaintFile_Open") {
        DKPaintFile_Open();
    }
    if (event.currentTarget.id === "DKPaintFile_Save") {
        DKPaintFile_Save();
    }
    if (event.currentTarget.id === "DKPaintFile_SaveAs") {
        DKPaintFile_SaveAs();
    }
    if (event.currentTarget.id === "DKPaintFile_Exit") {
        dk.close("DKPaint/DKPaintFile.js");
        DKFrame_Close("DKPaint/DKPaint.html");
    }

    if (event.currentTarget === document) {
        if (byId("DKPaint/DKPaintFile.html").contains(document.elementFromPoint(window.mouseX, window.mouseY))) {
            return;
        }
    }
    dk.close("DKPaint/DKPaintFile.js");
}

function DKPaintFile_Open() {
    dk.create("DKFile/DKOpenFile.js", function() {
        DKFrame_Html("DKFile/DKOpenFile.html");
        DKSendEvent("DKFile/DKOpenFile.html", "GetFile", "DKPaint/DKPaint.html,OpenFile,/,absolute");
        // To -> DKOpenFile
    });
}

function DKPaintFile_Save() {
}

function DKPaintFile_SaveAs() {
}
