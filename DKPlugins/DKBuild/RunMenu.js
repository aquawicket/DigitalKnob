function RunMenu_init() {
    dk.create("DKBuild/RunMenu.html");
    document.addEventListener("mousedown", RunMenu_onevent);
    byId("Build App").addEventListener("click", RunMenu_onevent);
    byId("Rebuild App").addEventListener("click", RunMenu_onevent);
    byId("Rebuild All").addEventListener("click", RunMenu_onevent);
    byId("Copy Assets").addEventListener("click", RunMenu_onevent);
    byId("Run App").addEventListener("click", RunMenu_onevent);
    byId("Generate Docs").addEventListener("click", RunMenu_onevent);
    byId("Export to Android Studio").addEventListener("click", RunMenu_onevent);
}


function RunMenu_end() {
    document.removeEventListener("mousedown", RunMenu_onevent);
    byId("Build App").removeEventListener("click", RunMenu_onevent);
    byId("Rebuild App").removeEventListener("click", RunMenu_onevent);
    byId("Rebuild All").removeEventListener("click", RunMenu_onevent);
    byId("Copy Assets").removeEventListener("click", RunMenu_onevent);
    byId("Run App").removeEventListener("click", RunMenu_onevent);
    byId("Generate Docs").removeEventListener("click", RunMenu_onevent);
    byId("Export to Android Studio").removeEventListener("click", RunMenu_onevent);
    dk.close("DKBuild/RunMenu.html");
}

function RunMenu_onevent(event) {
    console.log("RunMenu_onevent(" + event.currentTarget.id + "," + event.type + "," + event.value + ")\n");
    if (event.currentTarget.id === "Build App") {
        OS = byId("OSList").value;
        APP = byId("AppList").value;
        TYPE = byId("BuildType").value;
        LINK = byId("LinkType").value;
        LEVEL = "Build";
        DKThread_DKQueue("BuildApp " + APP + ":" + OS + ":" + TYPE + ":" + LINK + ":" + LEVEL, "DKBuild_DoResults();");
    }
    if (event.currentTarget.id === "Rebuild App") {
        OS = byId("OSList").value;
        APP = byId("AppList").value;
        TYPE = byId("BuildType").value;
        LINK = byId("LinkType").value;
        LEVEL = "Rebuild";
        DKThread_DKQueue("RebuildApp " + APP + ":" + OS + ":" + TYPE + ":" + LINK + ":" + LEVEL, "DKBuild_DoResults();");
    }
    if (event.currentTarget.id === "Rebuild All") {
        OS = byId("OSList").value;
        APP = byId("AppList").value;
        TYPE = byId("BuildType").value;
        LINK = byId("LinkType").value;
        LEVEL = "RebuildAll";
        DKThread_DKQueue("BuildAll " + APP + ":" + OS + ":" + TYPE + ":" + LINK + ":" + LEVEL, "DKBuild_DoResults();");
    }
    if (event.currentTarget.id === "Copy Assets") {
        console.warn("DKBuildGUI::Copy Assets: TODO\n");
    }
    if (event.currentTarget.id === "Run App") {
        OS = byId("OSList").value;
        APP = byId("AppList").value;
        if (DK_GetOS() === "Win32" || DK_GetOS() === "Win64") {
            if (OS === "win32") {
                DK_Run(DKPATH + "/DKApps/" + APP + "/" + OS + "/Release/" + APP + ".exe");
                var contents = DKFile_DirectoryContents(DKPATH);
                var files = contents.split(",");
                for (var i = 0; i < files.length; i++) {
                    if (dk.file.extist(DKPATH + "/" + files[i] + "/DKApps/" + APP + "/" + OS + "/Release/" + APP + ".exe")) {
                        //console.log(DKPATH+"/"+files[i]+"/DKApps/"+APP+"/"+OS+"/Release/"+APP+".exe\n");
                        DK_Run(DKPATH + "/" + files[i] + "/DKApps/" + APP + "/" + OS + "/Release/" + APP + ".exe");
                        return;
                    }
                }
            }
            if (OS === "win64") {
                DK_Run(DKPATH + "/DKApps/" + APP + "/" + OS + "/Release/" + APP + "_64.exe");
                DK_Run(DKPATH + "/USER/DKApps/" + APP + "/" + OS + "/Release/" + APP + "_64.exe");

                DK_Run(DKPATH + "/DKApps/" + APP + "/" + OS + "/Release/" + APP + "_64.exe");
                var contents = DKFile_DirectoryContents(DKPATH);
                var files = contents.split(",");
                for (var i = 0; i < files.length; i++) {
                    if (dk.file.extist(DKPATH + "/" + files[i] + "/DKApps/" + APP + "/" + OS + "/Release/" + APP + "_64.exe")) {
                        //console.log(DKPATH+"/"+files[i]+"/DKApps/"+APP+"/"+OS+"/Release/"+APP+"_64.exe\n");
                        DK_Run(DKPATH + "/" + files[i] + "/DKApps/" + APP + "/" + OS + "/Release/" + APP + "_64.exe");
                        return;
                    }
                }
            }
            if (OS === "android") {
                console.log("TODO: Run android from Windows\n");
            }
        }
        if (DK_GetOS() === "Mac") {
            if (OS === "mac") {
                console.log("TODO: Run mac apps from OSX\n");
            }
            if (OS = "ios") {
                console.log("TODO: Run iOS apps from OSX\n");
            }
            if (OS = "ios-simulator") {
                console.log("TODO: Run iOS-simulator apps from OSX\n");
            }
        }
        if (DK_GetOS() === "Linux") {
            //if(OS === "linux64"){
            //console.log("TODO: Run linux apps from Linux\n");
            if (dk.file.extist(DKPATH + "/DKApps/" + APP + "/" + OS + "/Release/" + APP + ".desktop")) {
                DK_Run(DKPATH + "/DKApps/" + APP + "/" + OS + "/Release/" + APP + ".desktop");
            }
            var contents = DKFile_DirectoryContents(DKPATH);
            var files = contents.split(",");
            for (var i = 0; i < files.length; i++) {
                if (dk.file.extist(DKPATH + "/" + files[i] + "/DKApps/" + APP + "/" + OS + "/Release/" + APP + ".desktop")) {
                    //console.log(DKPATH+"/"+files[i]+"/DKApps/"+APP+"/"+OS+"/Release/"+APP+".desktop\n");
                    DK_Run(DKPATH + "/" + files[i] + "/DKApps/" + APP + "/" + OS + "/Release/" + APP + ".desktop");
                    return;
                }
            }
            //}
        }
    }

    //TODO
    if (event.currentTarget.id === "Generate Docs") {
        console.log("Generate Docs: TODO\n");
        var doxy_path = "C:/Program Files/doxygen/bin/doxygen.exe";
        var doxy_file = DKPATH + "/DKDocs/Doxyfile";
        var doxy_exe = DKFile_GetShortName(doxy_path);
        DKFile_ChDir(DKPATH + "/DKDocs/");
        DK_Execute(doxy_exe + " " + doxy_file);
    }

    if (event.currentTarget.id === "Export to Android Studio") {
        console.log("Export to Android Studio\n");
        DKPlugin("DKBuild/AndroidImport.js", function() {
            AndroidImport_Import();
        });
    }

    if (event.currentTarget === document) {
        if (byId("DKBuild/RunMenu.html").contains(document.elementFromPoint(window.mouseX, window.mouseY))) {
            return;
        }
    }
    dk.close("DKBuild/RunMenu.js");
}
