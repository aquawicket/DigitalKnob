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
#include "DK/DKApp.h"
#include "DKDuktape/DKXMLHttpRequest.h"
#include "DK/DKFile.h"


bool DKXMLHttpRequest::Init(){
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("CPP_DKXMLHttpRequest_send", DKXMLHttpRequest::send);
	
	DKClass::DKCreate("DKDuktape/DKXMLHttpRequest.js");
	return true;
}

int DKXMLHttpRequest::send(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//void* object = duk_require_pointer(ctx, 0);
	DKString method = duk_require_string(ctx, 0);
	DKString url = duk_require_string(ctx, 1);
	bool async = duk_require_boolean(ctx, 2);
	//DKString user; //TODO
	//DKString password; //TODO
	DKWARN("DKRmlJS::send("+method+","+url+","+toString(async)+")\n");
	if(has(url,"http://") || has(url,"https://")){
		DKERROR("DKRmlJS::send(): http/https not implemented yet\n");
		return true;
	}

	DKString response;
	DKFile::FileToString(url, response);

	//TODO - return JSON data
	duk_push_string(ctx, response.c_str());
	return true;
}

#endif //HAVE_DKDuktape