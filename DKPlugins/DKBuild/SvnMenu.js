function SvnMenu_init() {
    dk.create("DKBuild/SvnMenu.html");
    byId("SvnMenu.html").style.top = CPP_DKWindow_GetMouseY() + "px";
    byId("SvnMenu.html").style.left = CPP_DKWindow_GetMouseX() + "px";
    document.addEventListener("mousedown", SvnMenu_onevent);
    byId("Svn Update").addEventListener("click", SvnMenu_onevent);
    byId("Svn Commit").addEventListener("click", SvnMenu_onevent);
}

function SvnMenu_end() {
    document.addEventListener("mousedown", SvnMenu_onevent);
    byId("Svn Update").addEventListener("click", SvnMenu_onevent);
    byId("Svn Commit").addEventListener("click", SvnMenu_onevent);
    dk.close("DKBuild/SvnMenu.html");
}

function SvnMenu_onevent(event) {
    console.debug("SvnMenu_onevent(" + event.currentTarget.id + "," + event.type + "," + event.value + ")\n");
    if (event.currentTarget.id === "Svn Update") {
        DKThread_DKQueue("SvnUpdate", "DKBuild_SvnUpdate();");
    }
    if (event.currentTarget.id === "Svn Commit") {
        DKThread_DKQueue("SvnCommit", "DKBuild_SvnCommit();");
    }

    if (event.currentTarget === document) {
        if (byId("SvnMenu.html").contains(document.elementFromPoint(window.mouseX, window.mouseY))) {
            return;
        }
    }
    dk.close("DKBuild/SvnMenu.js");
}
