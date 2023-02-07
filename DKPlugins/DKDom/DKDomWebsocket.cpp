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

//https://developer.mozilla.org/en-US/docs/Web/API/WebSocket

#include "DK/DKApp.h"
#include "DKDom/DKDom.h"
#include "DKDom/DKDomWebSocket.h"
#include "DKWebSockets/DKWebSockets.h"


bool DKDomWebSocket::Init(){
	DKDEBUGFUNC();
	
	//// Instance properties ////
	DKDuktape::AttachFunction("CPP_DKDomWebSocket_binaryType", DKDomWebSocket::binaryType);
	DKDuktape::AttachFunction("CPP_DKDomWebSocket_bufferedAmount", DKDomWebSocket::bufferedAmount);
	DKDuktape::AttachFunction("CPP_DKDomWebSocket_extensions", DKDomWebSocket::extensions);
	DKDuktape::AttachFunction("CPP_DKDomWebSocket_protocol", DKDomWebSocket::protocol);
	DKDuktape::AttachFunction("CPP_DKDomWebSocket_readyState", DKDomWebSocket::readyState);
	DKDuktape::AttachFunction("CPP_DKDomWebSocket_url", DKDomWebSocket::url);
	
	//// Instance methods ////
	DKDuktape::AttachFunction("CPP_DKDomWebSocket_close", DKDomWebSocket::close);
	DKDuktape::AttachFunction("CPP_DKDomWebSocket_send", DKDomWebSocket::send);
	
	DKClass::DKCreate("DKDom/DKDomWebSocket.js");
	return true;
}

int DKDomWebSocket::binaryType(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return true;
}

int DKDomWebSocket::bufferedAmount(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return true;
}

int DKDomWebSocket::extensions(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return true;
}

int DKDomWebSocket::protocol(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return true;
}

int DKDomWebSocket::readyState(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return true;
}

int DKDomWebSocket::url(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return true;
}

int DKDomWebSocket::close(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	if (!DKWebSockets::Get()->CloseClient())
		return DKERROR("DKWebSockets::CloseClient() failed! \n");
	return true;
}

int DKDomWebSocket::send(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString message = duk_require_string(ctx, 0);
	if (!DKWebSockets::Get()->MessageToServer(message))
		return DKERROR("DKWebSockets::MessageToServer() failed! \n");
	return true;
}
