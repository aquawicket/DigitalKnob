var appurl = ""; //Set this to the locatin of DKMySql.php

///////////////////////
function DKLogin_Init()
{
	DKCreate("DKLogin/DKLogin.html");
	DKAddEvent("LoginClose", "click", DKLogin_OnEvent);
	DKAddEvent("DKLoginFacebook", "click", DKLogin_OnEvent);
	DKAddEvent("DKLoginButton", "click", DKLogin_OnEvent);
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
		DKFacebook_Login();
		DKFacebook_Query('/me', "id", DKLogin_fbresponse);
		DKFacebook_Query('/me', "name", DKLogin_fbresponse);
	}
	
	if(DK_Id(event, "DKLoginButton")){
		DKLogin_Login(DKWidget_GetValue("DKLoginUsername"), DKWidget_GetValue("DKLoginPassword"));	
	}
}

////////////////////////////////////////////
function DKLogin_fbresponse(param, response)
{
	if(param == "id"){
		DKLog("ID: "+response, DKDEBUG);
	}
	if(param == "name"){
		DKLog("Name: "+response, DKDEBUG);
		DKWidget_SetInnerHtml("DKLoginStatus", response+" logged in.");
	}
	
	DKLog("Facebook response: "+response, DKDEBUG);
}

//////////////////////////////////
function DKLogin_Login(name, pass)
{
	DKLog("Loging in. . . \n", DKDEBUG);

	if(!name || !pass){
		DKLog("Logged Failed. \n", DKERROR);
		DKFile_SetSetting("settings.txt", "[NAME]", "");
		DKFile_SetSetting("settings.txt", "[PASS]", "");
		DKWidget_SetInnerHtml("DKLoginStatus", "Login Failed.");
		return false;
	}

	DKMySqlSetPhp(appurl);
	DKMySqlConnect("10.8.13.213", "DKUser", "DigitalKnob123!", "");
	DKMySqlDatabase("DKUser");

	var query = "SELECT EMAIL, PASS FROM Login WHERE EMAIL='"+name+"' AND PASS='"+pass+"'";
	var result = DKMySql_Query(query);
	DKLog(result, DKDEBUG);
	var records = result.split(',');

	if(records.length > 2){
		DKDebug("Successfully Logged in. \n");
		DKFile_SetSetting("settings.txt", "[NAME]", name);
		DKFile_SetSetting("settings.txt", "[PASS]", pass);
		DKWidget_SetInnerHtml("DKLoginStatus", name+" logged in.");
		return true;
	}

	DKLog("Logged Failed. \n", DKERROR);
	DKFile_SetSetting("settings.txt", "[NAME]", "");
	DKFile_SetSetting("settings.txt", "[PASS]", "");
	DKFile_SetInnerHtml("DKLoginStatus", "Login Failed.");
	return false;
}
