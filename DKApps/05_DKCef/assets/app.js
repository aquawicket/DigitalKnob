CPP_DK_Create("DKDuktapeDom")

var USE_CEF = 1;
var url = "chrome://gpu";
//var url = "https://www.google.com";

var width = 1240;
var height = 900;
CPP_DK_Create("DKCef");
CPP_DKCef_NewBrowser("Cef",0,0,width,height,url);
