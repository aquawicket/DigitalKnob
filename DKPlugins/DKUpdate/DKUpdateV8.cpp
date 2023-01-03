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
#include "DKUpdate/DKUpdate.h"
#include "DKUpdate/DKUpdateV8.h"


bool DKUpdateV8::Init(){
	DKDEBUGFUNC();
	DKV8::AttachFunction("DKUpdate_CheckForUpdate", DKUpdateV8::CheckForUpdate);
	DKV8::AttachFunction("DKUpdate_CreateUpdate", DKUpdateV8::CreateUpdate);
	DKV8::AttachFunction("DKUpdate_DoUpdate", DKUpdateV8::DoUpdate);
	DKV8::AttachFunction("DKUpdate_UpdatePlugin", DKUpdateV8::UpdatePlugin);
	return true;
}

bool DKUpdateV8::End(){
	DKDEBUGFUNC();
	return true;
}

bool DKUpdateV8::CheckForUpdate(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	if(!DKUpdate::CheckForUpdate())
		return DKERROR("DKUpdate::CheckForUpdate() failed! \n");
	return true;
}

bool DKUpdateV8::CreateUpdate(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	if(!DKUpdate::CreateUpdate())
		return DKERROR("DKUpdate::CreateUpdate() failed! \n");
	return true;
}

bool DKUpdateV8::DoUpdate(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	if(!DKUpdate::DoUpdate())
		return DKERROR("DKUpdate::DoUpdate() failed! \n");
	return true;
}

bool DKUpdateV8::UpdatePlugin(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	DKString url = args->GetString(0);
	if(!DKUpdate::UpdatePlugin(url))
		return DKERROR("DKUpdate::UpdatePlugin() failed! \n");
	return true;
}


#endif //HAVE_DKCef
