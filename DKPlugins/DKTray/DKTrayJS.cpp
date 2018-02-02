#ifdef USE_DKDuktape 
#include "DKTray/DKTray.h"
#include "DKTray/DKTrayJS.h"


/////////////////////
bool DKTrayJS::Init()
{
	DKDuktape::AttachFunction("DKTray_AddItem", DKTrayJS::AddItem);
	DKDuktape::AttachFunction("DKTray_GetIcon", DKTrayJS::GetIcon);
	DKDuktape::AttachFunction("DKTray_SetIcon", DKTrayJS::SetIcon);
	DKDuktape::AttachFunction("DKTray_SetTooltip", DKTrayJS::SetTooltip);
	DKDuktape::AttachFunction("DKTray_ShowBalloon", DKTrayJS::ShowBalloon);
	return true;
}

///////////////////////////////////////
int DKTrayJS::GetIcon(duk_context* ctx)
{
	DKString icon = DKTray::Get("DKTray0")->GetIcon();
	duk_push_string(ctx, icon.c_str());
	return 1;
}

///////////////////////////////////////
int DKTrayJS::SetIcon(duk_context* ctx)
{
	DKString file = duk_require_string(ctx, 0);
	DKTray::Get("DKTray0")->SetIcon(file);
	return 1;
}

///////////////////////////////////////
int DKTrayJS::AddItem(duk_context* ctx)
{
	//TODO
	DKString name = duk_require_string(ctx, 0);
	int id = duk_require_int(ctx, 1);
	DKTray::Get("DKTray0")->AddItem(name, id);
	return 1;
}

//////////////////////////////////////////
int DKTrayJS::SetTooltip(duk_context* ctx)
{
	DKString name = duk_require_string(ctx, 0);
	if(!DKTray::Get("DKTray0")->SetTooltip(name)){
		return 0;
	}
	return 1;
}

///////////////////////////////////////////
int DKTrayJS::ShowBalloon(duk_context* ctx)
{
	DKString string = duk_require_string(ctx, 0);
	//int seconds = duk_require_int(ctx, 1);
	DKTray::Get("DKTray0")->ShowBalloon(string/*, seconds*/);
	return 1;
}


#endif //USE_DKDuktape