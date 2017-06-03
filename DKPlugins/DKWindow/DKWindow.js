//BROWSER

function DKWindow_Fullscreen(){ DKLog("DKWindow_Fullscreen(): not available for "+DK_GetBrowser()+"\n", DKWARN); }
function DKWindow_GetX(){ DKLog("DKWindow_GetX(): not available for "+DK_GetBrowser()+"\n", DKWARN); }
function DKWindow_GetY(){ DKLog("DKWindow_GetY(): not available for "+DK_GetBrowser()+"\n", DKWARN); }
function DKWindow_IsFullscreen(){ DKLog("DKWindow_IsFullscreen(): not available for "+DK_GetBrowser()+"\n", DKWARN); }
function DKWindow_SetHeight(){ DKLog("DKWindow_SetHeight(): not available for "+DK_GetBrowser()+"\n", DKWARN); }
function DKWindow_SetWidth(){ DKLog("DKWindow_SetWidth(): not available for "+DK_GetBrowser()+"\n", DKWARN); }
function DKWindow_SetX(){ DKLog("DKWindow_SetX(): not available for "+DK_GetBrowser()+"\n", DKWARN); }
function DKWindow_SetY(){ DKLog("DKWindow_SetY(): not available for "+DK_GetBrowser()+"\n", DKWARN); }
function DKWindow_Windowed(){ DKLog("DKWindow_Windowed(): not available for "+DK_GetBrowser()+"\n", DKWARN); }

//////////////////////////
function DKWindow_Init(){}

/////////////////////////
function DKWindow_End(){}

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