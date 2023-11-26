/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files(the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions :
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

#if WIN
#if HAVE_DKDuktape 
#include "DKHandles/DKHandles.h"
#include "DKHandles/DKHandlesJS.h"


bool DKHandlesJS::Init(){
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("CPP_DKHandles_Click", DKHandlesJS::Click);
	DKDuktape::AttachFunction("CPP_DKHandles_CurrentHandle", DKHandlesJS::CurrentHandle);
	DKDuktape::AttachFunction("CPP_DKHandles_GetBottom", DKHandlesJS::GetBottom);
	DKDuktape::AttachFunction("CPP_DKHandles_GetClass", DKHandlesJS::GetClass);
	DKDuktape::AttachFunction("CPP_DKHandles_GetIndex", DKHandlesJS::GetIndex);
	DKDuktape::AttachFunction("CPP_DKHandles_GetLeft", DKHandlesJS::GetLeft);
	DKDuktape::AttachFunction("CPP_DKHandles_GetParent", DKHandlesJS::GetParent);
	DKDuktape::AttachFunction("CPP_DKHandles_GetRight", DKHandlesJS::GetRight);
	DKDuktape::AttachFunction("CPP_DKHandles_GetTop", DKHandlesJS::GetTop);
	DKDuktape::AttachFunction("CPP_DKHandles_GetValue", DKHandlesJS::GetValue);
	DKDuktape::AttachFunction("CPP_DKHandles_GetWindow", DKHandlesJS::GetWindow);
	DKDuktape::AttachFunction("CPP_DKHandles_GetWindowIndex", DKHandlesJS::GetWindowIndex);
	DKDuktape::AttachFunction("CPP_DKHandles_GetWindows", DKHandlesJS::GetWindows);
	DKDuktape::AttachFunction("CPP_DKHandles_NextHandle", DKHandlesJS::NextHandle);
	DKDuktape::AttachFunction("CPP_DKHandles_PrevHandle", DKHandlesJS::PrevHandle);
	//DKDuktape::AttachFunction("CPP_DKHandles_SendHook", DKHandlesJS::SendHook);
	DKDuktape::AttachFunction("CPP_DKHandles_SetHandle", DKHandlesJS::SetHandle);
	DKDuktape::AttachFunction("CPP_DKHandles_SetValue", DKHandlesJS::SetValue);
	DKDuktape::AttachFunction("CPP_DKHandles_SetWindowHandle", DKHandlesJS::SetWindowHandle);
	DKDuktape::AttachFunction("CPP_DKHandles_ShowWindow", DKHandlesJS::ShowWindow);
	DKDuktape::AttachFunction("CPP_DKHandles_StartSearch", DKHandlesJS::StartSearch);
	DKDuktape::AttachFunction("CPP_DKHandles_ToggleHighlight", DKHandlesJS::ToggleHighlight);
	DKDuktape::AttachFunction("CPP_DKHandles_WaitForHandle", DKHandlesJS::WaitForHandle);
	DKDuktape::AttachFunction("CPP_DKHandles_WaitForWindow", DKHandlesJS::WaitForWindow);
	DKDuktape::AttachFunction("CPP_DKHandles_WindowExists", DKHandlesJS::WindowExists);
	return true;
}

int DKHandlesJS::Click(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString handle = duk_require_string(ctx, 0);
	if(!DKHandles::Click(toHWND(handle))){
		return 0;
	}
	return 1;
}

int DKHandlesJS::CurrentHandle(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString handle = toString(DKHandles::currentHandle);
	duk_push_string(ctx, handle.c_str());
	return 1;
}

int DKHandlesJS::GetBottom(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString handle = duk_require_string(ctx, 0);
	int bottom;
	if(!DKHandles::GetBottom(toHWND(handle), bottom)){
		duk_push_boolean(ctx, false);
		return false;
	}
	duk_push_int(0, bottom);
	return true;
}

int DKHandlesJS::GetClass(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString handle = duk_require_string(ctx, 0);
	DKString clas;
	if(!DKHandles::GetClass(toHWND(handle), clas)){ return 0; }
	duk_push_string(ctx, clas.c_str());
	return 1;
}

int DKHandlesJS::GetIndex(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString handle = duk_require_string(ctx, 0);
	int index;
	if(!DKHandles::GetIndex(toHWND(handle), index)){ return 0; }
	duk_push_int(ctx, index);
	return 1;
}

int DKHandlesJS::GetLeft(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString handle = duk_require_string(ctx, 0);
	int left;
	if(!DKHandles::GetLeft(toHWND(handle), left)){
		duk_push_boolean(ctx, false);
		return false;
	}
	duk_push_int(0, left);
	return true;
}

int DKHandlesJS::GetParent(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString handle = duk_require_string(ctx, 0);
	DKString parent;
	if(!DKHandles::GetParent(toHWND(handle), parent)){
		duk_push_boolean(ctx, false);
		return false;
	}
	duk_push_string(ctx, parent.c_str());
	return true;
}

int DKHandlesJS::GetRight(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString handle = duk_require_string(ctx, 0);
	int right;
	if(!DKHandles::GetRight(toHWND(handle), right)){
		duk_push_boolean(ctx, false);
		return false;
	}
	duk_push_int(0, right);
	return true;
}

int DKHandlesJS::GetTop(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString handle = duk_require_string(ctx, 0);
	int top;
	if(!DKHandles::GetTop(toHWND(handle), top)){
		duk_push_boolean(ctx, false);
		return false;
	}
	duk_push_int(0, top);
	return true;
}

int DKHandlesJS::GetValue(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString handle = duk_require_string(ctx, 0);
	DKString value;
	if(!DKHandles::GetString(toHWND(handle), value)){ return 0; }
	duk_push_string(ctx, value.c_str());
	return 1;
}

int DKHandlesJS::GetWindow(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString handle = duk_require_string(ctx, 0);
	HWND window;
	if(!DKHandles::GetWindow(toHWND(handle), window)){
		duk_push_boolean(ctx, false);
		return 0;
	}
	duk_push_string(ctx, toString(window).c_str());
	return 1;
}

int DKHandlesJS::GetWindowIndex(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString handle = duk_require_string(ctx, 0);
	int index;
	if(!DKHandles::GetWindowIndex(toHWND(handle), index)){
		duk_push_boolean(ctx, false);
		return 0;
	}
	duk_push_int(ctx, index);
	return 1;
}

int DKHandlesJS::GetWindows(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKStringArray windows;
	if(!DKHandles::GetWindows(windows)){ return 0; }
	DKString list = toString(windows, ",");
	duk_push_string(ctx, list.c_str());
	return 1;
}

int DKHandlesJS::NextHandle(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString handle = duk_require_string(ctx, 0);
	HWND next;
	if(!DKHandles::NextHandle(toHWND(handle), next)){ return 0; }
	duk_push_string(ctx, toString(next).c_str());
	return 1;
}

int DKHandlesJS::PrevHandle(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString handle = duk_require_string(ctx, 0);
	HWND prev;
	if(!DKHandles::PrevHandle(toHWND(handle), prev)){ return 0;}
	duk_push_string(ctx, toString(prev).c_str());
	return 1;
}

/*
int DKHandlesJS::SendHook(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString window = duk_require_string(ctx, 0);
	DKString handle = duk_require_string(ctx, 1);
	DKString data = duk_require_string(ctx, 2);

	if(!DKHandles::Instance("DKHandles")->SendHook(window, handle, data)){
		return 0;
	}
	return 1;
}
*/

int DKHandlesJS::SetHandle(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	int timeout = 1;
	if(duk_is_number(ctx, 0)){ //By handle number
		if(duk_is_number(ctx, 1)){ timeout = duk_require_int(ctx, 1); }
		if(!DKHandles::SetHandle(duk_require_int(ctx, 0), timeout)){
			duk_push_boolean(ctx, false);
			return false;
		}
	}
	else if(duk_is_string(ctx, 0) && duk_is_string(ctx, 1)){ //By handle class, value
		if(duk_is_number(ctx, 2)){ timeout = duk_require_int(ctx, 2); }
		if(!DKHandles::SetHandle(duk_require_string(ctx, 0), duk_require_string(ctx, 1), timeout)){
			duk_push_boolean(ctx, false);
			return false;
		}
	}
	else if(duk_is_string(ctx, 0)){ //By handle value
		if(duk_is_number(ctx, 1)){ timeout = duk_require_int(ctx, 1); }
		if(!DKHandles::SetHandle(duk_require_string(ctx, 0), timeout)){
			duk_push_boolean(ctx, false);
			return false;
		}
	}
	duk_push_boolean(ctx, true);
	return 1;
}

int DKHandlesJS::SetValue(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString handle = duk_require_string(ctx, 0);
	DKString value = duk_require_string(ctx, 1);
	if(!DKHandles::SetString(toHWND(handle), value)){ return 0; }
	return 1;
}

int DKHandlesJS::SetWindowHandle(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString window = duk_require_string(ctx, 0);
	HWND hwnd;
	if(!DKHandles::SetWindowHandle(window, 1, hwnd)){ return 0; }
	std::stringstream ss;
	ss << "0x" << hwnd;
	DKString sval = ss.str();
	DKINFO("DKHandlesJS::SetWindowHandle() = "+ss.str()+"\n");
	duk_push_string(ctx, sval.c_str());
	return 1;
}

int DKHandlesJS::ShowWindow(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString handle = duk_require_string(ctx, 0);
	bool flag = duk_require_boolean(ctx, 1);
	if(!DKHandles::ShowWindow(toHWND(handle), flag)){
		duk_push_boolean(ctx, false);
		return 0;
	}
	duk_push_boolean(ctx, true);
	return 1;
}

int DKHandlesJS::StartSearch(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	if(!DKHandles::Instance("DKHandles")->StartSearch()){
		return 0;
	}
	return 1;
}

int DKHandlesJS::ToggleHighlight(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKHandles::Instance("DKHandles")->ToggleHighlight();
	return 1;
}

int DKHandlesJS::WaitForHandle(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	if(duk_is_number(ctx, 0)){ //By handle number
		if(!DKHandles::WaitForHandle(duk_require_int(ctx, 0), duk_require_int(ctx, 1))){
			duk_push_boolean(ctx, false);
			return false;
		}
	}
	else if(duk_is_string(ctx, 0) && duk_is_string(ctx, 1)){ //By handle class, value
		if(!DKHandles::WaitForHandle(duk_require_string(ctx, 0), duk_require_string(ctx, 1), duk_require_int(ctx, 2))){
			duk_push_boolean(ctx, false);
			return false;
		}
	}
	else if(duk_require_string(ctx, 0)){ //By handle value
		if(!DKHandles::WaitForHandle(duk_require_string(ctx, 0), duk_require_int(ctx, 1))){
			duk_push_boolean(ctx, false);
			return false;
		}
	}
	duk_push_boolean(ctx, true);
	return 1;
}

int DKHandlesJS::WaitForWindow(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString window = duk_require_string(ctx, 0);
	int timeout = duk_require_int(ctx, 1);
	if(!DKHandles::Instance("DKHandles")->WaitForWindow(window, timeout)){
		return 0;
	}
	duk_push_true(ctx);
	return 1;
}

int DKHandlesJS::WindowExists(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString window = duk_require_string(ctx, 0);
	if(!DKHandles::Instance("DKHandles")->WindowExists(window)){
		return 0;
	}
	duk_push_true(ctx);
	return 1;
}

#endif //HAVE_DKDuktape
#endif //WIN32
