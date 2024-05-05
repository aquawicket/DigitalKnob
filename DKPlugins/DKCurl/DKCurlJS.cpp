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

#if HAVE_DKDuktape 
#include "DKCurl/DKCurl.h"
#include "DKCurl/DKCurlJS.h"
//#if HAVE_DKThread
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