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
#ifdef HAVE_DKDuktape 
#include "DKWebSockets/DKWebSockets.h"
#include "DKWebSockets/DKWebSocketsJS.h"


bool DKWebSocketsJS::Init(){
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("CPP_DKWebSockets_CloseClient", DKWebSocketsJS::CloseClient);
	DKDuktape::AttachFunction("CPP_DKWebSockets_CloseServer", DKWebSocketsJS::CloseServer);
	DKDuktape::AttachFunction("CPP_DKWebSockets_CreateClient", DKWebSocketsJS::CreateClient);
	DKDuktape::AttachFunction("CPP_DKWebSockets_CreateServer", DKWebSocketsJS::CreateServer);
	DKDuktape::AttachFunction("CPP_DKWebSockets_MessageToClient", DKWebSocketsJS::MessageToClient);
	DKDuktape::AttachFunction("CPP_DKWebSockets_MessageToServer", DKWebSocketsJS::MessageToServer);
	return true;
}

int DKWebSocketsJS::CloseClient(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	if(!DKWebSockets::CloseClient())
		return DKERROR("DKWebSockets::CloseClient() failed! \n");
	return true;
}

int DKWebSocketsJS::CloseServer(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	if(!DKWebSockets::CloseServer())
		return DKERROR("DKWebSockets::CloseServer() failed! \n");
	return true;
}

int DKWebSocketsJS::CreateClient(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	if(!DKWebSockets::CreateClient(address))
		return DKERROR("DKWebSockets::CreateClient() failed! \n");
	return true;
}

int DKWebSocketsJS::CreateServer(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString address = duk_require_string(ctx, 0);
	int port = duk_require_int(ctx, 1);
	if(!DKWebSockets::CreateServer(address, port))
		return DKERROR("DKWebSockets::CreateServer() failed! \n");
	return true;
}

int DKWebSocketsJS::MessageToClient(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString text = duk_require_string(ctx, 0);
	if(!DKWebSockets::MessageToClient(text))
		return DKERROR("DKWebSockets::MessageToClient() failed! \n");
	return true;
}

int DKWebSocketsJS::MessageToServer(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString text = duk_require_string(ctx, 0);
	if(!DKWebSockets::MessageToServer(text))
		return DKERROR("DKWebSockets::MessageToServer() failed! \n");
	return true;
}


#endif //HAVE_DKDuktape
