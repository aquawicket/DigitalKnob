// https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest

#include "DK/DKApp.h"
#include "DK/DKFile.h"
#include "DKDom/DKDomXMLHttpRequest.h"

bool DKDomXMLHttpRequest::Init(){
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("CPP_DKDomXMLHttpRequest_send", DKDomXMLHttpRequest::send);
	
	DKClass::DKCreate("DKDom/DKDomXMLHttpRequest.js");
	return true;
}

int DKDomXMLHttpRequest::send(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	//void* object = duk_require_pointer(ctx, 0);
	DKString method = duk_require_string(ctx, 0);
	DKString url = duk_require_string(ctx, 1);
	bool async = duk_require_boolean(ctx, 2);
	//DKString user; //TODO
	//DKString password; //TODO
	//DKWARN("DKDomXMLHttpRequest::send("+method+","+url+","+toString(async)+")\n");
	if(has(url,"http://") || has(url,"https://") || has(url, "file://")){
		DKERROR("DKDomXMLHttpRequest::send(): http/https/file not implemented yet\n");
		return true;
	}

	DKString response;
	DKFile::FileToString(url, response);

	//TODO - return JSON data
	duk_push_string(ctx, response.c_str());
	return true;
}