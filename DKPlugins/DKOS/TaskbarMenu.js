//TODO - Give this DKTtaskbarMenu the ability start with a blank slate.
// All elements will be added dynamically via DKTaskbarMenu functions.   I.E.  DKTaskbarMenu_AddApp(); 
// Start with a blank DKTaskbarMenu that forms to the number of elements in it.

function TaskbarMenu(){}
dk.taskbarMenu = DKPlugin(TaskbarMenu)


TaskbarMenu.prototype.init = function TaskbarMenu_init() {
    dk.create("DKOS/TaskbarMenu.html", function() {
        document.addEventListener("mousedown", TaskbarMenu.onevent);
        byId("OpenSource").addEventListener("click", TaskbarMenu.onevent);
        byId("OpenDebug").addEventListener("click", TaskbarMenu.onevent);
        byId("PushDKFiles").addEventListener("click", TaskbarMenu.onevent);
        byId("ClearConsole").addEventListener("click", TaskbarMenu.onevent);
        byId("Info").addEventListener("click", TaskbarMenu.onevent);
        byId("Reload").addEventListener("click", TaskbarMenu.onevent);
        byId("CloseDKGui").addEventListener("click", TaskbarMenu.onevent);
        byId("FileExplorer").addEventListener("click", TaskbarMenu.onevent);
        byId("OpenBuilder").addEventListener("click", TaskbarMenu.onevent);
        byId("OpenNotepad").addEventListener("click", TaskbarMenu.onevent);
        byId("InputTest").addEventListener("click", TaskbarMenu.onevent);
        byId("OpenMessage").addEventListener("click", TaskbarMenu.onevent);
        byId("OpenTetris").addEventListener("click", TaskbarMenu.onevent);
        byId("OpenGoogle").addEventListener("click", TaskbarMenu.onevent);
        byId("TaskbarMenu_Run").addEventListener("keydown", TaskbarMenu.onevent);
        byId("Git").addEventListener("click", TaskbarMenu.onevent);
        byId("TaskbarMenu_Run").focus();
    });
}

TaskbarMenu.prototype.end = function TaskbarMenu_end() {
    document.removeEventListener("mousedown", TaskbarMenu.onevent);
    byId("OpenSource").removeEventListener("click", TaskbarMenu.onevent);
    byId("OpenDebug").removeEventListener("click", TaskbarMenu.onevent);
    byId("PushDKFiles").removeEventListener("click", TaskbarMenu.onevent);
    byId("ClearConsole").removeEventListener("click", TaskbarMenu.onevent);
    byId("Info").removeEventListener("click", TaskbarMenu.onevent);
    byId("Reload").removeEventListener("click", TaskbarMenu.onevent);
    byId("CloseDKGui").removeEventListener("click", TaskbarMenu.onevent);
    byId("FileExplorer").removeEventListener("click", TaskbarMenu.onevent);
    byId("OpenBuilder").removeEventListener("click", TaskbarMenu.onevent);
    byId("OpenNotepad").removeEventListener("click", TaskbarMenu.onevent);
    byId("InputTest").removeEventListener("click", TaskbarMenu.onevent);
    byId("OpenMessage").removeEventListener("click", TaskbarMenu.onevent);
    byId("OpenTetris").removeEventListener("click", TaskbarMenu.onevent);
    byId("OpenGoogle").removeEventListener("click", TaskbarMenu.onevent);
    byId("TaskbarMenu_Run").removeEventListener("keydown", TaskbarMenu.onevent);
    byId("Git").removeEventListener("click", TaskbarMenu.onevent);
    dk.close("DKOS/TaskbarMenu.html");
}

