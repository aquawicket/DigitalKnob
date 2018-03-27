#ifdef USE_DKCef
#include "DK/DKApp.h"
#include "DKTray/DKTray.h"
#include "DKTray/DKTrayV8.h"

/////////////////////
bool DKTrayV8::Init()
{
	DKLog("DKTrayV8::Init()\n", DKDEBUG);

	DKV8::AttachFunction("DKTray_AddItem", DKTrayV8::AddItem);
	return true;
}

///////////////////
bool DKTrayV8::End()
{
	DKLog("DKTrayV8::End()\n", DKDEBUG);
	return true;
}



//////////////////////////////////////////////////////
bool DKTrayV8::AddItem(CefArgs args, CefReturn retval)
{
	//DKLog("DKTrayV8::AddItem(CefArgs,CefReturn)\n", DKDEBUG);
	//DKString name = args[0]->GetStringValue();
	DKString name = args->GetString(0);
	//int id = args[1]->GetIntValue();
	int id = args->GetInt(1);
	if(!DKTray::Get("DKTray0")->AddItem(name, id)){ return false; }
	return true;
}

#endif //USE_DKCef