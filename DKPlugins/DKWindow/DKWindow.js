//BROWSER


////////////////////////
function DKWindow_Init()
{
	DKDebug();
}

///////////////////////
function DKWindow_End()
{
	DKDebug();
}

//////////////////////////////
function DKWindow_Fullscreen()
{
	DKDebug();
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
	DKDebug();
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
	DKDebug();
	return mouseX;
}

/////////////////////////////
function DKWindow_GetMouseY()
{
	DKDebug();
	return mouseY;
}

/////////////////////////////////
function DKWindow_GetPixelRatio()
{
	DKDebug();
	return window.devicePixelRatio || 1;
}

////////////////////////////
function DKWindow_GetWidth()
{
	DKDebug();
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
	DKDebug();
	//DKLog("DKWindow_GetX() = "+window.screenX+"\n");
	return window.screenX;
}

////////////////////////
function DKWindow_GetY()
{
	DKDebug();
	//DKLog("DKWindow_GetY() = "+window.screenY+"\n");
	return window.screenY;
}

////////////////////////////////
function DKWindow_IsFullscreen()
{
	DKDebug();
	if((document.fullScreenElement && document.fullScreenElement !== null) || (!document.mozFullScreen && !document.webkitIsFullScreen)){
		return false;
	}
	return true;
}

/////////////////////////////
if(DK_GetBrowser() != "CEF"){
	function DKWindow_SetHeight(h)
	{
		DKDebug(h);
		//FIXME - does not work
		window.resizeTo(DKWindow_GetWidth(), h);  
		return false;
	}
}

/////////////////////////////
if(DK_GetBrowser() != "CEF"){
	function DKWindow_SetWidth(w)
	{
		DKDebug(w);
		//FIXME - does not work
		window.resizeTo(w, DKWindow_GetHeight());
		return false;
	}
}

/////////////////////////////
if(DK_GetBrowser() != "CEF"){
	function DKWindow_SetX(x)
	{
		DKDebug(x);
		//FIXME - does not work
		window.moveTo(x, DKWindow_GetY());
		return false;
	}
}

/////////////////////////////
if(DK_GetBrowser() != "CEF"){
	function DKWindow_SetY(y)
	{
		DKDebug(y);
		//FIXME - does not work
		window.moveTo(DKWindow_GetX(), y);
		return false;
	}
}

////////////////////////////
function DKWindow_Windowed()
{
	DKDebug();
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