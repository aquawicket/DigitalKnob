#pragma once
#ifndef DKCurl_H
#define DKCurl_H
#include "DK.h"
#include "DKUtil.h"
#include <curl/curl.h>


///////////////////////////////////////
class DKCurl : public DKObjectT<DKCurl>
{
public:
	//TODO: Persistant connecton
	void Init();
	void End();

	bool CurlInit();
	bool Download(const DKString& url, const DKString& dest);
	bool FileDate(const DKString& url, DKString& filedate);
	bool FileExists(const DKString& url);
	bool FileSize(const DKString& url, long& size);
	bool FtpConnect(const DKString& server, const DKString& name, const DKString& pass, const DKString port);
	bool FtpUpload(const DKString& file, const DKString& url);
	bool HttpFileExists(const DKString& url);
	bool HttpToString(const DKString& url, DKString& output);

private:
	bool FacebookLogin(const DKString& email, const DKString& password, DKString& output);
	bool FtpDownload(const DKString& url, const DKString& dest);
	bool FtpFileDate(const DKString& url, DKString& filedate);
	bool FtpFileExists(const DKString& url);
	bool FtpFileSize(const DKString& url, long& size);
	bool HttpDownload(const DKString& url, const DKString& dest);
	bool HttpFileDate(const DKString& url, DKString& filedate);
	bool HttpFileSize(const DKString& url, long& size);

	static int WriteToBuffer(char *data, size_t size, size_t nmemb, std::string *buffer);
	static size_t WriteToFile(void *ptr, size_t size, size_t nmemb, FILE *stream);
	static size_t read_callback(void *ptr, size_t size, size_t nmemb, void *stream);
	static int progress_func(void* ptr, double TotalToDownload, double NowDownloaded, double TotalToUpload, double NowUploaded);

	CURL* curl;
	DKString ftpServer;
	DKString ftpName;
	DKString ftpPass;
	DKString ftpPort;
};


REGISTER_OBJECT(DKCurl, false);

#endif //DKCurl_H