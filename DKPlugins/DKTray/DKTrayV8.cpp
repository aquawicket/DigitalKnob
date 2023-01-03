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
* The above copyright noticeand this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/
#ifdef HAVE_DKCef
#include "DK/DKApp.h"
#include "DKTray/DKTray.h"
#include "DKTray/DKTrayV8.h"


bool DKTrayV8::Init(){
	DKDEBUGFUNC();
	DKV8::AttachFunction("DKTray_AddItem", DKTrayV8::AddItem);
	DKV8::AttachFunction("DKTray_GetIcon", DKTrayV8::GetIcon);
	DKV8::AttachFunction("DKTray_SetIcon", DKTrayV8::SetIcon);
	DKV8::AttachFunction("DKTray_SetTooltip", DKTrayV8::SetTooltip);
	DKV8::AttachFunction("DKTray_ShowBalloon", DKTrayV8::ShowBalloon);
	return true;
}

bool DKTrayV8::End(){
	DKDEBUGFUNC();
	return true;
}

bool DKTrayV8::AddItem(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	DKString name = args->GetString(0);
	int id = args->GetInt(1);
	if(!DKTray::Get()->AddItem(name, id))
		return DKERROR("DKTray::Get()->AddItem() failed! \n");
	return true;
}

bool DKTrayV8::GetIcon(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	DKString icon;
	if(!DKTray::Get()->GetIcon(icon))
		return DKERROR("DKTray::Get()->GetIcon() failed! \n");
	if(!retval->SetString(0, icon))
		return DKERROR("retval->SetString() failed! \n");
	return true;
}

bool DKTrayV8::SetIcon(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	DKString file = args->GetString(0);
	if(!DKTray::Get()->SetIcon(file))
		return DKERROR("DKTray::Get()->SetIcon() failed! \n");
	return true;
}

bool DKTrayV8::SetTooltip(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	DKString name = args->GetString(0);
	if(!DKTray::Get()->SetTooltip(name))
		return DKERROR("DKTray::Get()->SetTooltip() failed! \n");
	return true;
}

bool DKTrayV8::ShowBalloon(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	DKString string = args->GetString(0);
	//int seconds = duk_require_int(ctx, 1);
	if(!DKTray::Get()->ShowBalloon(string/*, seconds*/))
		return DKERROR("DKTray::Get()->SetBaloon() failed! \n");
	return true;
}

#endif //HAVE_DKCef
