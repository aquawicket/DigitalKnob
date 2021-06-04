function DKWindow_init() {
}

function DKWindow_end() {
}

function DKWindow_Fullscreen() {
    if (document.documentElement.requestFullScreen) {
        document.documentElement.requestFullScreen();
    } else if (document.documentElement.mozRequestFullScreen) {
        document.documentElement.mozRequestFullScreen();
    } else if (document.documentElement.webkitRequestFullScreen) {
        document.documentElement.webkitRequestFullScreen(Element.ALLOW_KEYBOARD_INPUT);
    } else {
        return false;
    }
    return true;
}

function DKWindow_GetHeight() {
    var w = window
      , d = document
      , e = d.documentElement
      , g = d.getElementsByTagName('body')[0]
      , x = w.innerWidth || e.clientWidth || g.clientWidth
      , y = w.innerHeight || e.clientHeight || g.clientHeight;
    //console.log("DKWindow_GetHeight(): = "+y.toString()+"\n");
    return y;
}

function DKWindow_GetMouseX() {
    return mouseX;
}

function DKWindow_GetMouseY() {
    return mouseY;
}

function DKWindow_GetPixelRatio() {
    return window.devicePixelRatio || 1;
}

function DKWindow_GetWidth() {
    var w = window
      , d = document
      , e = d.documentElement
      , g = d.getElementsByTagName('body')[0]
      , x = w.innerWidth || e.clientWidth || g.clientWidth
      , y = w.innerHeight || e.clientHeight || g.clientHeight;
    //console.log("DKWindow_GetWidth(): = "+x.toString()+"\n");
    return x;
}

function DKWindow_GetX() {
    //console.log("DKWindow_GetX() = "+window.screenX+"\n");
    return window.screenX;
}

function DKWindow_GetY() {
    //console.log("DKWindow_GetY() = "+window.screenY+"\n");
    return window.screenY;
}

function DKWindow_IsFullscreen() {
    if ((document.fullScreenElement && document.fullScreenElement !== null) || (!document.mozFullScreen && !document.webkitIsFullScreen)) {
        return false;
    }
    return true;
}

if (DK_GetBrowser() !== "CEF") {
    function DKWindow_SetHeight(h) {
        //FIXME - does not work
        window.resizeTo(DKWindow_GetWidth(), h);
        return false;
    }
}

if (DK_GetBrowser() !== "CEF") {
    function DKWindow_SetWidth(w) {
        //FIXME - does not work
        window.resizeTo(w, DKWindow_GetHeight());
        return false;
    }
}

if (DK_GetBrowser() !== "CEF") {
    function DKWindow_SetX(x) {
        //FIXME - does not work
        window.moveTo(x, DKWindow_GetY());
        return false;
    }
}

if (DK_GetBrowser() !== "CEF") {
    function DKWindow_SetY(y) {
        //FIXME - does not work
        window.moveTo(DKWindow_GetX(), y);
        return false;
    }
}

function DKWindow_Windowed() {
    if (document.cancelFullScreen) {
        document.cancelFullScreen();
    } else if (document.mozCancelFullScreen) {
        document.mozCancelFullScreen();
    } else if (document.webkitCancelFullScreen) {
        document.webkitCancelFullScreen();
    } else {
        return false;
    }
    return true;
}
