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
		DKLog("DKLogin_OnEvent(): DKLoginFacebook \n");
		DKCreate("DKLogin/DKFacebook.js", function(){
			DKFacebookLogin(DKLogin_OnConnect);
		});
	}
}

////////////////////////////////////////////
function DKLogin_FBresponse(param, response)
{
	if(param == "id"){
		DKLog("ID: "+response);
	}
	if(param == "name"){
		DKLog("Name: "+response);
		DKWidget_SetInnerHtml("DKLoginStatus", response+" logged in.");
	}
	
	DKLog("Facebook response: "+response, DKDEBUG);
}

/////////////////////////////////
function DKLogin_OnConnect(value)
{
	DKLog("DKLogin_FBconnect() \n");
	if(value.status === 'connected'){
		DKFacebook_Query('/me', "name", DKLogin_FBresponse);
		DKFacebook_Query('/me', "id", DKLogin_FBresponse);
	}
}
