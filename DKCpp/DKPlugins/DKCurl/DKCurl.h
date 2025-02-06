/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2025 Digitalknob Team, and contributors
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

#pragma once
#ifndef DKCurl_H
#define DKCurl_H

#include "DK/DK.h"
#include "DK/DKUtil.h"

//WARNING_DISABLE
#include <curl/curl.h>
//WARNING_ENABLE

class DKCurl : public DKObjectT<DKCurl>
{
public:
	//TODO: Persistant connecton
	bool Init();
	bool End();
	bool CurlInit();
	bool Download(const DKString& url, const DKString& dest/*, const bool overwrite*/);
	bool FacebookLogin(const DKString& email, const DKString& password, DKString& output);
	bool FileDate(const DKString& url, DKString& filedate);
	bool FileExists(const DKString& url);
	bool FileSize(const DKString& url, long& size);
	bool FtpConnect(const DKString& server, const DKString& name, const DKString& pass, const DKString port);
	bool FtpDownload(const DKString& url, const DKString& dest/*, const bool overwrite*/);
	bool FtpFileDate(const DKString& url, DKString& filedate);
	bool FtpFileExists(const DKString& url);
	bool FtpFileSize(const DKString& url, long& size);
	bool FtpUpload(const DKString& file, const DKString& url/*, const bool overwrite*/);
	bool GetExternalIP(DKString& ipaddress);
	bool HttpDownload(const DKString& url, const DKString& dest/*, const bool overwrite*/);
	bool HttpFileDate(const DKString& url, DKString& filedate);
	bool HttpFileExists(const DKString& url);
	bool HttpFileSize(const DKString& url, long& size);
	bool HttpToString(const DKString& url, DKString& output);

	//static int WriteToBuffer(char *data, size_t size, size_t nmemb, std::string *buffer);
	static size_t WriteToBuffer(char* data, size_t size, size_t nmemb, std::string* buffer);
	static size_t WriteToFile(void *ptr, size_t size, size_t nmemb, FILE *stream);
	static size_t read_callback(void *ptr, size_t size, size_t nmemb, void *stream);
	static int progress_func(void* ptr, double TotalToDownload, double NowDownloaded, double TotalToUpload, double NowUploaded);
	static void dump(const char *text, FILE *stream, unsigned char *ptr, size_t size);
	static int my_trace(CURL *handle, curl_infotype type, char *data, size_t size, void *userp);

	CURL* curl;
	DKString ftpServer;
	DKString ftpName;
	DKString ftpPass;
	DKString ftpPort;
};

REGISTER_OBJECT(DKCurl, false);

#endif //DKCurl_H