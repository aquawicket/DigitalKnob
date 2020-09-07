//console.log("test duktape console");
DKCreate_CPP("DKWindow");
DKCreate_CPP("DKRml");

location.href = DKAssets_LocalAssets()+"index.html";
//location.href = DKAssets_LocalAssets()+"DKWebTest/index.html";
//location.href = "C:/digitalknob/DK/DKPlugins/index.html";

DKRml_DebuggerOn();
//DKRml_DebuggerToggle(); //FIXME

DKCreate("DKDebug/DKDebug.js", function(){});  