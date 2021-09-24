
function DKWindow(){}
dk.window = DKPlugin(DKWindow)


dk.window.fullscreen = function dk_window_fullscreen() {
	if(DUKTAPE)
		CPP_DKWindow_Fullscreen()
    if (document.documentElement.requestFullScreen)
        document.documentElement.requestFullScreen();
	else if (document.documentElement.mozRequestFullScreen)
        document.documentElement.mozRequestFullScreen();
	else if (document.documentElement.webkitRequestFullScreen)
        document.documentElement.webkitRequestFullScreen(Element.ALLOW_KEYBOARD_INPUT);
	else
        return false;
    return true;
}

dk.window.getHeight = function dk_window_getHeight() {
    var w = window
      , d = document
      , e = d.documentElement
      , g = d.getElementsByTagName('body')[0]
      , x = w.innerWidth || e.clientWidth || g.clientWidth
      , y = w.innerHeight || e.clientHeight || g.clientHeight;
    return y;
}

dk.window.getMouseX = function dk_window_getMouseX() {
    return mouseX;
}

dk.window.getMouseY = function dk_window_GetMouseY() {
    return mouseY;
}

dk.window.getPixelRatio function dk_window_getPixelRatio() {
    return window.devicePixelRatio || 1;
}

dk.window.getWidth function = dk.window_getWidth() {
    var w = window
      , d = document
      , e = d.documentElement
      , g = d.getElementsByTagName('body')[0]
      , x = w.innerWidth || e.clientWidth || g.clientWidth
      , y = w.innerHeight || e.clientHeight || g.clientHeight;
    return x;
}

dk.window.getX = function dk_window_getX() {
    return window.screenX;
}

dk.window.getY = function dk_window_getY() {
    return window.screenY;
}

dk.window.isFullscreen = function dk_window_isFullscreen() {
    if ((document.fullScreenElement && document.fullScreenElement !== null) || (!document.mozFullScreen && !document.webkitIsFullScreen))        
		return false;
    return true;
}

if (DK_GetBrowser() !== "CEF") {
	dk.window.setHeight = function dk_window_setHeight(h) {
        //FIXME - does not work
        window.resizeTo(dk.window.getWidth(), h);
        return false;
    }
}

if (DK_GetBrowser() !== "CEF") {
	dk.window.setWidth = function dk_window_setWidth(w) {
        //FIXME - does not work
        window.resizeTo(w, dk.window.getHeight());
        return false;
    }
}

if (DK_GetBrowser() !== "CEF") {
	dk.window.setX = function dk_window_setX(x) {
        //FIXME - does not work
        window.moveTo(x, dk.window.getY());
        return false;
    }
}

if (DK_GetBrowser() !== "CEF") {
	dk.window.setY = function dk_window_setY(y) {
        //FIXME - does not work
        window.moveTo(dk.window.getX(), y);
        return false;
    }
}

dk.window.windowed = function dk_window_windowed() {
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

