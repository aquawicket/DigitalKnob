var welcome = "\n";
welcome = "######################### \n";
welcome += "####### DKTestAll ####### \n";
welcome += "######################### \n";

DKLog(welcome, DKINFO);

//TestJavascript
DKCreate("TestJavascript.js");
DKClose("TestJavascript.js");

//TestWindow
//DK_GetKey();
//DKLog("Press any key run  TestWindow.js\n", DKINFO);
DKCreate("TestWindow.js");

//TestRocket
//DK_GetKey();
//DKLog("Press any key run  TestRocket.js\n", DKINFO);
DKCreate("TestRocket.js");
