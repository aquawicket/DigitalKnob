#ifdef USE_DKDuktape 
#include "DKTray/DKTray.h"
#include "DKTray/DKTrayJS.h"


/////////////////////
bool DKTrayJS::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("DKCPP_DKTray_AddItem", DKTrayJS::AddItem);
	DKDuktape::AttachFunction("DKCPP_DKTray_GetIcon", DKTrayJS::GetIcon);
	DKDuktape::AttachFunction("DKCPP_DKTray_SetIcon", DKTrayJS::SetIcon);
	DKDuktape::AttachFunction("DKCPP_DKTray_SetTooltip", DKTrayJS::SetTooltip);
	DKDuktape::AttachFunction("DKCPP_DKTray_ShowBalloon", DKTrayJS::ShowBalloon);
	return true;
}

///////////////////////////////////////
int DKTrayJS::AddItem(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString name = duk_require_string(ctx, 0);
	int id = duk_require_int(ctx, 1);
	if(!DKTray::Get()->AddItem(name, id)){ return 0; }
	return 1;
}

///////////////////////////////////////
int DKTrayJS::GetIcon(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString icon;
	if(!DKTray::Get()->GetIcon(icon)){ return 0; }
	duk_push_string(ctx, icon.c_str());
	return 1;
}

///////////////////////////////////////
int DKTrayJS::SetIcon(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString file = duk_require_string(ctx, 0);
	if(!DKTray::Get()->SetIcon(file)){ return 0; }
	return 1;
}

//////////////////////////////////////////
int DKTrayJS::SetTooltip(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString name = duk_require_string(ctx, 0);
	if(!DKTray::Get()->SetTooltip(name)){ return 0; }
	return 1;
}

///////////////////////////////////////////
int DKTrayJS::ShowBalloon(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString string = duk_require_string(ctx, 0);
	//int seconds = duk_require_int(ctx, 1);
	if(!DKTray::Get()->ShowBalloon(string/*, seconds*/)){ return 0; }
	return 1;
}


#endif //USE_DKDuktape