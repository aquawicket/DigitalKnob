//BROWSER


////////////////////////
function DKWindow_Init()
{
	DKLog("DKWindow_Init()\n", DKDEBUG);
}

///////////////////////
function DKWindow_End()
{
	DKLog("DKWindow_Init()\n", DKDEBUG);
}

//////////////////////////////
function DKWindow_Fullscreen()
{
	DKLog("DKWindow_Fullscreen()\n", DKDEBUG);
	if(document.documentElement.requestFullScreen){  
		document.documentElement.requestFullScreen();  
	} 
	else if(document.documentElement.mozRequestFullScreen){  
		document.documentElement.mozRequestFullScreen();  
	} 
	else if(document.documentElement.webkitRequestFullScreen){  
		document.documentElement.webkitRequestFullScreen(Element.ALLOW_KEYBOARD_INPUT);  
	}
	else{
		return false;
	}
	return true;
}

/////////////////////////////
function DKWindow_GetHeight()
{
	DKLog("DKWindow_GetHeight()\n", DKDEBUG);
	var w = window,
    d = document,
    e = d.documentElement,
    g = d.getElementsByTagName('body')[0],
    x = w.innerWidth || e.clientWidth || g.clientWidth,
    y = w.innerHeight|| e.clientHeight|| g.clientHeight;
	//DKLog("DKWindow_GetHeight(): = "+y.toString());
	return y;
}

/////////////////////////////
function DKWindow_GetMouseX()
{
	DKLog("DKWindow_GetMouseX()\n", DKDEBUG);
	return mouseX;
}

/////////////////////////////
function DKWindow_GetMouseY()
{
	DKLog("DKWindow_GetMouseY()\n", DKDEBUG);
	return mouseY;
}

/////////////////////////////////
function DKWindow_GetPixelRatio()
{
	DKLog("DKWindow_GetPixelRatio()\n", DKDEBUG);
	return window.devicePixelRatio || 1;
}

////////////////////////////
function DKWindow_GetWidth()
{
	DKLog("DKWindow_GetWidth()\n", DKDEBUG);
	var w = window,
    d = document,
    e = d.documentElement,
    g = d.getElementsByTagName('body')[0],
    x = w.innerWidth || e.clientWidth || g.clientWidth,
    y = w.innerHeight|| e.clientHeight|| g.clientHeight;
	//DKLog("DKWindow_GetWidth(): = "+x.toString());
	return x;
}

////////////////////////
function DKWindow_GetX()
{
	DKLog("DKWindow_GetX()\n", DKDEBUG);
	//DKLog("DKWindow_GetX() = "+window.screenX+"\n");
	return window.screenX;
}

////////////////////////
function DKWindow_GetY()
{
	DKLog("DKWindow_GetY()\n", DKDEBUG);
	//DKLog("DKWindow_GetY() = "+window.screenY+"\n");
	return window.screenY;
}

////////////////////////////////
function DKWindow_IsFullscreen()
{
	DKLog("DKWindow_IsFullscreen()\n", DKDEBUG);
	if((document.fullScreenElement && document.fullScreenElement !== null) || (!document.mozFullScreen && !document.webkitIsFullScreen)){
		return false;
	}
	return true;
}

/////////////////////////////
if(DK_GetBrowser() != "CEF"){
	function DKWindow_SetHeight(h)
	{
		DKLog("DKWindow_SetHeight("+h+")\n", DKDEBUG);
		//FIXME - does not work
		window.resizeTo(DKWindow_GetWidth(), h);  
		return false;
	}
}

/////////////////////////////
if(DK_GetBrowser() != "CEF"){
	function DKWindow_SetWidth(w)
	{
		DKLog("DKWindow_SetWidth("+w+")\n", DKDEBUG);
		//FIXME - does not work
		window.resizeTo(w, DKWindow_GetHeight());
		return false;
	}
}

/////////////////////////////
if(DK_GetBrowser() != "CEF"){
	function DKWindow_SetX(x)
	{
		DKLog("DKWindow_SetX("+x+")\n", DKDEBUG);
		//FIXME - does not work
		window.moveTo(x, DKWindow_GetY());
		return false;
	}
}

/////////////////////////////
if(DK_GetBrowser() != "CEF"){
	function DKWindow_SetY(y)
	{
		DKLog("DKWindow_SetY("+y+")\n", DKDEBUG);
		//FIXME - does not work
		window.moveTo(DKWindow_GetX(), y);
		return false;
	}
}

////////////////////////////
function DKWindow_Windowed()
{
	DKLog("DKWindow_Windowed()\n", DKDEBUG);
	if(document.cancelFullScreen){  
		document.cancelFullScreen();  
	} 
	else if(document.mozCancelFullScreen){  
		document.mozCancelFullScreen();  
	} 
	else if(document.webkitCancelFullScreen){  
		document.webkitCancelFullScreen();  
	}
	else{
		return false;
	}
	return true;
}