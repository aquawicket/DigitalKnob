////////////////////////////////////
function DKEditor_BrowserMenu_Init()
{
	dk.create("DKEditor/DKEditor_BrowserMenu.html");
	document.addEventListener("mousedown", DKEditor_BrowserMenu_onevent);
	
	DKEditor_BrowserMenu_Populate();
}

///////////////////////////////////
function DKEditor_BrowserMenu_End()
{
	document.removeEventListener("mousedown", DKEditor_BrowserMenu_onevent);
	dk.close("DKEditor/DKEditor_BrowserMenu.html");
}

////////////////////////////////////////////
function DKEditor_BrowserMenu_OnEvent(event)
{
	console.log("DKEditor_BrowserMenu_OnEvent("+event.currentTarget.id+","+event.type+","+event.value+")\n");
	if(event.currentTarget.id === "DKEditor_BrowserMenu_Chrome"){
		DK_Run("C:/Program Files (x86)/Google/Chrome/Application/chrome.exe", "--allow-file-access-from-files "+DKApp_url);
	}
	if(event.currentTarget.id === "DKEditor_BrowserMenu_Firefox"){
		DK_Run("C:/Program Files (x86)/Mozilla Firefox/firefox.exe", DKApp_url);
	}
	if(event.currentTarget.id === "DKEditor_BrowserMenu_IE"){
		var url = DKApp_url.replace("file:///", "");
		DK_Run("C:/Program Files (x86)/Internet Explorer/iexplore.exe", url);
	}
	if(event.currentTarget.id === "DKEditor_BrowserMenu_Opera"){
		DK_Run("C:/Program Files/Opera/launcher.exe", "--allow-file-access-from-files "+DKApp_url);
	}
	if(event.currentTarget.id === "DKEditor_BrowserMenu_Safari"){
		DK_Run("C:/Program Files (x86)/Safari/Safari.exe", DKApp_url);
	}
	
	/////////////////////////////////////
	if(event.currentTarget === document){
		if(byId("DKEditor/DKEditor_BrowserMenu.html").contains(document.elementFromPoint(window.mouseX, window.mouseY))){
			return;
		}
	}
	
	dk.close("DKEditor/DKEditor_BrowserMenu.js");
}

////////////////////////////////////////
function DKEditor_BrowserMenu_Populate()
{
	DKEditor_BrowserMenu_AddChrome();
	DKEditor_BrowserMenu_AddFirefox();
	DKEditor_BrowserMenu_AddIE();
	DKEditor_BrowserMenu_AddOpera();
	DKEditor_BrowserMenu_AddSafari();
}

/////////////////////////////////////////
function DKEditor_BrowserMenu_AddChrome()
{
	var chrome = DK_CreateElement(byId("DKEditor/DKEditor_BrowserMenu.html"), "div", "DKEditor_BrowserMenu_Chrome");
	chrome.class = "option";
	chrome.innerHTML = "Chrome";
	chrome.addEventListener("click", DKEditor_BrowserMenu_onevent);
}


//////////////////////////////////////////
function DKEditor_BrowserMenu_AddFirefox()
{
	var firefox = DK_CreateElement(byId("DKEditor/DKEditor_BrowserMenu.html"), "div", "DKEditor_BrowserMenu_Firefox");
	firefox.class = "option";
	firefox.innerHTML = "Firefox";
	firefox.addEventListener("click", DKEditor_BrowserMenu_onevent);
}

/////////////////////////////////////
function DKEditor_BrowserMenu_AddIE()
{
	var ie = DK_CreateElement(byId("DKEditor/DKEditor_BrowserMenu.html"), "div", "DKEditor_BrowserMenu_IE");
	ie.class = "option";
	ie.innerHTML = "Internet Explorer";
	ie.addEventListener("click", DKEditor_BrowserMenu_onevent);
}

////////////////////////////////////////
function DKEditor_BrowserMenu_AddOpera()
{
	var opera = DK_CreateElement(byId("DKEditor/DKEditor_BrowserMenu.html"), "div", "DKEditor_BrowserMenu_Opera");
	opera.class = "option";
	opera.innerHTML = "Opera";
	opera.addEventListener("click", DKEditor_BrowserMenu_onevent);
}

/////////////////////////////////////////
function DKEditor_BrowserMenu_AddSafari()
{
	var safari = DK_CreateElement(byId("DKEditor/DKEditor_BrowserMenu.html"), "div", "DKEditor_BrowserMenu_Safari");
	safari.class = "option";
	safari.innerHTML = "Safari";
	safari.addEventListener("click", DKEditor_BrowserMenu_onevent);
}