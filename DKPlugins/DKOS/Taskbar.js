var pos;
var animation;

Taskbar.init = function Taskbar_init() {
    dk.create("DKOS/Taskbar.html,DKOS/DKOS.html", function() {
        //dk.create("DKOS/Taskbar.html", function(){
        DKPlugin("DKOS/Clock.js", function() {
            DKPlugin("DKOS/Scale.js", function() {
                if (DK_GetBrowser() === "RML") {
                    DKPlugin("DKDebug/BugReport.js", function() {});
                    byId("DKOS/Taskbar.html").appendChild(byId("DKDebug/BugReport.html"));
                    //reparent
                }
                byId("start").addEventListener("click", Taskbar_onevent);
                byId("test_animate").addEventListener("click", Taskbar_onevent);
            });
        });
    });
}

Taskbar.end = function Taskbar_end() {
    byId("start").removeEventListener("click", Taskbar_onevent);
    byId("test_animate").removeEventListener("click", Taskbar_onevent);
    dk.close("DKOS/Taskbar.html");
    dk.close("DKOS/Scale.js");
    dk.close("DKOS/Clock.js");
    dk.close("DKDebug/BugReport.js");
}

Taskbar.onevent = function Taskbar_onevent(event) {
    if (event.currentTarget.id === "start") {
        DKPlugin("DKOS/TaskbarMenu.js", function() {});
    }
    if (event.currentTarget.id === "test_animate") {
        console.log("Taskbar_onevent(): animate");
        pos = -45;
        animation = setInterval(Taskbar.animate, 15);
        //EventLoop.run();
    }
}

Taskbar.nimate = function Taskbar_animate() {
    if (pos === 0) {
        clearInterval(animation);
    } else {
        pos++;
        byId("DKOS/Taskbar.html").style.bottom = pos + "rem";
        //DK_DoFrame();
    }
}
