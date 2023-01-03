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

#ifdef HAVE_DKDuktape 
#include "DKTray/DKTray.h"
#include "DKTray/DKTrayJS.h"


bool DKTrayJS::Init(){
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("CPP_DKTray_AddItem", DKTrayJS::AddItem);
	DKDuktape::AttachFunction("CPP_DKTray_GetIcon", DKTrayJS::GetIcon);
	DKDuktape::AttachFunction("CPP_DKTray_SetIcon", DKTrayJS::SetIcon);
	DKDuktape::AttachFunction("CPP_DKTray_SetTooltip", DKTrayJS::SetTooltip);
	DKDuktape::AttachFunction("CPP_DKTray_ShowBalloon", DKTrayJS::ShowBalloon);
	return true;
}

int DKTrayJS::AddItem(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString name = duk_require_string(ctx, 0);
	int id = duk_require_int(ctx, 1);
	if(!DKTray::Get()->AddItem(name, id))
		return DKERROR("DKTray::Get()->AddItem() failed! \n");
	return true;
}

int DKTrayJS::GetIcon(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString icon;
	if(!DKTray::Get()->GetIcon(icon))
		return DKERROR("DKTray::Get()->GetIcon() failed! \n");
	duk_push_string(ctx, icon.c_str());
	return true;
}

int DKTrayJS::SetIcon(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString file = duk_require_string(ctx, 0);
	if(!DKTray::Get()->SetIcon(file))
		return DKERROR("DKTray::Get()->SetIcon() failed! \n");
	return true;
}

int DKTrayJS::SetTooltip(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString name = duk_require_string(ctx, 0);
	if(!DKTray::Get()->SetTooltip(name))
		return DKERROR("DKTray::Get()->SetTooltip() failed! \n");
	return true;
}

int DKTrayJS::ShowBalloon(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString string = duk_require_string(ctx, 0);
	//int seconds = duk_require_int(ctx, 1);
	if(!DKTray::Get()->ShowBalloon(string/*, seconds*/))
		return DKERROR("DKTray::Get()->ShowBaloon() failed! \n");
	return true;
}


#endif //HAVE_DKDuktape
