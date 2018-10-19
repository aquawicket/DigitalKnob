#ifdef USE_DKCef
#include "DK/DKApp.h"
#include "DKTray/DKTray.h"
#include "DKTray/DKTrayV8.h"

/////////////////////
bool DKTrayV8::Init()
{
	DKDebug();
	DKV8::AttachFunction("DKTray_AddItem", DKTrayV8::AddItem);
	DKV8::AttachFunction("DKTray_GetIcon", DKTrayV8::GetIcon);
	DKV8::AttachFunction("DKTray_SetIcon", DKTrayV8::SetIcon);
	DKV8::AttachFunction("DKTray_SetTooltip", DKTrayV8::SetTooltip);
	DKV8::AttachFunction("DKTray_ShowBalloon", DKTrayV8::ShowBalloon);
	return true;
}

///////////////////
bool DKTrayV8::End()
{
	DKDebug();
	return true;
}

//////////////////////////////////////////////////////
bool DKTrayV8::AddItem(CefArgs args, CefReturn retval)
{
	DKDebug(args, retval);
	DKString name = args->GetString(0);
	int id = args->GetInt(1);
	if(!DKTray::Get()->AddItem(name, id)){ return false; }
	return true;
}

//////////////////////////////////////////////////////
bool DKTrayV8::GetIcon(CefArgs args, CefReturn retval)
{
	DKDebug(args, retval);
	DKString icon;
	if(!DKTray::Get()->GetIcon(icon)){ return false; }
	if(!retval->SetString(0, icon)){ return false; }
	return true;
}

//////////////////////////////////////////////////////
bool DKTrayV8::SetIcon(CefArgs args, CefReturn retval)
{
	DKDebug(args, retval);
	DKString file = args->GetString(0);
	if(!DKTray::Get()->SetIcon(file)){ return false; }
	return true;
}

/////////////////////////////////////////////////////////
bool DKTrayV8::SetTooltip(CefArgs args, CefReturn retval)
{
	DKDebug(args, retval);
	DKString name = args->GetString(0);
	if(!DKTray::Get()->SetTooltip(name)){ return false; }
	return true;
}

//////////////////////////////////////////////////////////
bool DKTrayV8::ShowBalloon(CefArgs args, CefReturn retval)
{
	DKDebug(args, retval);
	DKString string = args->GetString(0);
	//int seconds = duk_require_int(ctx, 1);
	if(!DKTray::Get()->ShowBalloon(string/*, seconds*/)){ return false; }
	return true;
}

#endif //USE_DKCef