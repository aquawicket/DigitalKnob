#include "DK/stdafx.h"
#include <sys/stat.h>
#include <cstring>
#include "DK/DKFile.h"
#include "DKCurl/DKCurl.h"


bool DKCurl::Init(){
	DKDEBUGFUNC();	
	DKClass::DKCreate("DKCurlJS");
	DKClass::DKCreate("DKCurlV8");
	curl = NULL;
	return true;
}

bool DKCurl::End(){
	DKDEBUGFUNC();
	DKClass::DKClose("DKCurlJS");
	DKClass::DKClose("DKCurlV8");
	if(curl)
		curl_easy_cleanup(curl);
	return true;
}

bool DKCurl::CurlInit(){
	DKDEBUGFUNC();
	if(curl)
		curl_easy_cleanup(curl);
	CURLcode curlcode = curl_global_init(CURL_GLOBAL_ALL); 
	if(curlcode != CURLE_OK)
		return DKERROR(DKString(curl_easy_strerror(curlcode))+"\n");
	curl = curl_easy_init(); //NOTE: Curl inits are NOT thread safe. we must init within the given thread
	if(!curl)
        return DKERROR("curl invalid\n");
#ifdef DEBUG
	//curl_easy_setopt(curl, CURLOPT_DEBUGFUNCTION, my_trace); //PRINT EXTIRE CURL DEBUG TRACE INFO
	curl_easy_setopt(curl, CURLOPT_VERBOSE, true);
#endif
	return true;
}

bool DKCurl::Download(const DKString& url, const DKString& dest/*, const bool overwrite*/){
	DKDEBUGFUNC(url, dest);
	// SENARIOS
	// 1. dest exists and is a file.  urlFilename matches destFilename.               Example:  (http://test.com/fileA , C:/stuff/fileA):  dkPath is C:/stuff/fileA         redownload if overwrite is enabled
	// 2. dest exists and is a file.  urlFilename does not match destFilename.        Example:  (http://test.com/fileA , C:/stuff/fileB):  dkPath is C:/stuff/fileB         redownload if overwrite is enabled
	// 3. dest exists and is a directory.  urlFilename matches destFilename.          Example:  (http://test.com/fileA , C:/stuff/fileA):  dlPath is C:/stuff/fileA/fileA   download if overwrite enabled OR dlpath + filename does not exist
	// 4. dest exists and is a directory.  urlFilename does not match destFilename.   Example:  (http://test.com/fileB , C:/stuff/fileA):  dlPath is C:/stuff/fileA/fileB   download if overwrite enabled OR dlpath + filename does not exist
	// 5. dest does not exist.  urlFilename matches destFilename.                     Example:  (http://test.com/fileA , C:/stuff/fileA):  dlPath is C:/stuff/fileA         download
	// 6. dest does not exist.  urlFilename does not match destFilename.              Example:  (http://test.com/fileA , C:/stuff/fileB):  dlPath is C:/stuff/fileB         download

	//FIXME: If the destination path doesn't exist, create it
	const bool overwrite = false;
	DKString urlFilename;
	DKFile::GetFileName(url, urlFilename);
	DKString dlPath = dest;
	if(DKFile::IsDirectory(dlPath))
		dlPath = dest+"/"+urlFilename; //See 3. and 4.
	if(DKFile::IsDirectory(dlPath)){
		DKERROR(dlPath + "\n");
		return DKERROR("Path already exists as a directory. Cannot overwrite a folder with a file\n");
	}
	if(DKFile::PathExists(dlPath)){
		if(!overwrite){
			return DKWARN("file already exists. "+dlPath+"\n");
		}
		else{
			DKFile::Delete(dlPath);
		}
	}
	DKString dlFolder;
	DKFile::GetFilePath(dlPath, dlFolder);
	if(!DKFile::IsDirectory(dlFolder))
		DKFile::MakeDir(dlFolder);
	//FIXME: crate a "startsWith" function to use instead of "has". Use to check of string variable starts with "string" from character 0
	if(has(url,"http://"))
		return HttpDownload(url, dlPath);
	if(has(url,"https://"))
		return HttpDownload(url, dlPath);
	if(has(url,"ftp."))
		return FtpDownload(url, dlPath);
	return DKERROR("invalid url");
}

