#ifdef USE_DKCef
#include "DKHandlesV8.h"
#include "DKHandles.h"

////////////////////////
bool DKHandlesV8::Init()
{
	DKLog("DKHandlesV8::Init()\n", DKDEBUG);
	
	DKV8::AttachFunction("DKHandles_Click", DKHandlesV8::Click);
	DKV8::AttachFunction("DKHandles_CurrentHandle", DKHandlesV8::CurrentHandle);
	DKV8::AttachFunction("DKHandles_GetClass", DKHandlesV8::GetClass);
	DKV8::AttachFunction("DKHandles_GetLeft", DKHandlesV8::GetLeft);
	DKV8::AttachFunction("DKHandles_GetParent", DKHandlesV8::GetParent);
	DKV8::AttachFunction("DKHandles_GetTop", DKHandlesV8::GetTop);
	DKV8::AttachFunction("DKHandles_GetValue", DKHandlesV8::GetValue);
	DKV8::AttachFunction("DKHandles_GetWindows", DKHandlesV8::GetWindows);
	DKV8::AttachFunction("DKHandles_NextHandle", DKHandlesV8::NextHandle);
	DKV8::AttachFunction("DKHandles_PrevHandle", DKHandlesV8::PrevHandle);
	DKV8::AttachFunction("DKHandles_SendHook", DKHandlesV8::SendHook);
	DKV8::AttachFunction("DKHandles_SetHandle", DKHandlesV8::SetHandle);
	DKV8::AttachFunction("DKHandles_SetValue", DKHandlesV8::SetValue);
	DKV8::AttachFunction("DKHandles_SetWindowHandle", DKHandlesV8::SetWindowHandle);
	DKV8::AttachFunction("DKHandles_ShowWindow", DKHandlesV8::ShowWindow);
	DKV8::AttachFunction("DKHandles_ToggleHighlight", DKHandlesV8::ToggleHighlight);
	DKV8::AttachFunction("DKHandles_WaitForHandle", DKHandlesV8::WaitForHandle);
	DKV8::AttachFunction("DKHandles_WaitForWindow", DKHandlesV8::WaitForWindow);
	DKV8::AttachFunction("DKHandles_WindowExists", DKHandlesV8::WindowExists);
	return true;
}

///////////////////////
bool DKHandlesV8::End()
{
	DKLog("DKHandlesV8::End()\n", DKDEBUG);
	return true;
}



///////////////////////////////////////////////////////
bool DKHandlesV8::Click(CefArgs args, CefReturn retval)
{
	if(!DKHandles::Instance("DKHandles")->Click()){
		retval->SetBool(0, false);
		return false;
	}
	retval->SetBool(0, true);
	return true;
}

///////////////////////////////////////////////////////////////
bool DKHandlesV8::CurrentHandle(CefArgs args, CefReturn retval)
{
	DKString handle = toString(DKHandles::Instance("DKHandles")->currentHandle);
	retval->SetString(0, handle);
	return true;
}

//////////////////////////////////////////////////////////
bool DKHandlesV8::GetClass(CefArgs args, CefReturn retval)
{
	DKString clas;
	if(!DKHandles::Instance("DKHandles")->GetClass(clas)){
		return false;
	}
	retval->SetString(0, clas);
	return true;
}

/////////////////////////////////////////////////////////
bool DKHandlesV8::GetLeft(CefArgs args, CefReturn retval)
{
	int left;
	if(!DKHandles::Instance("DKHandles")->GetLeft(left)){
		return false;
	}
	retval->SetInt(0, left);
	return true;
}

///////////////////////////////////////////////////////////
bool DKHandlesV8::GetParent(CefArgs args, CefReturn retval)
{
	DKString parent;
	if(!DKHandles::Instance("DKHandles")->GetParent(parent)){
		retval->SetBool(0, false);
		return false;
	}
	retval->SetString(0, parent);
	return true;
}

////////////////////////////////////////////////////////
bool DKHandlesV8::GetTop(CefArgs args, CefReturn retval)
{
	int top;
	if(!DKHandles::Instance("DKHandles")->GetTop(top)){
		return false;
	}
	retval->SetInt(0, top);
	return true;
}

//////////////////////////////////////////////////////////
bool DKHandlesV8::GetValue(CefArgs args, CefReturn retval)
{
	DKString value;
	if(!DKHandles::Instance("DKHandles")->GetString(value)){
		return false;
	}
	retval->SetString(0, value);
	return true;
}

////////////////////////////////////////////////////////////
bool DKHandlesV8::GetWindows(CefArgs args, CefReturn retval)
{
	DKStringArray windows;
	if(!DKHandles::Instance("DKHandles")->GetWindows(windows)){
		retval->SetBool(0, false);
		return false;
	}
	DKString list = toString(windows, ",");
	retval->SetString(0, list);
	return true;
}

////////////////////////////////////////////////////////////
bool DKHandlesV8::NextHandle(CefArgs args, CefReturn retval)
{
	if(!DKHandles::Instance("DKHandles")->NextHandle()){
		return false;
	}
	return true;
}

