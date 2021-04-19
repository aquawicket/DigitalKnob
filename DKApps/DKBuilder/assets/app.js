CPP_DKDuktape_Create("DKTray");
//CPP_DKTray_Init();
CPP_DKDuktape_Create("DKBuild/DKBuildConsole.js");
//CPP_DKDuktape_Create("DKUpdate");

/*
var fullPath = "C:/Program Files (x86)/Microsoft Visual Studio/2019/Community/MSBuild/Current/Bin/MSBuild.exe";
var local_assets = CPP_DKAssets_LocalAssets();
var getShortPath = local_assets+"/DKFile/getShortPath.cmd";
var shortPath = CPP_DKDuktape_Execute(getShortPath+' "'+fullPath+'"');
shortPath = shortPath.slice(0, -1)
console.log("\n\n\nshorPath = <start>"+shortPath+"<end>");
*/