bool DKCurl::FacebookLogin(const DKString& email, const DKString& password, DKString& output){
	DKDEBUGFUNC(email, password, output);
	if(!CurlInit())
		return DKERROR("curl invalid");
	DKString curlBuffer = "";
	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, &DKCurl::WriteToBuffer);
	curl_easy_setopt(curl, CURLOPT_WRITEDATA, &curlBuffer);
	curl_easy_setopt(curl, CURLOPT_URL, "https://www.facebook.com/login.php");
	//curl_easy_setopt(curl, CURLOPT_POSTFIELDS,"email="+email+"&pass="+password+"&login=Login");
	curl_easy_setopt(curl, CURLOPT_POST, 1);
	curl_easy_setopt(curl, CURLOPT_HEADER, 0);
	curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1);
	//curl_easy_setopt(curl, CURLOPT_COOKIESESSION, false);
	//curl_easy_setopt(curl, CURLOPT_COOKIEJAR, DKApp::datapath+"cookies.txt");
	//curl_easy_setopt(curl, CURLOPT_COOKIEFILE, DKApp::datapath+"cookies.txt");
	//curl_easy_setopt(curl, CURLOPT_USERAGENT, "Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.3) Gecko/20070309 Firefox/2.0.0.3");
	curl_easy_setopt(curl, CURLOPT_USERAGENT, "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.6 (KHTML, like Gecko) Chrome/16.0.897.0 Safari/535.6");
	curl_easy_setopt(curl, CURLOPT_REFERER, "http://www.facebook.com");
	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, 0L);
	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, 0L);
	CURLcode curlcode = curl_easy_perform(curl);
	//curl_easy_cleanup(curl);
	if(curlcode != CURLE_OK)
		return DKERROR(DKString(curl_easy_strerror(curlcode))+"\n");
	output = curlBuffer;
	return true;
}

bool DKCurl::FileDate(const DKString& url, DKString& filedate){
	DKDEBUGFUNC(url, filedate);
	if(has(url,"http://"))
		return HttpFileDate(url, filedate);
	if(has(url,"https://"))
		return HttpFileDate(url, filedate);
	if(has(url,"ftp."))
		return FtpFileDate(url, filedate);
	return DKERROR("invalid url");
}

bool DKCurl::FileExists(const DKString& url){
	DKDEBUGFUNC(url);
	if(has(url,"http://"))
		return HttpFileExists(url);
	if(has(url,"https://"))
		return HttpFileExists(url);
	if(has(url,"ftp."))
		return FtpFileExists(url);
	return DKERROR("invalid url");
}

bool DKCurl::FileSize(const DKString& url, long& size){
	DKDEBUGFUNC(url, size);
	if(has(url,"http://"))
		return HttpFileSize(url, size);
	if(has(url,"https://"))
		return HttpFileSize(url, size);
	if(has(url,"ftp."))
		return FtpFileSize(url, size);
	return DKERROR("invalid url");
}

bool DKCurl::FtpConnect(const DKString& server, const DKString& name, const DKString& pass, const DKString port){
	DKDEBUGFUNC(server, name, pass, port);
	ftpServer.clear();
	ftpName.clear();
	ftpPass.clear();
	ftpPort.clear();
	if(!CurlInit())
		return DKERROR("curl invalid");
	DKString login = name+":"+pass;
	curl_easy_setopt(curl, CURLOPT_USERPWD, login.c_str() );
	curl_easy_setopt(curl, CURLOPT_URL, server.c_str());
	CURLcode curlcode = curl_easy_perform(curl);
	//curl_easy_cleanup(curl);
	if(curlcode != CURLE_OK)
		return DKERROR(DKString(curl_easy_strerror(curlcode))+"\n");
	ftpServer = server;
	ftpName = name;
	ftpPass = pass;
	ftpPort = port;
	DKINFO("FTP Connected\n");
	return true;
}

