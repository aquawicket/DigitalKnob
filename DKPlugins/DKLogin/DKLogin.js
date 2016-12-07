var FACEBOOK_ID;
var FACEBOOK_NAME;

///////////////////////
function DKLogin_Init()
{
	DKCreate("DKLogin/DKLogin.html");
	DKAddEvent("DKLoginFacebook", "click", DKLogin_OnEvent);
}

//////////////////////
function DKLogin_End()
{
	DKClose("DKLogin/DKLogin.html");
}

///////////////////////////////
function DKLogin_OnEvent(event)
{
	if(DK_Id(event, "DKLoginFacebook")){
		DKLog("DKLogin_OnEvent(): DKLoginFacebook\n", DKINFO);
		DKCreate("DKLogin/DKFacebook.js", function(){
			DKFacebookLogin(DKLogin_OnConnect);
		});
	}
}

/////////////////////////////////
function DKLogin_OnConnect(value)
{
	DKLog("DKLogin_FBconnect()\n", DKINFO);
	if(value.status === 'connected'){
		DKFacebook_Query('/me', "name", DKLogin_FBresponse);
		DKFacebook_Query('/me', "id", DKLogin_FBresponse);
		DKWidget_Hide("DKLoginFacebook");
	}
}

////////////////////////////////////////////
function DKLogin_FBresponse(param, response)
{
	DKLog("DKLogin_FBresponse("+param+","+response+")", DKDEBUG);
	
	if(param == "name"){
		FACEBOOK_NAME = response;
		
		var id = DKWidget_CreateElement("DKLogin.html", "div", "fbname");
		DKWidget_SetProperty(id, "font-size", "18rem");
		DKWidget_SetInnerHtml(id, FACEBOOK_NAME);
	}
	if(param == "id"){
		FACEBOOK_ID = response;
		
		var id = DKWidget_CreateElement("DKLogin.html", "img", "fbpic");
		DKWidget_SetAttribute(id, "src", "http://graph.facebook.com/"+FACEBOOK_ID+"/picture");
	}
}
