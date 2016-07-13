#ifdef USE_DKDuktape 
#include "DKCurl.h"
#include "DKCurlJS.h"
#include "DKThread.h"

/////////////////////
void DKCurlJS::Init()
{
	DKDuktape::AttachFunction("DKCurl_FtpConnect", DKCurlJS::FtpConnect, 4);
	DKDuktape::AttachFunction("DKCurl_FtpUpload", DKCurlJS::FtpUpload, 2);
	DKDuktape::AttachFunction("DKCurl_HttpToString", DKCurlJS::HttpToString, 1);
	DKDuktape::AttachFunction("DKCurl_HttpFileExists", DKCurlJS::HttpFileExists, 1);
	DKDuktape::AttachFunction("DKCurl_FileDate", DKCurlJS::FileDate, 1);
	DKDuktape::AttachFunction("DKCurl_Download", DKCurlJS::Download, 2);
	DKCurl::Instance("DKCurl0");
}

///////////////////////////////////
int DKCurlJS::FtpConnect(duk_context* ctx)
{
	DKString server = duk_require_string(ctx, 0);
	DKString name = duk_require_string(ctx, 1);
	DKString pass = duk_require_string(ctx, 2);
	DKString port = duk_require_string(ctx, 3);

	if(!DKCurl::Get("DKCurl0")->FtpConnect(server, name, pass, port)){
		return 0;
	}
	return 1;
}

//////////////////////////////////
int DKCurlJS::FtpUpload(duk_context* ctx)
{
	DKString file = duk_require_string(ctx, 0);
	DKString url = duk_require_string(ctx, 1);
	if (!DKCurl::Get("DKCurl0")->FtpUpload(file, url)){
		return 0;
	}
	//DKQueue("FtpUpload", boost::bind(&DKCurl::FtpUpload, DKCurl::Get("DKCurl0"), file, url));
	return 1;
}

/////////////////////////////////////
int DKCurlJS::HttpToString(duk_context* ctx)
{
	DKString url = duk_require_string(ctx, 0);
	DKString output;
	if (!DKCurl::Get("DKCurl0")->HttpToString(url, output)){
		return 0;
	}
	duk_push_string(ctx, output.c_str());
	return 1;
}

///////////////////////////////////////
int DKCurlJS::HttpFileExists(duk_context* ctx)
{
	DKString url = duk_require_string(ctx, 0);
	if (!DKCurl::Get("DKCurl0")->HttpFileExists(url)){
		return 0;
	}
	return 1;
}

/////////////////////////////////
int DKCurlJS::FileDate(duk_context* ctx)
{
	DKString url = duk_require_string(ctx, 0);
	DKString filedate;
	if (!DKCurl::Get("DKCurl0")->FileDate(url, filedate)){
		return 0;
	}
	char* pEnd;
	double time = (double)strtoull(filedate.c_str(), &pEnd, 10);
	duk_push_number(ctx, time);
	return 1;
}

/////////////////////////////////
int DKCurlJS::Download(duk_context* ctx)
{
	DKString url = duk_require_string(ctx, 0);
	DKString dest = duk_require_string(ctx, 1);
	if(!DKCurl::Get("DKCurl0")->Download(url, dest)){
		return 0;
	}
	return 1;
}

#endif //USE_DKDuktape