bool DKCurl::FtpDownload(const DKString& url, const DKString& dest/*, const bool overwrite*/){
	DKDEBUGFUNC(url, dest);
	//if(!FtpFileExists(url))
	//	return DKERROR("url not found\n");
	if(!CurlInit())
		return DKERROR("curl invalid");
	DKString login = ftpName+":"+ftpPass;
	curl_easy_setopt(curl, CURLOPT_USERPWD, login.c_str() );
	curl_easy_setopt(curl, CURLOPT_URL, url.c_str());
	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, &DKCurl::WriteToFile);
	FILE *fp = fopen(dest.c_str(),"wb");
	if(!fp)
		return DKERROR("DKCurl::FtpDownload() *fp invalid \n");
	curl_easy_setopt(curl, CURLOPT_WRITEDATA, fp);
	DKINFO("Downloading "+url+"...\n");
	CURLcode curlcode = curl_easy_perform(curl);
	//curl_easy_cleanup(curl);
	fclose(fp);
	if(curlcode != CURLE_OK)
		return DKERROR(DKString(curl_easy_strerror(curlcode))+"\n");
	if(!DKFile::PathExists(dest))
		return DKERROR("Download Failed: "+dest+"\n");
	return true;
}

bool DKCurl::FtpFileDate(const DKString& url, DKString& filedate){
	DKDEBUGFUNC(url, filedate);
	//if(!FtpFileExists(url))
	//	return DKERROR("url not found\n");
	if(!CurlInit())
		return DKERROR("curl invalid");
	DKString login = ftpName+":"+ftpPass;
	curl_easy_setopt(curl, CURLOPT_USERPWD, login.c_str() );
	curl_easy_setopt(curl, CURLOPT_URL, url.c_str());
	curl_easy_setopt(curl, CURLOPT_NOBODY, true);
	curl_easy_setopt(curl, CURLOPT_FILETIME, true );
	//curl_easy_setopt(curl, CURLOPT_USERAGENT, "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.6 (KHTML, like Gecko) Chrome/16.0.897.0 Safari/535.6");
 	CURLcode curlcode = curl_easy_perform(curl);
	if(curlcode != CURLE_OK){
		//curl_easy_cleanup(curl);
		return DKERROR(DKString(curl_easy_strerror(curlcode))+"\n");
	}
	const time_t filetime = 0;
	curlcode = curl_easy_getinfo(curl, CURLINFO_FILETIME, &filetime);
	//curl_easy_cleanup(curl);
	if(curlcode != CURLE_OK)
		return DKERROR(DKString(curl_easy_strerror(curlcode))+"\n");
	struct tm* clock;
	clock = localtime(&filetime);
	DKString month = toString(clock->tm_mon);
	DKString day = toString(clock->tm_mday);
	DKString hour = toString(clock->tm_hour);
	DKString minute = toString(clock->tm_min);
	DKString second = toString(clock->tm_sec);
	DKString year = toString(clock->tm_year + 1900);
	Pad(4, '0', year);
	Pad(2, '0', month);
	Pad(2, '0', day);
	Pad(2, '0', hour);
	Pad(2, '0', minute);
	Pad(2, '0', second);
	filedate = year + month + day + hour + minute + second;
	//DKString(filedate+"\n");
	return true;
}

