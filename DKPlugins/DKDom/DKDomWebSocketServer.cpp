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
#include "DKDom/DKDomWebSocketServer.h"


bool DKDomWebSocketServer::Init(){
	DKDEBUGFUNC();
	
	//// Instance properties ////
	DKDuktape::AttachFunction("CPP_DKDomWebSocketServer_isConnected", DKDomWebSocketServer::isConnected);
	
	//// Instance methods ////
	DKDuktape::AttachFunction("CPP_DKDomWebSocketServer_disconnect", DKDomWebSocketServer::disconnect);
	DKDuktape::AttachFunction("CPP_DKDomWebSocketServer_send", DKDomWebSocketServer::send);
	DKDuktape::AttachFunction("CPP_DKDomWebSocketServer_start", DKDomWebSocketServer::start);
	
	DKClass::DKCreate("DKDom/DKDomWebSocketServer.js");
	return true;
}

int DKDomWebSocketServer::isConnected(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return true;
}

int DKDomWebSocketServer::disconnect(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return true;
}

int DKDomWebSocketServer::send(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return true;
}

int DKDomWebSocketServer::start(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//TODO
	return true;
}
