var FACEBOOK_ID;
var FACEBOOK_NAME;

///////////////////////
function DKLogin_Init()
{
	DKDEBUGFUNC();
	DKCreate("DKLogin/DKLogin.css");
	DKCreate("DKLogin/DKLogin.html");
	DKAddEvent("DKLoginFacebook", "click", DKLogin_OnEvent);
}

//////////////////////
function DKLogin_End()
{
	DKDEBUGFUNC();
	DKRemoveEvents(DKLogin_OnEvent);
	DKClose("DKLogin/DKLogin.html");
	DKClose("DKLogin/DKLogin.css");
}

///////////////////////////////
function DKLogin_OnEvent(event)
{
	DKDEBUGFUNC(event);
	if(DK_Id(event, "DKLoginFacebook")){
		DKINFO("DKLogin_OnEvent(): DKLoginFacebook\n");
		DKCreate("DKLogin/DKFacebook.js", function(){
			DKFacebookLogin(DKLogin_OnConnect);
		});
	}
}

/////////////////////////////////
function DKLogin_OnConnect(value)
{
	DKDEBUGFUNC(value);
	if(value.status === 'connected'){
		DKFacebook_Query('/me', "name", DKLogin_FBresponse);
		DKFacebook_Query('/me', "id", DKLogin_FBresponse);
		DKWidget_Hide("DKLoginFacebook");
	}
}

////////////////////////////////////////////
function DKLogin_FBresponse(param, response)
{
	DKDEBUGFUNC(param, response);	
	if(param == "name"){
		FACEBOOK_NAME = response;
		
		var id = DKWidget_CreateElement("DKLogin/DKLogin.html", "div", "fbname");
		DKWidget_SetProperty(id, "font-size", "18rem");
		DKWidget_SetInnerHtml(id, FACEBOOK_NAME);
	}
	if(param == "id"){
		FACEBOOK_ID = response;
		
		var id = DKWidget_CreateElement("DKLogin/DKLogin.html", "img", "fbpic");
		DKWidget_SetAttribute(id, "src", "http://graph.facebook.com/"+FACEBOOK_ID+"/picture");
	}
}