bool DKCurl::FtpFileExists(const DKString& url){
	DKDEBUGFUNC(url);
	if(!CurlInit())
		return DKERROR("curl invalid");
	DKString login = ftpName+":"+ftpPass;
	curl_easy_setopt(curl, CURLOPT_USERPWD, login.c_str() );
	curl_easy_setopt(curl, CURLOPT_URL, url.c_str());
	//curl_easy_setopt(curl, CURLOPT_HEADER, 1L);
	curl_easy_setopt(curl, CURLOPT_NOBODY, 1L);
	CURLcode curlcode = curl_easy_perform(curl);
	if(curlcode != CURLE_OK){
		//curl_easy_cleanup(curl);
		return DKERROR(DKString(curl_easy_strerror(curlcode))+"\n");
	}
	long http_code = 0;
	curlcode = curl_easy_getinfo(curl, CURLINFO_RESPONSE_CODE, &http_code);
	//curl_easy_cleanup(curl);
	if(curlcode != CURLE_OK)
		return DKERROR(DKString(curl_easy_strerror(curlcode)) + "\n");
	if(http_code >= 400) //https://developer.mozilla.org/en-US/docs/Web/HTTP/Status
		return DKERROR("CURLINFO_RESPONSE_CODE: "+toString(http_code)+"\n");
	return true;
}

bool DKCurl::FtpFileSize(const DKString& url, long& size){
	DKDEBUGFUNC(url, size);
	//TODO
	return false;
}

bool DKCurl::FtpUpload(const DKString& file, const DKString& url/*, const bool overwrite*/){
	DKDEBUGFUNC(file, url);
	if(DKFile::IsDirectory(file))
		return DKERROR("DKCurl::FtpUpload() cannot upload recursive folders yet.\n");
	DKString urlpath = url+"_ul";
	struct stat file_info;
	curl_off_t fsize;
	FILE *hd_src;
	struct curl_slist *headerlist = NULL;
	DKString filename;
	DKFile::GetFileName(file, filename);
	DKString buff1 = "RNFR " + filename + "_ul";
	DKString buff2 = "RNTO " + filename;
	if(stat(file.c_str(), &file_info))
		return DKERROR("Couldn't open "+file+": "+strerror(errno)+"\n");
	fsize = (curl_off_t) file_info.st_size;
    //printf("Local file size: %" CURL_FORMAT_CURL_OFF_T " bytes. \n", fsize);
	hd_src = fopen(file.c_str(), "rb");
	if(!CurlInit())
		return DKERROR("curl invalid");
	headerlist = curl_slist_append(headerlist, buff1.c_str());
	headerlist = curl_slist_append(headerlist, buff2.c_str());
	//curl_easy_setopt(curl, CURLOPT_COOKIEFILE, "cookies.txt");
	//curl_easy_setopt(curl, CURLOPT_COOKIEJAR, "cookies.txt");
	//curl_easy_setopt(curl, CURLOPT_USERAGENT, "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.6 (KHTML, like Gecko) Chrome/16.0.897.0 Safari/535.6");
	DKString login = ftpName+":"+ftpPass;
	curl_easy_setopt(curl, CURLOPT_USERPWD, login.c_str() );
	curl_easy_setopt(curl, CURLOPT_READFUNCTION, read_callback);
	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1L);
	curl_easy_setopt(curl, CURLOPT_URL, urlpath.c_str());
	curl_easy_setopt(curl, CURLOPT_POSTQUOTE, headerlist);
	curl_easy_setopt(curl, CURLOPT_READDATA, hd_src);
	curl_easy_setopt(curl, CURLOPT_INFILESIZE_LARGE, (curl_off_t) fsize);
	DKINFO("Uploading "+filename);
	CURLcode curlcode = curl_easy_perform(curl);
	if(curlcode != CURLE_OK){ 
		DKWARN(" :"+DKString(curl_easy_strerror(curlcode))+"\n");
		DKWARN("2nd attempt.");
		curlcode = curl_easy_perform(curl);
	}
	if(curlcode != CURLE_OK){ 
		DKWARN(" :"+DKString(curl_easy_strerror(curlcode))+"\n");
		DKWARN("3rd attempt.");
		curlcode = curl_easy_perform(curl);
	}
	curl_slist_free_all(headerlist);
	fclose(hd_src);
	//curl_easy_cleanup(curl);
	if(curlcode != CURLE_OK)
		return DKERROR(DKString(curl_easy_strerror(curlcode))+"\n");
	return true;
}

