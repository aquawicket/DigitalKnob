DKSolutionRename_id = "";
DKSolutionRename_file = "";

function DKSolutionRename_init() {
    dk.create("DKFile/DKSolutionRename.html,DKSolutionMenu");
    document.addEventListener("mousedown", DKSolutionRename_onevent);
    byId("DKSolutionRename_box").addEventListener("keydown", DKSolutionRename_onevent);
    byId("DKSolutionRename_box").focus();
}

function DKSolutionRename_end() {
    document.removeEventListener("mousedown", DKSolutionRename_onevent);
    byId("DKSolutionRename_box").removeEventListener("keydown", DKSolutionRename_onevent);
    dk.close("DKFile/DKSolutionRename.html");
}

function DKSolutionRename_OnEvent(event) {
    console.debug("DKSolutionRename_OnEvent(" + event.currentTarget.id + "," + event.type + "," + event.value + ")");
    if (event.type === "keydown") {
        if (event.code !== "Enter") {
            return;
        }
    }
    if (event.currentTarget === document) {
        if (byId("DKFile/DKSolutionRename.html").contains(document.elementFromPoint(window.mouseX, window.mouseY))) {
            return;
        }
    }
    DKSolutionRename_Rename();
    dk.close("DKFile/DKSolutionRename.js");
}

function DKSolutionRename_SetId(id) {
    DKSolutionRename_id = id;
}

function DKSolutionRename_SetFile(file) {
    DKSolutionRename_file = file;
}

function DKSolutionRename_Rename() {
    var oldhtml = byId(DKSolutionRename_id).innerHTML;
    var oldvalue = byId(DKSolutionRename_id).value;
    var newhtml = byId("DKSolutionRename_box").value;
    var newvalue = oldvalue;
    newvalue = newvalue.replace(oldhtml, newhtml);
    //console.log("oldhtml = "+oldhtml+"\n");
    //console.log("oldvalue = "+oldvalue+"\n");
    //console.log("newhtml = "+newhtml+"\n");
    //console.log("newvalue = "+newvalue+"\n");

    if (DKFile_Rename(oldvalue, newvalue, true) === false) {
        return;
    }
    byId(DKSolutionRename_id).value = newvalue;
    byId(DKSolutionRename_id).innerHTML = newhtml;
}
