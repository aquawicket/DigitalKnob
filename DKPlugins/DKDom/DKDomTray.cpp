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

#include "DK/DKApp.h"
#include "DKDom/DKDom.h"
#include "DKDom/DKDomTray.h"


bool DKDomTray::Init(){
	DKDEBUGFUNC();
	
	//// Instance properties ////
	DKDuktape::AttachFunction("CPP_DKDomTray_binaryType", DKDomTray::binaryType);
	DKDuktape::AttachFunction("CPP_DKDomTray_bufferedAmount", DKDomTray::bufferedAmount);
	DKDuktape::AttachFunction("CPP_DKDomTray_extensions", DKDomTray::extensions);
	DKDuktape::AttachFunction("CPP_DKDomTray_protocol", DKDomTray::protocol);
	DKDuktape::AttachFunction("CPP_DKDomTray_readyState", DKDomTray::readyState);
	DKDuktape::AttachFunction("CPP_DKDomTray_url", DKDomTray::url);
	
	//// Instance methods ////
	DKDuktape::AttachFunction("CPP_DKDomTray_open", DKDomTray::open);
	DKDuktape::AttachFunction("CPP_DKDomTray_close", DKDomTray::close);
	DKDuktape::AttachFunction("CPP_DKDomTray_send", DKDomTray::send);
	
	DKClass::DKCreate("DKDom/DKDomTray.js");
	return true;
}

int DKDomTray::binaryType(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return true;
}

int DKDomTray::bufferedAmount(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return true;
}

int DKDomTray::extensions(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return true;
}

int DKDomTray::protocol(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return true;
}

int DKDomTray::readyState(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return true;
}

int DKDomTray::url(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return true;
}

int DKDomTray::open(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	if (!DKTray::Get()->CreateClient(address)) //uwebsocket
		return DKERROR("DKTray::CreateClient() failed! \n");
	return true;
}

int DKDomTray::close(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	if (!DKUTraysClient::Get()->CloseClient()) //uwebsocket
		return DKERROR("Tray::CloseClient() failed! \n");
	return true;
}

int DKDomTray::send(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString message = duk_require_string(ctx, 0);
	if (!DKTray::Get()->MessageToServer(message))
		return DKERROR("DKTray::MessageToServer() failed! \n");
	return true;
}
