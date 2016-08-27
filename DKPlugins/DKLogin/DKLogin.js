///////////////////////
function DKLogin_Init()
{
	DKCreate("DKLogin/DKFacebook.js");
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
		DKFacebookLogin(DKLogin_FBconnect);
		/*
		DKFacebook_Login();
		DKFacebook_Query('/me', "id", DKLogin_fbresponse);
		DKFacebook_Query('/me', "name", DKLogin_fbresponse);
		*/
	}
}

////////////////////////////////////////////
function DKLogin_fbresponse(param, response)
{
	/*
	if(param == "id"){
		DKLog("ID: "+response, DKDEBUG);
	}
	if(param == "name"){
		DKLog("Name: "+response, DKDEBUG);
		DKWidget_SetInnerHtml("DKLoginStatus", response+" logged in.");
	}
	
	DKLog("Facebook response: "+response, DKDEBUG);
	*/
}

////////////////////////////
function DKLogin_FBconnect()
{
	DKLog("DKLogin_FBconnect() \n");
}