////////////////////////////////////////////////////////////
bool DKHandlesV8::PrevHandle(CefArgs args, CefReturn retval)
{
	if(!DKHandles::Instance("DKHandles")->PrevHandle()){
		return false;
	}
	return true;
}

//////////////////////////////////////////////////////////
bool DKHandlesV8::SendHook(CefArgs args, CefReturn retval)
{
	DKString window = args->GetString(0);
	DKString handle = args->GetString(1);
	DKString data = args->GetString(2);

	if(!DKHandles::Instance("DKHandles")->SendHook(window, handle, data)){
		return false;
	}
	return true;
}

///////////////////////////////////////////////////////////
bool DKHandlesV8::SetHandle(CefArgs args, CefReturn retval)
{
	int timeout = 1;
	if(args->GetType(0) == VTYPE_INT){ //By handle number
		if(args->GetType(1) == VTYPE_INT){ timeout = args->GetInt(1); }
		if(!DKHandles::Instance("DKHandles")->SetHandle(args->GetInt(0), timeout)){
			retval->SetBool(0, false);
			return false;
		}
	}
	else if(args->GetType(0) == VTYPE_STRING && args->GetType(1) == VTYPE_STRING){ //By handle class, value
		if(args->GetType(2) == VTYPE_INT){ timeout = args->GetInt(2); }
		if(!DKHandles::Instance("DKHandles")->SetHandle(args->GetString(0), args->GetString(1), timeout)){
			retval->SetBool(0, false);
			return false;
		}
	}
	else if(args->GetType(0) == VTYPE_STRING){ //By handle value
		if(args->GetType(1) == VTYPE_INT){ timeout = args->GetInt(1); }
		if(!DKHandles::Instance("DKHandles")->SetHandle(args->GetString(0), timeout)){
			retval->SetBool(0, false);
			return false;
		}
	}
	retval->SetBool(0, true);
	return true;
}

//////////////////////////////////////////////////////////
bool DKHandlesV8::SetValue(CefArgs args, CefReturn retval)
{
	DKString value = args->GetString(0);
	if(!DKHandles::Instance("DKHandles")->SetString(value)){
		retval->SetBool(0, false);
		return false;
	}
	retval->SetBool(0, true);
	return true;
}

/////////////////////////////////////////////////////////////////
bool DKHandlesV8::SetWindowHandle(CefArgs args, CefReturn retval)
{
	int timeout = 1;
	if(args->GetType(1) == VTYPE_INT){ timeout = args->GetInt(1); }
	if(!DKHandles::Instance("DKHandles")->SetWindowHandle(args->GetString(0), timeout)){
		retval->SetBool(0, false);
		return false;
	}
	retval->SetBool(0, true);
	return true;
}

////////////////////////////////////////////////////////////
bool DKHandlesV8::ShowWindow(CefArgs args, CefReturn retval)
{
	if(!DKHandles::Instance("DKHandles")->ShowWindow(args->GetInt(0))){
		retval->SetBool(0, false);
		return false;
	}
	retval->SetBool(0, true);
	return true;
}

/////////////////////////////////////////////////////////////////
bool DKHandlesV8::ToggleHighlight(CefArgs args, CefReturn retval)
{
	DKHandles::Instance("DKHandles")->ToggleHighlight();
	return true;
}

///////////////////////////////////////////////////////////////
bool DKHandlesV8::WaitForHandle(CefArgs args, CefReturn retval)
{
	if(args->GetType(0) == VTYPE_INT){ //By handle number
		if(!DKHandles::Instance("DKHandles")->WaitForHandle(args->GetInt(0), args->GetInt(1))){
			retval->SetBool(0, false);
			return false;
		}
	}
	else if(args->GetType(0) == VTYPE_STRING && args->GetType(1) == VTYPE_STRING){ //By handle class, value
		if(!DKHandles::Instance("DKHandles")->WaitForHandle(args->GetString(0), args->GetString(1), args->GetInt(2))){
			retval->SetBool(0, false);
			return false;
		}
	}
	else if(args->GetType(0) == VTYPE_STRING){ //By handle value
		if(!DKHandles::Instance("DKHandles")->WaitForHandle(args->GetString(0), args->GetInt(1))){
			retval->SetBool(0, false);
			return false;
		}
	}
	retval->SetBool(0, true);
	return true;
}

///////////////////////////////////////////////////////////////
bool DKHandlesV8::WaitForWindow(CefArgs args, CefReturn retval)
{
	DKString window = args->GetString(0);
	int timeout = args->GetInt(1);
	if(!DKHandles::Instance("DKHandles")->WaitForWindow(window, timeout)){
		retval->SetBool(0, false);
		return false;
	}
	retval->SetBool(0, true);
	return true;
}

//////////////////////////////////////////////////////////////
bool DKHandlesV8::WindowExists(CefArgs args, CefReturn retval)
{
	DKString window = args->GetString(0);
	if(!DKHandles::Instance("DKHandles")->WindowExists(window)){
		retval->SetBool(0, false);
		return false;
	}
	retval->SetBool(0, true);
	return true;
}

#endif //USE_DKCef