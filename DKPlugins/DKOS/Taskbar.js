var pos;
var animation;

function Taskbar_init() {
    dk.create("DKOS/Taskbar.html,DKOS/DKOS.html", function() {
        //dk.create("DKOS/Taskbar.html", function(){
        dk.create("DKOS/Clock.js", function() {
            dk.create("DKOS/Scale.js", function() {
                if (DK_GetBrowser() === "Rml") {
                    dk.create("DKDebug/BugReport.js", function() {});
                    byId("DKOS/Taskbar.html").appendChild(byId("DKDebug/BugReport.html"));
                    //reparent
                }
                byId("start").addEventListener("click", Taskbar_onevent);
                byId("test_animate").addEventListener("click", Taskbar_onevent);
            });
        });
    });
}

function Taskbar_end() {
    byId("start").removeEventListener("click", Taskbar_onevent);
    byId("test_animate").removeEventListener("click", Taskbar_onevent);
    dk.close("DKOS/Taskbar.html");
    dk.close("DKOS/Scale.js");
    dk.close("DKOS/Clock.js");
    dk.close("DKDebug/BugReport.js");
}

function Taskbar_OnEvent(event) {
    if (event.currentTarget.id === "start") {
        dk.create("DKOS/TaskbarMenu.js", function() {});
    }
    if (event.currentTarget.id === "test_animate") {
        console.log("Taskbar_OnEvent(): animate");
        pos = -45;
        animation = setInterval(Taskbar_Animate, 15);
        //EventLoop.run();
    }
}

function Taskbar_Animate() {
    if (pos === 0) {
        clearInterval(animation);
    } else {
        pos++;
        byId("DKOS/Taskbar.html").style.bottom = pos + "rem";
        //DK_DoFrame();
    }
}
