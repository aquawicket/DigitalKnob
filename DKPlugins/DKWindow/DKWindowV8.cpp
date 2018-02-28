#ifdef USE_DKCef
#include "DK/DKApp.h"
#include "DKWindow/DKWindow.h"
#include "DKWindow/DKWindowV8.h"

///////////////////////
bool DKWindowV8::Init()
{
	DKLog("DKWindowV8::Init()\n", DKDEBUG);

	DKV8::AttachFunction("DKWindow_TestInt", DKWindowV8::TestInt);
	DKV8::AttachFunction("DKWindow_TestString", DKWindowV8::TestString);
	DKV8::AttachFunction("DKWindow_TestReturnInt", DKWindowV8::TestReturnInt);
	DKV8::AttachFunction("DKWindow_TestReturnString", DKWindowV8::TestReturnString);

	DKV8::AttachFunction("DKWindow_GetPixelRatio", DKWindowV8::GetPixelRatio);
	DKV8::AttachFunction("DKWindow_SetIcon", DKWindowV8::SetIcon);
	DKV8::AttachFunction("DKWindow_SetTitle", DKWindowV8::SetTitle);
	DKV8::AttachFunction("DKWindow_GetHeight", DKWindowV8::GetHeight);
	DKV8::AttachFunction("DKWindow_GetWidth", DKWindowV8::GetWidth);
	DKV8::AttachFunction("DKWindow_SetHeight", DKWindowV8::SetHeight);
	DKV8::AttachFunction("DKWindow_SetWidth", DKWindowV8::SetWidth);
	return true;
}

//////////////////////
bool DKWindowV8::End()
{
	DKLog("DKWindowV8::End()\n", DKDEBUG);
	return true;
}


////////////////////////////////////////////////////////
bool DKWindowV8::TestInt(CefArgs args, CefReturn retval)
{
	DKLog("DKWindowV8::TestInt(CefArgs,CefReturn)\n", DKINFO);

	int data = args->GetInt(0);
	int result = data;
	if(!retval->SetInt(0, result)){ return false; }
	return true;
}

///////////////////////////////////////////////////////////
bool DKWindowV8::TestString(CefArgs args, CefReturn retval)
{
	DKLog("DKWindowV8::TestString(CefArgs,CefReturn)\n", DKINFO);

	DKString data = args->GetString(0);
	DKString result = data;
	if(!retval->SetString(0, result)){ return false; }
	return true;
}

//////////////////////////////////////////////////////////////
bool DKWindowV8::TestReturnInt(CefArgs args, CefReturn retval)
{
	DKLog("DKWindowV8::TestReturnInt(CefArgs,CefReturn)\n", DKINFO);

	int result = 12345;
	if(!retval->SetInt(0, result)){ return false; }
	return true;
}

/////////////////////////////////////////////////////////////////
bool DKWindowV8::TestReturnString(CefArgs args, CefReturn retval)
{
	DKLog("DKWindowV8::TestReturnString(CefArgs,CefReturn)\n", DKINFO);

	DKString result = "test string";
	if(!retval->SetString(0, result)){ return false; }
	return true;
}

//////////////////////////////////////////////////////////////
bool DKWindowV8::GetPixelRatio(CefArgs args, CefReturn retval)
{
	float ratio;
	if(!DKWindow::GetPixelRatio(ratio)){ return false; }
	if(!retval->SetDouble(0, ratio)){ return false; }
	return true;
}

////////////////////////////////////////////////////////
bool DKWindowV8::SetIcon(CefArgs args, CefReturn retval)
{
	DKLog("DKWindowV8::SetIcon(CefArgs,CefReturn)\n", DKINFO);

	DKString file = args->GetString(0);
	if(!DKWindow::SetIcon(file)) { return false; }
	return true;
}

/////////////////////////////////////////////////////////
bool DKWindowV8::SetTitle(CefArgs args, CefReturn retval)
{
	DKLog("DKWindowV8::SetTitle(CefArgs,CefReturn)\n", DKINFO);

	DKString string = args->GetString(0);
	if (!DKWindow::SetTitle(string)) { return false; }
	return true;
}

//////////////////////////////////////////////////////////
bool DKWindowV8::GetHeight(CefArgs args, CefReturn retval)
{
	int height;
	if(!DKWindow::GetHeight(height)){
		DKLog("DKWindowV8::GetHeight(): DKWindow::GetHeight() failed\n", DKWARN);
		return false; 
	}
	if(!retval->SetInt(0, height)){
		DKLog("DKWindowV8::GetHeight(): retval->SetInt() failed\n", DKWARN);
		return false; 
	}
	return true;
}

/////////////////////////////////////////////////////////
bool DKWindowV8::GetWidth(CefArgs args, CefReturn retval)
{
	int width;
	if(!DKWindow::GetWidth(width)){
		DKLog("DKWindowV8::GetWidth(): DKWindow::GetWidth() failed\n", DKWARN);
		return false; 
	}
	if(!retval->SetInt(0, width)){
		DKLog("DKWindowV8::GetWidth(): retval->SetInt() failed\n", DKWARN);
		return false; 
	}
	return true;
}

//////////////////////////////////////////////////////////
bool DKWindowV8::SetHeight(CefArgs args, CefReturn retval)
{
	int height = args->GetInt(0);
	DKWindow::SetHeight(height);
	return 1;
}

/////////////////////////////////////////////////////////
bool DKWindowV8::SetWidth(CefArgs args, CefReturn retval)
{
	int width = args->GetInt(0);
	DKWindow::SetWidth(width);
	return 1;
}

#endif //USE_DKCef