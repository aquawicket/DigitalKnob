function LibraryMenu_init() {
    dk.create("DKBuild/LibraryMenu.html");
    document.addEventListener("mousedown", LibraryMenu_onevent);
    byId("Build Libraries").addEventListener("click", LibraryMenu_onevent);
}

function LibraryMenu_end() {
    document.removeEventListener("mousedown", LibraryMenu_onevent);
    byId("Build Libraries").removeEventListener("click", LibraryMenu_onevent);
    dk.close("DKBuild/LibraryMenu.html");
}

function LibraryMenu_onevent(event) {
    console.debug("LibraryMenu_onevent(" + event.currentTarget.id + "," + event.type + "," + event.value + ")\n");

    if (event.currentTarget.id === "Build Libraries") {
        console.log("Clicked Build Librariesn");
    }

    if (event.currentTarget === document) {
        if (byId("DKBuild/LibraryMenu.html").contains(document.elementFromPoint(window.mouseX, window.mouseY))) {
            return;
        }
    }
    dk.close("DKBuild/LibraryMenu.js");
}
