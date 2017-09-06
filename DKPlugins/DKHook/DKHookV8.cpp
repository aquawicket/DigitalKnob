#ifdef USE_DKCef
#include "DKHookV8.h"
#include "DKHook.h"

/////////////////////
void DKHookV8::Init()
{
	DKLog("DKHookV8::Init()\n", DKDEBUG);
	//DKV8::AttachFunction("Test", DKHookV8::Test);
	DKV8::AttachFunction("DKHook_SendHook", DKHookV8::SendHook);
	DKV8::AttachFunction("DKHook_GetValue", DKHookV8::GetValue);
	DKV8::AttachFunction("DKHook_SetValue", DKHookV8::SetValue);
	DKV8::AttachFunction("DKHook_GetClass", DKHookV8::GetClass);
	DKV8::AttachFunction("DKHook_GetTop", DKHookV8::GetTop);
	DKV8::AttachFunction("DKHook_GetLeft", DKHookV8::GetLeft);
	DKV8::AttachFunction("DKHook_GetParent", DKHookV8::GetParent);
	DKV8::AttachFunction("DKHook_Click", DKHookV8::Click);
	DKV8::AttachFunction("DKHook_SetHandle", DKHookV8::SetHandle);
	DKV8::AttachFunction("DKHook_PrevHandle", DKHookV8::PrevHandle);
	DKV8::AttachFunction("DKHook_NextHandle", DKHookV8::NextHandle);
	DKV8::AttachFunction("DKHook_ToggleHighlight", DKHookV8::ToggleHighlight);
	DKV8::AttachFunction("DKHook_SetWindowHandle", DKHookV8::SetWindowHandle);
	DKV8::AttachFunction("DKHook_GetWindows", DKHookV8::GetWindows);
	DKV8::AttachFunction("DKHook_CurrentHandle", DKHookV8::CurrentHandle);
	DKV8::AttachFunction("DKHook_WindowExists", DKHookV8::WindowExists);
	DKV8::AttachFunction("DKHook_WaitForWindow", DKHookV8::WaitForWindow);
	DKV8::AttachFunction("DKHook_WaitForHandle", DKHookV8::WaitForHandle);
}

///////////////////
void DKHookV8::End()
{
	DKLog("DKHookV8::End()\n", DKDEBUG);
}

/*
///////////////////////////////////////////////////
bool DKHookV8::Test(CefArgs args, CefReturn retval)
{
	DKLog("DKHookV8::Test(CefArgs,CefReturn)\n", DKDEBUG);
	DKString data = args[0]->GetStringValue();
	DKString result = data;
	retval = CefV8Value::CreateString(result);
	return true;
}
*/

///////////////////////////////////////////////////////
bool DKHookV8::SendHook(CefArgs args, CefReturn retval)
{
	DKString window = args->GetString(0);
	DKString handle = args->GetString(1);
	DKString data = args->GetString(2);

	if(!DKHook::Instance("DKHook")->SendHook(window, handle, data)){
		return false;
	}
	return true;
}

///////////////////////////////////////////////////////
bool DKHookV8::GetValue(CefArgs args, CefReturn retval)
{
	DKString value;
	if(!DKHook::Instance("DKHook")->GetString(value)){
		return false;
	}
	retval->SetString(0, value);
	return true;
}

///////////////////////////////////////////////////////
bool DKHookV8::SetValue(CefArgs args, CefReturn retval)
{
	DKString value = args->GetString(0);
	if(!DKHook::Instance("DKHook")->SetString(value)){
		retval->SetBool(0, false);
		return false;
	}
	retval->SetBool(0, true);
	return true;
}

///////////////////////////////////////////////////////
bool DKHookV8::GetClass(CefArgs args, CefReturn retval)
{
	DKString clas;
	if(!DKHook::Instance("DKHook")->GetClass(clas)){
		return false;
	}
	retval->SetString(0, clas);
	return true;
}

/////////////////////////////////////////////////////
bool DKHookV8::GetTop(CefArgs args, CefReturn retval)
{
	int top;
	if(!DKHook::Instance("DKHook")->GetTop(top)){
		return false;
	}
	retval->SetInt(0, top);
	return true;
}

//////////////////////////////////////////////////////
bool DKHookV8::GetLeft(CefArgs args, CefReturn retval)
{
	int left;
	if(!DKHook::Instance("DKHook")->GetLeft(left)){
		return false;
	}
	retval->SetInt(0, left);
	return true;
}

////////////////////////////////////////////////////////
bool DKHookV8::GetParent(CefArgs args, CefReturn retval)
{
	DKString parent;
	if(!DKHook::Instance("DKHook")->GetParent(parent)){
		retval->SetBool(0, false);
		return false;
	}
	retval->SetString(0, parent);
	return true;
}

