DKCreate("DKDebug/DKDebug.js");

var welcome = "\n";
welcome = "######################### \n";
welcome += "####### DKTestAll ####### \n";
welcome += "######################### \n";
DKLog(welcome, DKINFO);

//TestJavascript
DKCreate("TestJavascript.js");
DKClose("TestJavascript.js");

//TestWindow
DKCreate("TestWindow.js");

//TestRocket
DKCreate("TestRocket.js");
