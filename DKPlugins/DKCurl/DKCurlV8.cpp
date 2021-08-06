#ifdef USE_DKCef
#include "DK/DKApp.h"
#include "DKCurl/DKCurl.h"
#include "DKCurl/DKCurlV8.h"

/////////////////////
bool DKCurlV8::Init()
{
	DKDEBUGFUNC();
	DKV8::AttachFunction("DKCurl_Download", DKCurlV8::Download);
	DKV8::AttachFunction("DKCurl_FileDate", DKCurlV8::FileDate);
	DKV8::AttachFunction("DKCurl_FtpConnect", DKCurlV8::FtpConnect);
	DKV8::AttachFunction("DKCurl_FtpUpload", DKCurlV8::FtpUpload);
	DKV8::AttachFunction("DKCurl_GetExternalIP", DKCurlV8::GetExternalIP);
	DKV8::AttachFunction("DKCurl_HttpFileExists", DKCurlV8::HttpFileExists);
	DKV8::AttachFunction("DKCurl_HttpToString", DKCurlV8::HttpToString);
	return true;
}

////////////////////
bool DKCurlV8::End()
{
	DKDEBUGFUNC();
	return true;
}

///////////////////////////////////////////////////////
bool DKCurlV8::Download(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	DKString url = args->GetString(0);
	DKString dest = args->GetString(1);
	if(!DKCurl::Get()->Download(url, dest)){
		return false;
	}
	return true;
}

///////////////////////////////////////////////////////
bool DKCurlV8::FileDate(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	DKString url = args->GetString(0);
	DKString filedate;
	if(!DKCurl::Get()->FileDate(url, filedate)){
		return false;
	}
	char* pEnd;
	double time = (double)strtoull(filedate.c_str(), &pEnd, 10);
	if(!retval->SetDouble(0, time)){ return false; }
	return true;
}

/////////////////////////////////////////////////////////
bool DKCurlV8::FtpConnect(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	DKString server = args->GetString(0);
	DKString name = args->GetString(1);
	DKString pass = args->GetString(2);
	DKString port = args->GetString(3);

	if(!DKCurl::Get()->FtpConnect(server, name, pass, port)){
		return false;
	}
	return true;
}

////////////////////////////////////////////////////////
bool DKCurlV8::FtpUpload(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	DKString file = args->GetString(0);
	DKString url = args->GetString(1);
	if(!DKCurl::Get()->FtpUpload(file, url)){
		return false;
	}
	//DKQueue("FtpUpload", boost::bind(&DKCurl::FtpUpload, DKCurl::Get("DKCurl0"), file, url));
	return true;
}

////////////////////////////////////////////////////////////
bool DKCurlV8::GetExternalIP(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	DKString ipaddress;
	if(!DKCurl::Get()->GetExternalIP(ipaddress)){
		return false;
	}
	if(!retval->SetString(0, ipaddress)){ return false; }
	return true;
}

/////////////////////////////////////////////////////////////
bool DKCurlV8::HttpFileExists(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	DKString url = args->GetString(0);
	if(!DKCurl::Get()->HttpFileExists(url)){
		return false;
	}
	return true;
}

///////////////////////////////////////////////////////////
bool DKCurlV8::HttpToString(CefArgs args, CefReturn retval)
{
	DKDEBUGFUNC(args, retval);
	DKString url = args->GetString(0);
	DKString output;
	if(!DKCurl::Get()->HttpToString(url, output)){
		return 0;
	}
	if(!retval->SetString(0, output)){ return false; }
	return true;
}

#endif //USE_DKCef