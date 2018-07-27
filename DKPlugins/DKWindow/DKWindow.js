//BROWSER

function DKWindow_SetHeight(){ DKLog("DKWindow_SetHeight(): not available for "+DK_GetBrowser()+"\n", DKWARN); }
function DKWindow_SetWidth(){ DKLog("DKWindow_SetWidth(): not available for "+DK_GetBrowser()+"\n", DKWARN); }
function DKWindow_SetX(){ DKLog("DKWindow_SetX(): not available for "+DK_GetBrowser()+"\n", DKWARN); }
function DKWindow_SetY(){ DKLog("DKWindow_SetY(): not available for "+DK_GetBrowser()+"\n", DKWARN); }

//////////////////////////
function DKWindow_Init(){}

/////////////////////////
function DKWindow_End(){}

//////////////////////////////
function DKWindow_Fullscreen()
{
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
	return mouseX;
}

/////////////////////////////
function DKWindow_GetMouseY()
{
	return mouseY;
}

/////////////////////////////////
function DKWindow_GetPixelRatio()
{
	return window.devicePixelRatio || 1;
}

////////////////////////////
function DKWindow_GetWidth()
{ 
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
	//DKLog("DKWindow_GetX() = "+window.screenX+"\n");
	return window.screenX;
}

////////////////////////
function DKWindow_GetY()
{
	//DKLog("DKWindow_GetY() = "+window.screenY+"\n");
	return window.screenY;
}

////////////////////////////////
function DKWindow_IsFullscreen()
{
	if((document.fullScreenElement && document.fullScreenElement !== null) || (!document.mozFullScreen && !document.webkitIsFullScreen)){
		return false;
	}
	return true;
}

/////////////////////////
//function DKWindow_SetX(x)
//{
//	DKLog("DKWindow_SetX("+x+")\n");
//	window.moveTo(x, DKWindow_GetY());
//	return true;
//}

////////////////////////////
function DKWindow_Windowed()
{
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