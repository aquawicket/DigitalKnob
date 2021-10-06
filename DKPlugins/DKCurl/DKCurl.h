#pragma once
#ifndef DKCurl_H
#define DKCurl_H

#include "DK/DK.h"
#include "DK/DKUtil.h"

#ifdef USE_curl
	#include <curl/curl.h>
#endif

class DKCurl : public DKObjectT<DKCurl>
{
public:
#ifdef USE_curl
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

	static int WriteToBuffer(char *data, size_t size, size_t nmemb, std::string *buffer);
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
#endif 
};

REGISTER_OBJECT(DKCurl, false);

#endif //DKCurl_H