#ifdef USE_DKCef
#include "DKHandlesV8.h"
#include "DKHandles.h"

////////////////////////
bool DKHandlesV8::Init()
{
	DKLog("DKHandlesV8::Init()\n", DKDEBUG);
	
	DKV8::AttachFunction("DKHandles_Click", DKHandlesV8::Click);
	DKV8::AttachFunction("DKHandles_CurrentHandle", DKHandlesV8::CurrentHandle);
	DKV8::AttachFunction("DKHandles_GetBottom", DKHandlesV8::GetBottom);
	DKV8::AttachFunction("DKHandles_GetClass", DKHandlesV8::GetClass);
	DKV8::AttachFunction("DKHandles_GetIndex", DKHandlesV8::GetIndex);
	DKV8::AttachFunction("DKHandles_GetLeft", DKHandlesV8::GetLeft);
	DKV8::AttachFunction("DKHandles_GetParent", DKHandlesV8::GetParent);
	DKV8::AttachFunction("DKHandles_GetRight", DKHandlesV8::GetRight);
	DKV8::AttachFunction("DKHandles_GetTop", DKHandlesV8::GetTop);
	DKV8::AttachFunction("DKHandles_GetValue", DKHandlesV8::GetValue);
	DKV8::AttachFunction("DKHandles_GetWindow", DKHandlesV8::GetWindow);
	DKV8::AttachFunction("DKHandles_GetWindowIndex", DKHandlesV8::GetWindowIndex);
	DKV8::AttachFunction("DKHandles_GetWindows", DKHandlesV8::GetWindows);
	DKV8::AttachFunction("DKHandles_NextHandle", DKHandlesV8::NextHandle);
	DKV8::AttachFunction("DKHandles_PrevHandle", DKHandlesV8::PrevHandle);
	//DKV8::AttachFunction("DKHandles_SendHook", DKHandlesV8::SendHook);
	DKV8::AttachFunction("DKHandles_SetHandle", DKHandlesV8::SetHandle);
	DKV8::AttachFunction("DKHandles_SetValue", DKHandlesV8::SetValue);
	DKV8::AttachFunction("DKHandles_SetWindowHandle", DKHandlesV8::SetWindowHandle);
	DKV8::AttachFunction("DKHandles_ShowWindow", DKHandlesV8::ShowWindow);
	DKV8::AttachFunction("DKHandles_StartSearch", DKHandlesV8::StartSearch);
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
	DKString handle = args->GetString(0);
	if(!DKHandles::Click(toHWND(handle))){
		retval->SetBool(0, false);
		return false;
	}
	retval->SetBool(0, true);
	return true;
}

///////////////////////////////////////////////////////////////
bool DKHandlesV8::CurrentHandle(CefArgs args, CefReturn retval)
{
	if(!DKHandles::currentHandle){
		retval->SetBool(0, false);
		return false;
	}
	retval->SetString(0, toString(DKHandles::currentHandle));
	return true;
}

///////////////////////////////////////////////////////////
bool DKHandlesV8::GetBottom(CefArgs args, CefReturn retval)
{
	DKString handle = args->GetString(0);
	int bottom;
	if(!DKHandles::GetBottom(toHWND(handle), bottom)){
		retval->SetBool(0, false);
		return false;
	}
	retval->SetInt(0, bottom);
	return true;
}

//////////////////////////////////////////////////////////
bool DKHandlesV8::GetClass(CefArgs args, CefReturn retval)
{
	DKString handle = args->GetString(0);
	DKString clas;
	if(!DKHandles::GetClass(toHWND(handle), clas)){
		retval->SetBool(0, false);
		return false;
	}
	retval->SetString(0, clas);
	return true;
}

//////////////////////////////////////////////////////////
bool DKHandlesV8::GetIndex(CefArgs args, CefReturn retval)
{
	DKString handle = args->GetString(0);
	int index;
	if(!DKHandles::GetIndex(toHWND(handle), index)){
		retval->SetBool(0, false);
		return false;
	}
	retval->SetInt(0, index);
	return true;
}

/////////////////////////////////////////////////////////
bool DKHandlesV8::GetLeft(CefArgs args, CefReturn retval)
{
	DKString handle = args->GetString(0);
	int left;
	if(!DKHandles::GetLeft(toHWND(handle), left)){
		retval->SetBool(0, false);
		return false;
	}
	retval->SetInt(0, left);
	return true;
}

///////////////////////////////////////////////////////////
bool DKHandlesV8::GetParent(CefArgs args, CefReturn retval)
{
	DKString handle = args->GetString(0);
	DKString parent;
	if(!DKHandles::GetParent(toHWND(handle), parent)){
		retval->SetBool(0, false);
		return false;
	}
	retval->SetString(0, parent);
	return true;
}

//////////////////////////////////////////////////////////
bool DKHandlesV8::GetRight(CefArgs args, CefReturn retval)
{
	DKString handle = args->GetString(0);
	int right;
	if(!DKHandles::GetRight(toHWND(handle), right)){
		retval->SetBool(0, false);
		return false;
	}
	retval->SetInt(0, right);
	return true;
}

////////////////////////////////////////////////////////
bool DKHandlesV8::GetTop(CefArgs args, CefReturn retval)
{
	DKString handle = args->GetString(0);
	int top;
	if(!DKHandles::GetTop(toHWND(handle), top)){
		retval->SetBool(0, false);
		return false;
	}
	retval->SetInt(0, top);
	return true;
}

//////////////////////////////////////////////////////////
bool DKHandlesV8::GetValue(CefArgs args, CefReturn retval)
{
	DKString handle = args->GetString(0);
	DKString value;
	if(!DKHandles::GetString(toHWND(handle), value)){
		retval->SetBool(0, false);
		return false;
	}
	retval->SetString(0, value);
	return true;
}