bool DKCurl::GetExternalIP(DKString& ipaddress){
	DKDEBUGFUNC(ipaddress);
	DKString url = "http://myexternalip.com/raw";
	return HttpToString(url, ipaddress);
}

bool DKCurl::HttpDownload(const DKString& url, const DKString& dest){
	DKDEBUGFUNC(url, dest);
	if(!DKCurl::FileExists(url))
		return DKERROR("url not found\n");
	if(!CurlInit())
		return DKERROR("curl invalid\n");
	curl_easy_setopt(curl, CURLOPT_URL, url.c_str());
	curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1L);
    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, &DKCurl::WriteToFile);
	FILE *fp = fopen(dest.c_str(),"wb");
	if(!fp){
		//curl_easy_cleanup(curl);
		return DKERROR("DKCurl::Download() *fp invalid\n");
	}
    curl_easy_setopt(curl, CURLOPT_WRITEDATA, fp);
	curl_easy_setopt(curl, CURLOPT_NOPROGRESS, 0);
	curl_easy_setopt(curl, CURLOPT_PROGRESSFUNCTION, &DKCurl::progress_func);
	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, 0L);
	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, 0L);
	DKINFO("Downloading "+url+". . .\n");
	CURLcode curlcode = curl_easy_perform(curl);
	//curl_easy_cleanup(curl);
	fclose(fp);
	if(curlcode != CURLE_OK)
		return DKERROR(DKString(curl_easy_strerror(curlcode))+"\n");
	if(!DKFile::PathExists(dest))
		return DKERROR("Download Failed: "+dest+"\n");
	DKINFO("Download Complete: "+dest+"\n");
	return true;
}

bool DKCurl::HttpFileDate(const DKString& url, DKString& filedate){
	DKDEBUGFUNC(url, filedate);
	if(!HttpFileExists(url))
		return DKERROR("url not found\n");
	if(!CurlInit())
		return DKERROR("curl invalid");
	curl_easy_setopt(curl, CURLOPT_URL, url.c_str());
	curl_easy_setopt(curl, CURLOPT_NOBODY, true);
	curl_easy_setopt(curl, CURLOPT_FILETIME, true );
	curl_easy_setopt(curl, CURLOPT_USERAGENT, "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.6 (KHTML, like Gecko) Chrome/16.0.897.0 Safari/535.6");
	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, 0L);
	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, 0L);
	CURLcode curlcode = curl_easy_perform(curl); //Perform the request, curlcode will get the return code		
	if(curlcode != CURLE_OK){ 
		//curl_easy_cleanup(curl);
		return DKERROR("curl_easy_preform() failed \n");
	}
	const time_t filetime = 0;
	curlcode = curl_easy_getinfo(curl, CURLINFO_FILETIME, &filetime);
	//curl_easy_cleanup(curl);
	struct tm* clock;
	clock = localtime(&filetime);
	DKString month = toString(clock->tm_mon);
	DKString day = toString(clock->tm_mday);
	DKString hour = toString(clock->tm_hour);
	DKString minute = toString(clock->tm_min);
	DKString second = toString(clock->tm_sec);
	DKString year = toString(clock->tm_year + 1900);
	Pad(4, '0', year);
	Pad(2, '0', month);
	Pad(2, '0', day);
	Pad(2, '0', hour);
	Pad(2, '0', minute);
	Pad(2, '0', second);
	filedate = year + month + day + hour + minute + second;
	return true;
}

