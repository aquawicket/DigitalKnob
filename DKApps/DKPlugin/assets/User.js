var datapath = DKAssets_GetDataPath();
DKLog("datapath: "+datapath+"\n");
DKLoadPlugin(datapath+"DKPlugin1/DKPlugin1.dll");
DK_CallFunc("DKPlugin1::SomeFunction","");
DKLoadPlugin(datapath+"DKPlugin2/DKPlugin2.dll");
DK_CallFunc("DKPlugin2::SomeFunction","");