///////////////////////////////////////////////////////////
bool DKHandlesV8::GetWindow(CefArgs args, CefReturn retval)
{
	DKString handle = args->GetString(0);
	HWND window;
	if(!DKHandles::GetWindow(toHWND(handle), window)){
		retval->SetBool(0, false);
		return false;
	}
	retval->SetString(0, toString(window));
	return true;
}

////////////////////////////////////////////////////////////////
bool DKHandlesV8::GetWindowIndex(CefArgs args, CefReturn retval)
{
	DKString handle = args->GetString(0);
	int index;
	if(!DKHandles::GetWindowIndex(toHWND(handle), index)){
		retval->SetBool(0, false);
		return false;
	}
	retval->SetInt(0, index);
	return true;
}

////////////////////////////////////////////////////////////
bool DKHandlesV8::GetWindows(CefArgs args, CefReturn retval)
{
	DKStringArray windows;
	if(!DKHandles::GetWindows(windows)){
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
	DKString handle = args->GetString(0);
	HWND next;
	if(!DKHandles::NextHandle(toHWND(handle), next)){
		retval->SetBool(0, false);
		return false;
	}
	retval->SetString(0, toString(next));
	return true;
}

////////////////////////////////////////////////////////////
bool DKHandlesV8::PrevHandle(CefArgs args, CefReturn retval)
{
	DKString handle = args->GetString(0);
	HWND prev;
	if(!DKHandles::PrevHandle(toHWND(handle), prev)){
		retval->SetBool(0, false);
		return false;
	}
	retval->SetString(0, toString(prev));
	return true;
}

/*
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
*/

///////////////////////////////////////////////////////////
bool DKHandlesV8::SetHandle(CefArgs args, CefReturn retval)
{
	int timeout = 1;
	if(args->GetType(0) == VTYPE_INT){ //By number
		if(args->GetType(1) == VTYPE_INT){ timeout = args->GetInt(1); }
		if(!DKHandles::SetHandle(args->GetInt(0), timeout)){
			retval->SetBool(0, false);
			return false;
		}
	}
	else if(args->GetType(0) == VTYPE_STRING && args->GetType(1) == VTYPE_STRING){ //By class, value
		if(args->GetType(2) == VTYPE_INT){ timeout = args->GetInt(2); }
		if(!DKHandles::SetHandle(args->GetString(0), args->GetString(1), timeout)){
			retval->SetBool(0, false);
			return false;
		}
	}
	else if(args->GetType(0) == VTYPE_STRING){ //By value
		if(args->GetType(1) == VTYPE_INT){ timeout = args->GetInt(1); }
		if(!DKHandles::SetHandle(args->GetString(0), timeout)){
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
	DKString handle = args->GetString(0);
	DKString value = args->GetString(1);
	if(!DKHandles::SetString(toHWND(handle), value)){
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
	HWND hwnd;
	if(args->GetType(1) == VTYPE_INT){ timeout = args->GetInt(1); }
	if(!DKHandles::SetWindowHandle(args->GetString(0), timeout, hwnd)){
		retval->SetBool(0, false);
		return false;
	}
	std::stringstream ss;
	ss << "0x" << hwnd;
	DKString sval = ss.str();
	DKLog("DKHandlesV8::SetWindowHandle() = "+sval+"\n");
	retval->SetString(0, sval);
	return true;
}

////////////////////////////////////////////////////////////
bool DKHandlesV8::ShowWindow(CefArgs args, CefReturn retval)
{
	DKString handle = args->GetString(0);
	bool flag = args->GetBool(1);
	if(!DKHandles::ShowWindow(toHWND(handle), flag)){
		retval->SetBool(0, false);
		return false;
	}
	retval->SetBool(0, true);
	return true;
}

/////////////////////////////////////////////////////////////
bool DKHandlesV8::StartSearch(CefArgs args, CefReturn retval)
{
	if(!DKHandles::StartSearch()){
		retval->SetBool(0, false);
		return false;
	}
	retval->SetBool(0, true);
	return true;
}

/////////////////////////////////////////////////////////////////
bool DKHandlesV8::ToggleHighlight(CefArgs args, CefReturn retval)
{
	DKHandles::ToggleHighlight();
	return true;
}

///////////////////////////////////////////////////////////////
bool DKHandlesV8::WaitForHandle(CefArgs args, CefReturn retval)
{
	if(args->GetType(0) == VTYPE_INT){ //By handle number
		if(!DKHandles::WaitForHandle(args->GetInt(0), args->GetInt(1))){
			retval->SetBool(0, false);
			return false;
		}
	}
	else if(args->GetType(0) == VTYPE_STRING && args->GetType(1) == VTYPE_STRING){ //By handle class, value
		if(!DKHandles::WaitForHandle(args->GetString(0), args->GetString(1), args->GetInt(2))){
			retval->SetBool(0, false);
			return false;
		}
	}
	else if(args->GetType(0) == VTYPE_STRING){ //By handle value
		if(!DKHandles::WaitForHandle(args->GetString(0), args->GetInt(1))){
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
	if(!DKHandles::WaitForWindow(window, timeout)){
		retval->SetBool(0, false);
		return true;
	}
	retval->SetBool(0, true);
	return true;
}

//////////////////////////////////////////////////////////////
bool DKHandlesV8::WindowExists(CefArgs args, CefReturn retval)
{
	DKString window = args->GetString(0);
	if(!DKHandles::WindowExists(window)){
		retval->SetBool(0, false);
		return false;
	}
	retval->SetBool(0, true);
	return true;
}

#endif //USE_DKCef