bool DKCurl::HttpFileExists(const DKString& url){
	DKDEBUGFUNC(url);
	DKString _url = url;
	if(!has(url, "http://") && !has(url, "HTTP://") && !has(url, "https://") && !has(url, "HTTPS://"))
		_url = "http://" + url;
	if(!CurlInit())
		return DKERROR("curl invalid");
	curl_easy_setopt(curl, CURLOPT_URL, _url.c_str());
	//curl_easy_setopt(curl, CURLOPT_HEADER, 1L);
	curl_easy_setopt(curl, CURLOPT_NOBODY, 1L);
	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, 0L);
	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, 0L);
	CURLcode curlcode = curl_easy_perform(curl); //Perform the request, curlcode will get the return code
	if(curlcode != CURLE_OK){
		//curl_easy_cleanup(curl);
		return DKERROR(DKString(curl_easy_strerror(curlcode)) + "\n");
	}
	long http_code = 0;
	curlcode = curl_easy_getinfo(curl, CURLINFO_RESPONSE_CODE, &http_code);
	//curl_easy_cleanup(curl);
	if(curlcode != CURLE_OK)
		return DKERROR(DKString(curl_easy_strerror(curlcode)) + "\n");
	if(http_code >= 400) //https://developer.mozilla.org/en-US/docs/Web/HTTP/Status
		return DKERROR("CURLINFO_RESPONSE_CODE: "+toString(http_code)+"\n");
	return true;
}

bool DKCurl::HttpFileSize(const DKString& url, long& size){
	DKDEBUGFUNC(url, size);
	/*
	if(!CurlInit())
		return DKERROR("curl invalid");
	curl_easy_setopt(curl, CURLOPT_URL, url.c_str());
	curl_easy_setopt(curl, CURLOPT_NOBODY, 1); 
	curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1);
	curl_easy_setopt(curl, CURLOPT_HEADERFUNCTION, handle_data);
	curl_easy_setopt(curl, CURLOPT_MAXREDIRS, 500);
	curlcode = curl_easy_perform(curl);
	//curl_easy_cleanup(curl);
	if(curlcode != CURLE_OK)
		return DKERROR(DKString(curl_easy_strerror(curlcode)) + "\n");
	if(contents == "")
		size = -1;
	else
		size = atol(contents.c_str());
	*/
	return false;
}

bool DKCurl::HttpToString(const DKString& url, DKString& output){
	DKDEBUGFUNC(url, output);
	DKString _url = url;
	DKINFO("DKCurl::Http -> "+_url+"\n");
	replace(_url," ","%20");
	replace(_url,"'","%27");
	//replace(_url,"@","%40");
	//replace(_url,".","%2E");
	//replace(_url,"=","%3D");
	if(!DKCurl::FileExists(url))
		return DKERROR("DKCurl::HttpToString(): "+url+"  not found \n");
	if(!CurlInit())
		return DKERROR("curl invalid");
	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, false);
    curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, false);
	curl_easy_setopt(curl, CURLOPT_COOKIEFILE, /*DKApp::datapath+*/"cookies.txt");
	curl_easy_setopt(curl, CURLOPT_COOKIEJAR, /*DKApp::datapath+*/"cookies.txt");
	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, &DKCurl::WriteToBuffer);
	DKString curlBuffer = "";
	curl_easy_setopt(curl, CURLOPT_WRITEDATA, &curlBuffer);
	curl_easy_setopt(curl, CURLOPT_USERAGENT, "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.6 (KHTML, like Gecko) Chrome/16.0.897.0 Safari/535.6");
	curl_easy_setopt(curl, CURLOPT_URL, _url.c_str());
	//curl_easy_setopt(curl, CURLOPT_RETURNTRANSFER, 1);
	curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, true); // example.com is redirected, so we tell libcurl to follow redirection
 	//curl_easy_setopt(curl, CURLOPT_TIMEOUT, 5000);
	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, 0L);
	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, 0L);
	CURLcode curlcode = curl_easy_perform(curl);
	//curl_easy_cleanup(curl);
	if(curlcode != CURLE_OK)
		return DKERROR("curl_easy_preform() failed \n"); 
	output = curlBuffer;
	return true;
}

