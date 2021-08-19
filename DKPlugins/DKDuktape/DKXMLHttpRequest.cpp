#ifdef USE_DKDuktape 
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

#endif //USE_DKDuktape