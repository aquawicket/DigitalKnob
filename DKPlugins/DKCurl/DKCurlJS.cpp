#ifdef HAVE_DKDuktape 
#include "DKCurl/DKCurl.h"
#include "DKCurl/DKCurlJS.h"
//#ifdef HAVE_DKThread
//	#include "DKThread/DKThread.h"
//#endif

/////////////////////
bool DKCurlJS::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("CPP_DKCurl_Download", DKCurlJS::Download);
	DKDuktape::AttachFunction("CPP_DKCurl_FileDate", DKCurlJS::FileDate);
	DKDuktape::AttachFunction("CPP_DKCurl_FtpConnect", DKCurlJS::FtpConnect);
	DKDuktape::AttachFunction("CPP_DKCurl_FtpUpload", DKCurlJS::FtpUpload);
	DKDuktape::AttachFunction("CPP_DKCurl_GetExternalIP", DKCurlJS::GetExternalIP);
	DKDuktape::AttachFunction("CPP_DKCurl_HttpFileExists", DKCurlJS::HttpFileExists);
	DKDuktape::AttachFunction("CPP_DKCurl_HttpToString", DKCurlJS::HttpToString);

	DKCurl::Instance("DKCurl0"); //do we need this?
	return true;
}

////////////////////////////////////////
int DKCurlJS::Download(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString url = duk_require_string(ctx, 0);
	DKString dest = duk_require_string(ctx, 1);
	if(!DKCurl::Get()->Download(url, dest)){
		return 0;
	}
	return 1;
}

////////////////////////////////////////
int DKCurlJS::FileDate(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString url = duk_require_string(ctx, 0);
	DKString filedate;
	if (!DKCurl::Get()->FileDate(url, filedate)){
		return 0;
	}
	char* pEnd;
	double time = (double)strtoull(filedate.c_str(), &pEnd, 10);
	duk_push_number(ctx, time);
	return 1;
}

//////////////////////////////////////////
int DKCurlJS::FtpConnect(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString server = duk_require_string(ctx, 0);
	DKString name = duk_require_string(ctx, 1);
	DKString pass = duk_require_string(ctx, 2);
	DKString port = duk_require_string(ctx, 3);

	if(!DKCurl::Get()->FtpConnect(server, name, pass, port)){
		return 0;
	}
	return 1;
}

/////////////////////////////////////////
int DKCurlJS::FtpUpload(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString file = duk_require_string(ctx, 0);
	DKString url = duk_require_string(ctx, 1);
	if (!DKCurl::Get()->FtpUpload(file, url)){
		return 0;
	}
	//DKQueue("FtpUpload", boost::bind(&DKCurl::FtpUpload, DKCurl::Get("DKCurl0"), file, url));
	return 1;
}

/////////////////////////////////////////////
int DKCurlJS::GetExternalIP(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString ipaddress;
	if(!DKCurl::Get()->GetExternalIP(ipaddress)){
		return 0;
	}
	duk_push_string(ctx, ipaddress.c_str());
	return 1;
}

////////////////////////////////////////////
int DKCurlJS::HttpToString(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString url = duk_require_string(ctx, 0);
	DKString output;
	if(!DKCurl::Get()->HttpToString(url, output)){
		return 0;
	}
	duk_push_string(ctx, output.c_str());
	return 1;
}

//////////////////////////////////////////////
int DKCurlJS::HttpFileExists(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString url = duk_require_string(ctx, 0);
	if(!DKCurl::Get()->HttpFileExists(url)){
		return 0;
	}
	return 1;
}


#endif //HAVE_DKDuktape