size_t DKCurl::WriteToFile(void *ptr, size_t size, size_t nmemb, FILE *stream){
	//DKDEBUGFUNC(ptr, size, nmemb, stream);
	return fwrite(ptr, size, nmemb, stream);
}

int DKCurl::WriteToBuffer(char *data, size_t size, size_t nmemb, std::string *buffer){
	//DKDEBUGFUNC(data, size, nmemb, buffer);
    int result = 0;
    if(buffer != NULL){
        buffer->append(data, size * nmemb);
		result = size * nmemb;
    }
	return result;
}

size_t DKCurl::read_callback(void *ptr, size_t size, size_t nmemb, void *stream){
	//DKDEBUGFUNC(ptr, size, nmemb, stream);
    curl_off_t nread;
    size_t retcode = fread(ptr, size, nmemb, (FILE *)stream);
    nread = (curl_off_t) retcode;
	printf(".");
    //fprintf(stderr, "*** We read %" CURL_FORMAT_CURL_OFF_T " bytes from filen", nread);
    return retcode;
}

int DKCurl::progress_func(void* ptr, double TotalToDownload, double NowDownloaded, double TotalToUpload, double NowUploaded){
	//DKDEBUGFUNC(ptr, TotalToDownload, NowDownloaded, TotalToUpload, NowUploaded);
    // how wide you want the progress meter to be
    int totaldotz=40;
    double fractiondownloaded = NowDownloaded / TotalToDownload;
    // part of the progressmeter that's already "full"
	double dotz = fractiondownloaded * totaldotz;
	DKUtil::Round(dotz);
    // Create the "meter"
    int ii=0;
    printf("%3.0f%% [",fractiondownloaded*100);
    // part that's full already
    for( ; ii < dotz; ii++)
        printf("=");
    // remaining part (spaces)
    for( ; ii < totaldotz; ii++)
        printf(" ");
    // and back to line begin - do not forget the fflush to avoid output buffering problems!
    printf("]\r");
    fflush(stdout);
	return 0;
}

void DKCurl::dump(const char *text, FILE *stream, unsigned char *ptr, size_t size){
	size_t i;
	size_t c;
	unsigned int width=0x10;
	fprintf(stream, "%s, %10.10ld bytes (0x%8.8lx)\n", text, (long)size, (long)size);
	for(i=0; i<size; i+= width){
		fprintf(stream, "%4.4lx: ", (long)i);
		// show hex to the left
		for(c = 0; c < width; c++){
			if(i+c < size)
				fprintf(stream, "%02x ", ptr[i+c]);
			else
				fputs("   ", stream);
		}
		// show data on the right
		for(c = 0; (c < width) && (i+c < size); c++) {
			char x = (ptr[i+c] >= 0x20 && ptr[i+c] < 0x80) ? ptr[i+c] : '.';
			fputc(x, stream);
		}
		fputc('\n', stream); /* newline */
	}
}
 
int DKCurl::my_trace(CURL *handle, curl_infotype type, char *data, size_t size, void *userp){
	const char *text;
	(void)handle; /* prevent compiler warning */
	(void)userp;
	switch (type){
		case CURLINFO_TEXT:
			fprintf(stderr, "== Info: %s", data);
		default: /* in case a new one is introduced to shock us */
			return 0;
		case CURLINFO_HEADER_OUT:
			text = "=> Send header";
			break;
		case CURLINFO_DATA_OUT:
			text = "=> Send data";
			break;
		case CURLINFO_SSL_DATA_OUT:
			text = "=> Send SSL data";
			break;
		case CURLINFO_HEADER_IN:
			text = "<= Recv header";
			break;
		case CURLINFO_DATA_IN:
			text = "<= Recv data";
			break;
		case CURLINFO_SSL_DATA_IN:
			text = "<= Recv SSL data";
			break;
	}
	dump(text, stderr, (unsigned char *)data, size);
	return 0;
}
