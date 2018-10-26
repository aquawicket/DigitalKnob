var working = true;

//////////////////////////////
function DKBuildConsole_Init()
{
	DKDEBUGFUNC();
	DKCreate("DKBuild/DKBuild.js", function(){
		DKBuild_ValidateCmake();
		DKBuild_ValidateVC2015();
		DKBuild_ValidateGcc();
		DKBuild_ValidateXcode();
	
		while(working){
			DKBuildConsole_Process();
		}
	});
}

/////////////////////////////
function DKBuildConsole_End()
{
	DKDEBUGFUNC();
	DKClose("DKBuild/DKBuild.js");
}

//////////////////////////////////////
function DKBuildConsole_ChooseUpdate()
{
	DKDEBUGFUNC();
	DKINFO("\n**** Update DigitalKnob ??? ****\n");
	DKINFO("Y. Update\n");
	DKINFO("C. Commit\n");
	DKINFO("R. Reset Apps and Plugins\n");
	DKINFO("X. Reset Everything\n");
	DKINFO("any other key to Skip\n");
	DKINFO("ESC. exit\n\n");
	
	var key = 10;
	while(key == 10){ //unix fix
		key = DK_GetKey();
	}
	
	//DKINFO("Key pressed: "+String(key)+"\n");
	
	if(key == 27){ //Esc key
		DK_Exit();
	}
	if(key == 121){ //y key
		DKCreate("DKGit/DKGit.js", function(){
			DKGit_GitUpdate();
		});
	}
	if(key == 99){ //c key
		DKCreate("DKGit/DKGit.js", function(){
			DKGit_GitCommit();
		});
	}
	if(key == 114){ //r key
		DKBuild_ResetAppsPlugins();
		DKGit_GitUpdate();
	}
	if(key == 120){ //x key
		DKBuild_Reset3rdParty();
		DKBuild_ResetAppsPlugins();
		DKGit_GitUpdate();
	}
}

//////////////////////////////////
function DKBuildConsole_SelectOs()
{
	DKDEBUGFUNC();
	DKINFO("\n**** SELECT OS TO BUILD ****\n");
	DKINFO("1. win32\n");
	DKINFO("2. win64\n");
	DKINFO("3. mac32\n");
	DKINFO("4. mac64\n");
	DKINFO("5. linux32\n");
	DKINFO("6. linux64\n");
	DKINFO("7. ios32\n");
	DKINFO("8. ios64\n");
	DKINFO("9. iossim32\n");
	DKINFO("a. iossim64\n");
	DKINFO("b. android32\n");
	DKINFO("c. android64\n");
	DKINFO("ESC. exit\n\n");

	var key = 10;
	while(key == 10){ //unix fix
		key = DK_GetKey();
	}
	//DKINFO("Key pressed: "+String(key)+"\n");
	if(key == 27){
		DK_Exit();
	}
	if(key == 49){
		OS = "win32";
	}
	else if(key == 50){
		OS = "win64";
	}
	else if(key == 51){
		OS = "mac32";
	}
	else if(key == 52){
		OS = "mac64";
	}
	else if(key == 53){
		OS = "linux32";
	}
	else if(key == 54){
		OS = "linux64";
	}
	else if(key == 55){
		OS = "ios32";
	}
	else if(key == 56){
		OS = "ios64";
	}
	else if(key == 57){
		OS = "iossim32";
	}
	else if(key == 97){
		OS = "iossim64";
	}
	else if(key == 98){
		OS = "android32";
	}
	else if(key == 99){
		OS = "android64";
	}
	else{
		DKERROR("\n INVALID OPTION\n\n");
	}
}

/////////////////////////////////////
function DKBuildConsole_SelectApp()
{
	DKDEBUGFUNC();
	DKINFO("**** SELECT APP TO BUILD ****\n");
	for(var i=0; i<APP_LIST.length; ++i){
		DKINFO(DKBuildConsole_TranslateOption(i)+":"+APP_LIST[i]+"\n");
	}
	DKINFO("ESC. exit\n\n");
	
	var key = 10;
	while(key == 10){ //unix fix
		key = DK_GetKey();
	}
	//DKINFO("Key pressed: "+String(key)+"\n");
	if(key == 27){
		DK_Exit();
	}
	
	DKBuildConsole_KeyToApp(key);
	
	if(APP == ""){
		DKERROR("\n INVALID OPTION\n\n");
	}
}

//////////////////////////////////////
function DKBuildConsole_SelectType()
{
	DKDEBUGFUNC();
	DKINFO("**** SELECT BUILD TYPE ****\n");
	DKINFO("1. Debug\n");
	DKINFO("2. Release\n");
	DKINFO("3. All\n");
	DKINFO("ESC. exit\n\n");
	
	var key = 10;
	while(key == 10){ //unix fix
		key = DK_GetKey();
	}
	//DKINFO("Key pressed: "+String(key)+"\n");
	if(key == 27){
		DK_Exit();
	}
	if(key == 49){
		TYPE = "Debug";
	}
	else if(key == 50){
		TYPE = "Release";
	}
	else if(key == 51){
		TYPE = "ALL";
	}
	else{
		DKERROR("\n INVALID OPTION\n\n");
	}
}

