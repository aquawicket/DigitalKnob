//BROWSER


////////////////////////
function DKWindow_Init()
{
	DKDEBUGFUNC();
}

///////////////////////
function DKWindow_End()
{
	DKDEBUGFUNC();
}

//////////////////////////////
function DKWindow_Fullscreen()
{
	DKDEBUGFUNC();
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
	DKDEBUGFUNC();
	var w = window,
    d = document,
    e = d.documentElement,
    g = d.getElementsByTagName('body')[0],
    x = w.innerWidth || e.clientWidth || g.clientWidth,
    y = w.innerHeight|| e.clientHeight|| g.clientHeight;
	//DKINFO("DKWindow_GetHeight(): = "+y.toString()+"\n");
	return y;
}

/////////////////////////////
function DKWindow_GetMouseX()
{
	DKDEBUGFUNC();
	return mouseX;
}

/////////////////////////////
function DKWindow_GetMouseY()
{
	DKDEBUGFUNC();
	return mouseY;
}

/////////////////////////////////
function DKWindow_GetPixelRatio()
{
	DKDEBUGFUNC();
	return window.devicePixelRatio || 1;
}

////////////////////////////
function DKWindow_GetWidth()
{
	DKDEBUGFUNC();
	var w = window,
    d = document,
    e = d.documentElement,
    g = d.getElementsByTagName('body')[0],
    x = w.innerWidth || e.clientWidth || g.clientWidth,
    y = w.innerHeight|| e.clientHeight|| g.clientHeight;
	//DKINFO("DKWindow_GetWidth(): = "+x.toString()+"\n");
	return x;
}

////////////////////////
function DKWindow_GetX()
{
	DKDEBUGFUNC();
	//DKINFO("DKWindow_GetX() = "+window.screenX+"\n");
	return window.screenX;
}

////////////////////////
function DKWindow_GetY()
{
	DKDEBUGFUNC();
	//DKINFO("DKWindow_GetY() = "+window.screenY+"\n");
	return window.screenY;
}

////////////////////////////////
function DKWindow_IsFullscreen()
{
	DKDEBUGFUNC();
	if((document.fullScreenElement && document.fullScreenElement !== null) || (!document.mozFullScreen && !document.webkitIsFullScreen)){
		return false;
	}
	return true;
}

/////////////////////////////
if(DK_GetBrowser() != "CEF"){
	function DKWindow_SetHeight(h)
	{
		DKDEBUGFUNC(h);
		//FIXME - does not work
		window.resizeTo(DKWindow_GetWidth(), h);  
		return false;
	}
}

/////////////////////////////
if(DK_GetBrowser() != "CEF"){
	function DKWindow_SetWidth(w)
	{
		DKDEBUGFUNC(w);
		//FIXME - does not work
		window.resizeTo(w, DKWindow_GetHeight());
		return false;
	}
}

/////////////////////////////
if(DK_GetBrowser() != "CEF"){
	function DKWindow_SetX(x)
	{
		DKDEBUGFUNC(x);
		//FIXME - does not work
		window.moveTo(x, DKWindow_GetY());
		return false;
	}
}

/////////////////////////////
if(DK_GetBrowser() != "CEF"){
	function DKWindow_SetY(y)
	{
		DKDEBUGFUNC(y);
		//FIXME - does not work
		window.moveTo(DKWindow_GetX(), y);
		return false;
	}
}

////////////////////////////
function DKWindow_Windowed()
{
	DKDEBUGFUNC();
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