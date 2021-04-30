//FIXME - make the rml version work like the web version
var rgba = "0";
if (DK_GetBrowser() === "RML") {
    rgba = "127";
} else {
    rgba = "0.5";
}

dk.inputtest = new Object();

dk.inputtest.init = function dk_inputtest_init() {
    dk.create("DKInputTest/DKInput.html", function() {
        window.addEventListener("keypress", dk.inputtest.onevent);
        window.addEventListener("keydown", dk.inputtest.onevent);
        window.addEventListener("keyup", dk.inputtest.onevent);
        window.addEventListener("mousedown", dk.inputtest.onevent);
        window.addEventListener("mouseup", dk.inputtest.onevent);
        window.addEventListener("click", dk.inputtest.onevent);
        window.addEventListener("dblclick", dk.inputtest.onevent);
        window.addEventListener("mousemove", dk.inputtest.onevent);
        window.addEventListener("mouseover", dk.inputtest.onevent);
        window.addEventListener("mouseout", dk.inputtest.onevent);
        window.addEventListener("wheel", dk.inputtest.onevent);
        window.addEventListener("resize", dk.inputtest.onevent);
        window.addEventListener("input", dk.inputtest.onevent);
        window.addEventListener("change", dk.inputtest.onevent);
        window.addEventListener("contextmenu", dk.inputtest.onevent);
        window.addEventListener("scroll", dk.inputtest.onevent);
        window.addEventListener("drag", dk.inputtest.onevent);
        byId("Escape").addEventListener("mousedown", dk.inputtest.onevent);
        byId("Escape").addEventListener("mouseup", dk.inputtest.onevent);
    });
}

dk.inputtest.end = function dk_inputtest_end() {
    window.removeEventListener("keypress", dk.inputtest.onevent);
    window.removeEventListener("keydown", dk.inputtest.onevent);
    window.removeEventListener("keyup", dk.inputtest.onevent);
    window.removeEventListener("mousedown", dk.inputtest.onevent);
    window.removeEventListener("mouseup", dk.inputtest.onevent);
    window.removeEventListener("click", dk.inputtest.onevent);
    window.removeEventListener("dblclick", dk.inputtest.onevent);
    window.removeEventListener("mousemove", dk.inputtest.onevent);
    window.removeEventListener("mouseover", dk.inputtest.onevent);
    window.removeEventListener("mouseout", dk.inputtest.onevent);
    window.removeEventListener("wheel", dk.inputtest.onevent);
    window.removeEventListener("resize", dk.inputtest.onevent);
    window.removeEventListener("input", dk.inputtest.onevent);
    window.removeEventListener("change", dk.inputtest.onevent);
    window.removeEventListener("contextmenu", dk.inputtest.onevent);
    window.removeEventListener("scroll", dk.inputtest.onevent);
    window.removeEventListener("drag", dk.inputtest.onevent);
    byId("Escape").removeEventListener("mousedown", dk.inputtest.onevent);
    byId("Escape").removeEventListener("mouseup", dk.inputtest.onevent);
    dk.close("DKInputTest/DKInput.html");
}

dk.inputtest.onevent = function dk_inputtest_OnEvent(event) {
    byId("lastevent").innerHTML = "Last Event: " + event.currentTarget.id + "," + event.type;
    byId("event.char").innerHTML = "event.char: " + event.char;
    byId("event.charCode").innerHTML = "event.charCode: " + event.charCode;
    byId("event.code").innerHTML = "event.code: " + event.code;
    byId("event.key").innerHTML = "event.key: " + event.key;
    byId("event.keyCode").innerHTML = "event.keyCode: " + event.keyCode;
    byId("event.which").innerHTML = "event.which: " + event.which;

    if (event.type === "keypress") ///dk.inputtest.ProcessKeyPress(event.code);
    if (event.type === "keydown") 
        dk.inputtest.ProcessKeyDown(event.code);
    if (event.type === "keyup") 
        dk.inputtest.ProcessKeyUp(event.code);
    if (event.type === "mousedown")
        dk.inputtest.ProcessMouseDown(event.button);
        if (event.currentTarget !== window)
            dk.inputtest.Highlight(event.currentTarget.id);
    }
    if (event.type === "mouseup" || event.type === "click") {
        dk.inputtest.ProcessMouseUp(event.button);
        if (event.currentTarget !== window)
            dk.inputtest.UnHighlight(event.currentTarget.id);
    }
    //if(event.type === "mousemove"){
    byId("event.clientX").innerHTML = "event.clientX: " + event.clientX;
    byId("event.clientY").innerHTML = "event.clientY: " + event.clientY;
    byId("event.screenX").innerHTML = "event.screenX: " + event.screenX;
    byId("event.screenY").innerHTML = "event.screenY: " + event.screenY;
    byId("event.button").innerHTML = "event.button: " + event.button;
    //}
    if (event.type === "wheel") 
        byId("wheeldelta").innerHTML = "Wheel Delta: " + DK_GetValue(event);

    //element events
    if (event.currentTarget.id === "esc")
        console.log("event.currentTarget.id === 'esc'");
}

dk.inputtest.onmousedown = function dk_inputtest_ProcessMouseDown(button) {
    byId(button + "button").style.display = "block";
    byId(button + "button").style.visibility = "visible";
}

dk.inputtest.onmouseup = function dk_inputtest_ProcessMouseUp(button) {
    byId(button + "button").style.display = "none";
}

dk.inputtest.onkeydown = function dk_inputtest_ProcessKeyDown(key) {
    dk.inputtest.Highlight(key);
}

dk.inputtest.onkeyup = function dk_inputtest_ProcessKeyUp(key) {
    dk.inputtest.UnHighlight(key);
}

dk.inputtest.highlight = function dk_inputtest_Highlight(div) {
    if (!div)
        return error("div invalid");
    if (!byId(div))
        return;
    byId(div).style.backgroundColor = "rgba(0,255,0," + rgba + ")";
    if (div === "Shift")
        byId("Shift2").style.backgroundColor = "rgba(0,255,0,0.5)";
    if (div === "Meta")
        byId("Meta2").style.backgroundColor = "rgba(0,255,0,0.5)";
    if (div === "Control")
        byId("Control2").style.backgroundColor = "rgba(0,255,0,0.5)";
    if (div === "Alt") 
        byId("Alt2").style.backgroundColor = "rgba(0,255,0,0.5)";
    if (div === "Enter")
        byId("Enter2").style.backgroundColor = "rgba(0,255,0,0.5)";
}

dk.inputtest.unhighlight = function dk_inputtest_UnHighlight(div) {
    if (!div) 
        return error("div invalid");
    if (!byId(div))
        return;
    byId(div).style.backgroundColor = "rgba(0,255,0,0)";
    if (div === "Shift") 
        byId("Shift2").style.backgroundColor = "rgba(0,255,0,0)";
    if (div === "Meta")
        byId("Meta2").style.backgroundColor = "rgba(0,255,0,0)";
    if (div === "Control")
        byId("Control2").style.backgroundColor = "rgba(0,255,0,0)";
    if (div === "Alt")
        byId("Alt2").style.backgroundColor = "rgba(0,255,0,0)";
    if (div === "Enter")
        byId("Enter2").style.backgroundColor = "rgba(0,255,0,0)";
}
