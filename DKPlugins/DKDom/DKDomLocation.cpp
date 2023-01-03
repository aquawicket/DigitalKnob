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

//https://developer.mozilla.org/en-US/docs/Web/API/Location

#include "DK/DKApp.h"
#include "DKDom/DKDom.h"
#include "DKDom/DKDomLocation.h"


bool DKDomLocation::Init(){
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("CPP_DKDomLocation_hash", DKDomLocation::hash);
	DKDuktape::AttachFunction("CPP_DKDomLocation_host", DKDomLocation::host);
	DKDuktape::AttachFunction("CPP_DKDomLocation_hostname", DKDomLocation::hostname);
	DKDuktape::AttachFunction("CPP_DKDomLocation_href", DKDomLocation::href);
	DKDuktape::AttachFunction("CPP_DKDomLocation_origin", DKDomLocation::origin);
	DKDuktape::AttachFunction("CPP_DKDomLocation_password", DKDomLocation::password);
	DKDuktape::AttachFunction("CPP_DKDomLocation_pathname", DKDomLocation::pathname);
	DKDuktape::AttachFunction("CPP_DKDomLocation_port", DKDomLocation::port);
	DKDuktape::AttachFunction("CPP_DKDomLocation_protocol", DKDomLocation::protocol);
	DKDuktape::AttachFunction("CPP_DKDomLocation_search", DKDomLocation::search);
	DKDuktape::AttachFunction("CPP_DKDomLocation_username", DKDomLocation::username);
	DKClass::DKCreate("DKDom/DKDomLocation.js");
	return true;
}

int DKDomLocation::hash(duk_context* ctx){
	std::string::size_type found = DKRml::Get()->href.find("#");
	std::string::size_type length = DKRml::Get()->href.length();
	DKString hash;
	if(found > 0 && found < length)
		hash = DKRml::Get()->href.substr(found);
	duk_push_string(ctx, hash.c_str());
	return true;
}

int DKDomLocation::host(duk_context* ctx){
	DKString host = "TODO";
	duk_push_string(ctx, host.c_str());
	return true;
}

int DKDomLocation::hostname(duk_context* ctx){
	DKString hostname = DKRml::Get()->href;
	//TODO
	// 127.0.0.1 is the hostname of http://127.0.0.1/Test/file.html
	std::string::size_type found = hostname.find("//");
	if(found != std::string::npos)
		hostname.erase(0, found);
	hostname = "not implemented";
	duk_push_string(ctx, hostname.c_str());
	return true;
}

int DKDomLocation::href(duk_context* ctx){
	if(duk_is_string(ctx, 0)){
		DKString url = duk_get_string(ctx, 0);
		DKRml::Get()->LoadUrl(url);
	}
	duk_push_string(ctx, DKRml::Get()->href.c_str());
	return true;
}

int DKDomLocation::origin(duk_context* ctx){
	DKString origin = "TODO";
	duk_push_string(ctx, origin.c_str());
	return true;
}

int DKDomLocation::password(duk_context* ctx){
	DKString password = "TODO";
	duk_push_string(ctx, password.c_str());
	return true;
}

int DKDomLocation::pathname(duk_context* ctx){
	DKString pathname = "TODO";
	duk_push_string(ctx, pathname.c_str());
	return true;
}

int DKDomLocation::port(duk_context* ctx){
	DKString port = "TODO";
	duk_push_string(ctx, port.c_str());
	return true;
}

int DKDomLocation::protocol(duk_context* ctx){
	DKString protocol = "TODO";
	duk_push_string(ctx, protocol.c_str());
	return true;
}

int DKDomLocation::search(duk_context* ctx){
	DKString search = "TODO";
	duk_push_string(ctx, search.c_str());
	return true;
}

int DKDomLocation::username(duk_context* ctx){
	DKString username = "TODO";
	duk_push_string(ctx, username.c_str());
	return true;
}
