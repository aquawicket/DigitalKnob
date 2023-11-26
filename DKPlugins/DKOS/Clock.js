//"use strict";

function Clock(){}
dk.os.clock = DKPlugin(Clock, "singleton")

var clock_time;
var clock_date;
var second_flag = false;

Clock.prototype.init = function Clock_init() {
    dk.create("DKOS/Clock.html,DKOS/Taskbar.html", function() {
        window.addEventListener("second", dk.os.clock.onevent);
        dk.os.clock.update();
    });
}

Clock.prototype.end = function Clock_end() {
    window.removeEventListener("second", dk.os.clock.onevent);
    dk.close("DKOS/Clock.html");
}

Clock.prototype.onevent = function Clock_onevent(event) {
    if (DK_Type(event, "second"))
        dk.os.clock.update();
}

Clock.prototype.update = function Clock_update() {
    if (second_flag) {
        byId("time").style.color = "rgb(255,255,255)";
        second_flag = false;
    } else {
        byId("time").style.color = "rgb(220,220,220)";
        second_flag = true;
    }
    if (CPP_DK_GetTime() !== clock_time) {
        clock_time = CPP_DK_GetTime();
        byId("time").innerHTML = clock_time;
    }
    if (CPP_DK_GetDate() !== clock_date) {
        clock_date = CPP_DK_GetDate();
        byId("date").innerHTML = clock_date;
    }
}