/////////////////////////////////
function DKBuildConsole_Process()
{
	DKDEBUGFUNC();
	OS = "";
	APP = "";
	TYPE = "";
	LEVEL = "RebuildAll";
	
	DKBuildConsole_ChooseUpdate();
	
	if(!DKFile_Exists(DKPATH+"/DK/DKPlugins")){
		DKERROR("ERROR: can't find "+DKPATH+" \n");
		DK_GetKey();
		DK_Exit();
	}
	
	while(OS == ""){
		DKBuildConsole_SelectOs();
	}
	DKINFO("###########################\n");
	DKINFO(OS+" ->\n");
	DKINFO("###########################\n\n");

	DKBuild_GetAppList();
	while(APP == ""){
		DKBuildConsole_SelectApp();
	}
	DKINFO("###########################\n");
	DKINFO(OS+" -> "+APP+" ->\n");
	DKINFO("###########################\n\n");

	while(TYPE == ""){
		DKBuildConsole_SelectType();
	}
	DKINFO("###########################\n");
	DKINFO(OS+" -> "+APP+" -> "+TYPE+"\n");
	DKINFO("###########################\n\n");

	DKINFO("Press any key to Build\n\n");
	DK_GetKey();
	
	DKBuild_DoResults();
}

//////////////////////////////////////////////
function DKBuildConsole_TranslateOption(num)
{
	DKDEBUGFUNC();
	if(num == 0){return "1";}
	if(num == 1){return "2";}
	if(num == 2){return "3";}
	if(num == 3){return "4";}
	if(num == 4){return "5";}
	if(num == 5){return "6";}
	if(num == 6){return "7";}
	if(num == 7){return "8";}
	if(num == 8){return "9";}
	if(num == 9){return "a";}
	if(num == 10){return "b";}
	if(num == 11){return "c";}
	if(num == 12){return "d";}
	if(num == 13){return "e";}
	if(num == 14){return "f";}
	if(num == 15){return "g";}
	if(num == 16){return "h";}
	if(num == 17){return "i";}
	if(num == 18){return "j";}
	if(num == 19){return "k";}
	if(num == 20){return "l";}
	if(num == 21){return "m";}
	if(num == 22){return "n";}
	if(num == 23){return "o";}
	if(num == 24){return "p";}
	if(num == 25){return "q";}
	if(num == 26){return "r";}
	if(num == 27){return "s";}
	if(num == 28){return "t";}
	if(num == 29){return "u";}
	if(num == 30){return "v";}
	if(num == 31){return "w";}
	if(num == 32){return "x";}
	if(num == 33){return "y";}
	if(num == 34){return "z";}
}

///////////////////////////////////////
function DKBuildConsole_KeyToApp(key)
{
	DKDEBUGFUNC();
	if(key == 49){ APP = APP_LIST[0]; } //1
	if(key == 50){ APP = APP_LIST[1]; } //2
	if(key == 51){ APP = APP_LIST[2]; } //3 
	if(key == 52){ APP = APP_LIST[3]; } //4
	if(key == 53){ APP = APP_LIST[4]; } //5
	if(key == 54){ APP = APP_LIST[5]; } //6
	if(key == 55){ APP = APP_LIST[6]; } //7
	if(key == 56){ APP = APP_LIST[7]; } //8
	if(key == 57){ APP = APP_LIST[8]; } //9
	if(key == 97){ APP = APP_LIST[9]; } //a
	if(key == 98){ APP = APP_LIST[10]; } //b
	if(key == 99){ APP = APP_LIST[11]; } //c
	if(key == 100){ APP = APP_LIST[12]; } //d
	if(key == 101){ APP = APP_LIST[13]; } //e
	if(key == 102){ APP = APP_LIST[14]; } //f
	if(key == 103){ APP = APP_LIST[15]; } //g
	if(key == 104){ APP = APP_LIST[16]; } //h
	if(key == 105){ APP = APP_LIST[17]; } //i
	if(key == 106){ APP = APP_LIST[18]; } //j
	if(key == 107){ APP = APP_LIST[19]; } //k
	if(key == 108){ APP = APP_LIST[20]; } //l
	if(key == 109){ APP = APP_LIST[21]; } //m
	if(key == 110){ APP = APP_LIST[22]; } //n
	if(key == 111){ APP = APP_LIST[23]; } //o
	if(key == 112){ APP = APP_LIST[24]; } //p
	if(key == 113){ APP = APP_LIST[25]; } //q
	if(key == 114){ APP = APP_LIST[26]; } //r
	if(key == 115){ APP = APP_LIST[27]; } //s
	if(key == 116){ APP = APP_LIST[28]; } //t
	if(key == 117){ APP = APP_LIST[29]; } //u
	if(key == 118){ APP = APP_LIST[30]; } //v
	if(key == 119){ APP = APP_LIST[31]; } //w
	if(key == 120){ APP = APP_LIST[32]; } //x
	if(key == 121){ APP = APP_LIST[33]; } //y
	if(key == 122){ APP = APP_LIST[34]; } //z
}