TaskbarMenu.onevent = function TaskbarMenu_onevent(event) {
    if (event.currentTarget.id === "FileExplorer") {
        DKPlugin("DKFile/DKSolution.js", function(rval) {
            if (!rval) {
                return;
            }
            DKFrame_Html("DKFile/DKSolution.html");
            DKFrame_SetTitle("DKFile/DKSolution.html", "File Explorer");
            DKSolution_UpdatePath(DKAssets_LocalAssets());
        });
    }
    if (event.currentTarget.id === "OpenBuilder") {
        DKPlugin("DKBuild/DKBuildGUI.js", function(rval) {
            if (!rval) {
                return;
            }
            DKFrame_Html("DKBuild/DKBuildGUI.html");
        });
    }
    if (event.currentTarget.id === "OpenNotepad") {
        DKPlugin("DKFile/DKFileAssociation.js", function() {
            DKFileAssociation_Open("DKNotepad/DKNotepad.js");
        });
    }
    if (event.currentTarget.id === "InputTest") {
        DKPlugin("DKFile/DKFileAssociation.js", function() {
            DKFileAssociation_Open("DKInputTest/DKInput.js");
        });
    }
    if (event.currentTarget.id === "OpenMessage") {
        DKPlugin("DKGui/DKMessageBox.js", function() {
            DKFrame_Html("DKGui/DKMessageBox.html");
            DKMessageBox_Message("Test DKGui/DKMussageBox");
        });
    }
    if (event.currentTarget.id === "OpenTetris") {
        DKPlugin("DKGui/DKFrame.js", function() {
            DKFrame_Iframe("Tetris", "http://www.lutanho.net/play/tetris.html", 440, 560);
        });
    }
    if (event.currentTarget.id === "OpenGoogle") {
        DKPlugin("DKGui/DKFrame.js", function() {
            DKFrame_Iframe("Google", "https://google.com", 640, 480);
        });
    }

    if (event.currentTarget.id === "Git") {
        DKPlugin("DKGui/DKMenu.js", function() {
            DKPlugin("DKGit/GitMenu.js", function() {
                //DKMenu_ValidatePosition("DKGit/GitMenu.html")
                if (!window.mouseX) {
                    window.mouseX = "10",
                    window.mouseY = "10";
                }
                byId("DKGit/GitMenu.html").style.left = window.mouseX + "px";
                byId("DKGit/GitMenu.html").style.top = window.mouseY + "px";
            });
        });
    }
    if (event.currentTarget.id === "OpenSource") {
        //console.log("OpenSource\n");
        dk.create("DKWidgetJS");
        var source = document.body.outerHTML;
        var assets = DKAssets_LocalAssets();
        DKFile_StringToFile(source, assets + "source.html");
        DKPlugin("DKNotepad/DKNotepad.js", function() {
            DKFrame_Html("DKNotepad/DKNotepad.html");
            DKNotepad_Open(assets + "source.html");
            //console.log(source+"\n");
        });
    }
    if (event.currentTarget.id === "OpenDebug") {
        if (DK_GetBrowser() === "RML") {
            DKRml_DebuggerOn();
            //FIXME
        }
        if (DK_GetBrowser() === "CEF") {
            CPP_DKCef_ShowDevTools(0);
        }
    }
    if (event.currentTarget.id === "PushDKFiles") {
        DKDebug_PushDKFiles();
    }
    if (event.currentTarget.id === "ClearConsole") {
        console.clear();
    }
    if (event.currentTarget.id === "Info") {
        console.log("\n**** DKOBJECTS ****\n");
        var objects = DK_GetObjects();
        var arry = objects.split(",");
        for (var i = 0; i < arry.length; i++) {
            if (!arry[i]) {
                continue;
            }
            console.log(arry[i] + "\n");
        }
        console.log("\n");

        console.log("**** DKEVENTS ****\n");
        var events = DK_GetEvents();
        var arry = events.split(",");
        for (var i = 0; i < arry.length; i++) {
            if (!arry[i]) {
                continue;
            }
            console.log(arry[i] + "\n");
        }
        console.log("\n");

        console.log("**** DKFUNCTIONS ****\n");
        var events = DK_GetFunctions();
        var arry = events.split(",");
        for (var i = 0; i < arry.length; i++) {
            if (!arry[i]) {
                continue;
            }
            console.log(arry[i] + "\n");
        }
        console.log("\n");
    }
    if (event.currentTarget.id === "Reload") {
        DKFrame_CloseAll();
        //CPP_DK_Reload();
        location.reload();
    }
    if (event.currentTarget.id === "CloseDKGui") {
        dk.close("TaskbarMenu.js")
        CPP_DK_Exit();
        return;
    }
    if (event.currentTarget.id === "TaskbarMenu_Run") {
        if (event.code !== "Enter") {
            return;
        }
        TaskbarMenu_Run(byId("TaskbarMenu_Run").value);
    }

    if (event.currentTarget === document) {
        if (byId("DKOS/TaskbarMenu.html").contains(document.elementFromPoint(window.mouseX, window.mouseY))) {
            return;
        }
    }
    dk.close("DKOS/TaskbarMenu.js");
}

TaskbarMenu.prototype.Add = function TaskbarMenu_Add(title, code) {
    //<div title="tooltip" id="FileExplorer" style="position:absolute;top:5rem;left:10rem;">File Explorer</div>
    var ele = DK_CreateElement(byId("DKOS/TaskbarMenu.html"), "div", "TaskbarMenu_item");
    ele.innerHTML = title;
}

TaskbarMenu.prototype.Run = function TaskbarMenu_Run(command) {
    if (command.indexOf("http://") === 0) {
        DKFrame_Iframe(command, command, "100%", "100%");
        return true;
    }
    if (command.indexOf("https://") === 0) {
        DKFrame_Iframe(command, command, "100%", "100%");
        return true;
    }
    if (command.indexOf("file://") === 0) {
        DKFrame_Iframe(command, command, "100%", "100%");
        return true;
    }
    CPP_DK_RunDuktape(command);
}
