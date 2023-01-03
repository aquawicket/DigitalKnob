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

#if HAVE_DKCef
#include "DK/DKApp.h"
#include "DKCurl/DKCurl.h"
#include "DKCurl/DKCurlV8.h"


bool DKCurlV8::Init(){
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

bool DKCurlV8::End(){
	DKDEBUGFUNC();
	return true;
}

bool DKCurlV8::Download(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	DKString url = args->GetString(0);
	DKString dest = args->GetString(1);
	if(!DKCurl::Get()->Download(url, dest))
		return DKERROR("DKCurl::Get()->Download() failed! \n");
	return true;
}

bool DKCurlV8::FileDate(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	DKString url = args->GetString(0);
	DKString filedate;
	if(!DKCurl::Get()->FileDate(url, filedate))
		return DKERROR("DKCurl::Get()->FileDate() failed! \n");
	char* pEnd;
	double time = (double)strtoull(filedate.c_str(), &pEnd, 10);
	if(!retval->SetDouble(0, time))
		return DKERROR("retval->SetDouble() failed! \n");
	return true;
}

bool DKCurlV8::FtpConnect(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	DKString server = args->GetString(0);
	DKString name = args->GetString(1);
	DKString pass = args->GetString(2);
	DKString port = args->GetString(3);
	if(!DKCurl::Get()->FtpConnect(server, name, pass, port))
		return DKERROR("DKCurl::Get()->FtpConnect() failed! \n");
	return true;
}

bool DKCurlV8::FtpUpload(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	DKString file = args->GetString(0);
	DKString url = args->GetString(1);
	if(!DKCurl::Get()->FtpUpload(file, url))
		return DKERROR("DKCurl::Get()->FtpUpload() failed! \n");
	//DKQueue("FtpUpload", boost::bind(&DKCurl::FtpUpload, DKCurl::Get("DKCurl0"), file, url));
	return true;
}

bool DKCurlV8::GetExternalIP(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	DKString ipaddress;
	if(!DKCurl::Get()->GetExternalIP(ipaddress))
		return DKERROR("DKCurl::Get()->GetExternalIP()! \n");
	if(!retval->SetString(0, ipaddress))
		return DKERROR("retval->SetString() failed! \n");
	return true;
}

bool DKCurlV8::HttpFileExists(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	DKString url = args->GetString(0);
	if(!DKCurl::Get()->HttpFileExists(url))
		return DKERROR("DKCurl::Get()->HttpFileExists() failed! \n");
	return true;
}

bool DKCurlV8::HttpToString(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	DKString url = args->GetString(0);
	DKString output;
	if(!DKCurl::Get()->HttpToString(url, output))
		return DKERROR("DKCurl::Get()->HttpToString() failed! \n");
	if(!retval->SetString(0, output))
		return DKERROR("retval->SetString() failed! \n");
	return true;
}

#endif //HAVE_DKCef