////////////////////////////////////////////////////
bool DKHookV8::Click(CefArgs args, CefReturn retval)
{
	if(!DKHook::Instance("DKHook")->Click()){
		retval->SetBool(0, false);
		return false;
	}
	retval->SetBool(0, true);
	return true;
}

////////////////////////////////////////////////////////
bool DKHookV8::SetHandle(CefArgs args, CefReturn retval)
{
	if(args->GetType(0) == VTYPE_INT){ //By handle number
		if(!DKHook::Instance("DKHook")->SetHandle(args->GetInt(0))){
			retval->SetBool(0, false);
			return false;
		}
	}
	else if(args->GetType(0) == VTYPE_STRING && args->GetType(1) == VTYPE_STRING){ //By handle class, value
		if(!DKHook::Instance("DKHook")->SetHandle(args->GetString(0), args->GetString(1))){
			retval->SetBool(0, false);
			return false;
		}
	}
	else if(args->GetType(0) == VTYPE_STRING){ //By handle value
		if(!DKHook::Instance("DKHook")->SetHandle(args->GetString(0))){
			retval->SetBool(0, false);
			return false;
		}
	}
	retval->SetBool(0, true);
	return true;
}

/////////////////////////////////////////////////////////
bool DKHookV8::PrevHandle(CefArgs args, CefReturn retval)
{
	if(!DKHook::Instance("DKHook")->PrevHandle()){
		return false;
	}
	return true;
}

/////////////////////////////////////////////////////////
bool DKHookV8::NextHandle(CefArgs args, CefReturn retval)
{
	if(!DKHook::Instance("DKHook")->NextHandle()){
		return false;
	}
	return true;
}

//////////////////////////////////////////////////////////////
bool DKHookV8::ToggleHighlight(CefArgs args, CefReturn retval)
{
	DKHook::Instance("DKHook")->ToggleHighlight();
	return true;
}

//////////////////////////////////////////////////////////////
bool DKHookV8::SetWindowHandle(CefArgs args, CefReturn retval)
{
	DKString window = args->GetString(0);
	if(!DKHook::Instance("DKHook")->SetWindowHandle(window)){
		retval->SetBool(0, false);
		return false;
	}
	retval->SetBool(0, true);
	return true;
}

/////////////////////////////////////////////////////////
bool DKHookV8::GetWindows(CefArgs args, CefReturn retval)
{
	DKStringArray arry = DKHook::Instance("DKHook")->GetWindows();
	DKString list = toString(arry, ",");
	retval->SetString(0, list);
	return true;
}

////////////////////////////////////////////////////////////
bool DKHookV8::CurrentHandle(CefArgs args, CefReturn retval)
{
	DKString handle = toString(DKHook::Instance("DKHook")->currentHandle);
	retval->SetString(0, handle);
	return true;
}

///////////////////////////////////////////////////////////
bool DKHookV8::WindowExists(CefArgs args, CefReturn retval)
{
	DKString window = args->GetString(0);
	if(!DKHook::Instance("DKHook")->WindowExists(window)){
		retval->SetBool(0, false);
		return false;
	}
	retval->SetBool(0, true);
	return true;
}

////////////////////////////////////////////////////////////
bool DKHookV8::WaitForWindow(CefArgs args, CefReturn retval)
{
	DKString window = args->GetString(0);
	int timeout = args->GetInt(1);
	if(!DKHook::Instance("DKHook")->WaitForWindow(window, timeout)){
		retval->SetBool(0, false);
		return false;
	}
	retval->SetBool(0, true);
	return true;
}

////////////////////////////////////////////////////////////
bool DKHookV8::WaitForHandle(CefArgs args, CefReturn retval)
{
	if(args->GetType(0) == VTYPE_INT){ //By handle number
		if(!DKHook::Instance("DKHook")->WaitForHandle(args->GetInt(0), args->GetInt(1))){
			retval->SetBool(0, false);
			return false;
		}
	}
	else if(args->GetType(0) == VTYPE_STRING && args->GetType(1) == VTYPE_STRING){ //By handle class, value
		if(!DKHook::Instance("DKHook")->WaitForHandle(args->GetString(0), args->GetString(1), args->GetInt(2))){
			retval->SetBool(0, false);
			return false;
		}
	}
	else if(args->GetType(0) == VTYPE_STRING){ //By handle value
		if(!DKHook::Instance("DKHook")->WaitForHandle(args->GetString(0), args->GetInt(1))){
			retval->SetBool(0, false);
			return false;
		}
	}
	retval->SetBool(0, true);
	return true;
}

#endif //USE_DKCef