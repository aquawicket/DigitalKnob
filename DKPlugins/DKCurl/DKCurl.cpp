#include "DK/stdafx.h"
#include <sys/stat.h>
#include <cstring>
#include "DK/DKFile.h"
#include "DKCurl/DKCurl.h"

bool DKCurl::Init(){
	DKDEBUGFUNC();	
	DKClass::DKCreate("DKCurlJS");
	DKClass::DKCreate("DKCurlV8");
	//Curl inits are NOT thread safe. we must init within the given thread
	/*
	curl_global_init(CURL_GLOBAL_ALL);
	curl = curl_easy_init();
	if(!curl){
        throw std::string ("Curl did not initialize! \n");
	}
	*/
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
	curl_global_init(CURL_GLOBAL_ALL);
	curl = curl_easy_init(); // Get a curl handle
	if(!curl)
        return DKERROR("Curl did not initialize! \n");
	return true;
}

bool DKCurl::Download(const DKString& url, const DKString& dest){
	DKDEBUGFUNC(url, dest);
	DKString path = dest;
	DKString filename;
	DKFile::GetFileName(url, filename);
	if(DKFile::IsDirectory(path))
		path += "/"+filename;
	if(DKFile::PathExists(path)){
		DKWARN("file already exists. "+filename+"\n");
		return true;
	}
	if(has(url,"http://") && HttpDownload(url, path))
		return true;
	if(has(url,"https://") && HttpDownload(url, path))
		return true;
	if(has(url,"ftp.") && FtpDownload(url, path))
		return true;
	return false;
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
	CURLcode res = curl_easy_perform(curl); //Perform the request, res will get the return code	
	if(res != CURLE_OK)
		return DKERROR("curl_easy_preform() failed \n"); 
	output = curlBuffer;
	return true;
}

bool DKCurl::FileDate(const DKString& url, DKString& filedate){
	DKDEBUGFUNC(url, filedate);
	if(has(url,"http://") && HttpFileDate(url, filedate))
		return true;
	if(has(url,"https://") && HttpFileDate(url, filedate))
		return true;
	if(has(url,"ftp.") && FtpFileDate(url, filedate))
		return true;
	return false;
}

bool DKCurl::FileExists(const DKString& url){
	DKDEBUGFUNC(url);
	if(has(url,"ftp.") && FtpFileExists(url))
		return true;
	if(HttpFileExists(url))
		return true;
	return false;
}

bool DKCurl::FileSize(const DKString& url, long& size){
	DKDEBUGFUNC(url, size);
	if(has(url,"http://") && HttpFileSize(url, size))
		return true;
	if(has(url,"https://") && HttpFileSize(url, size))
		return true;
	if(has(url,"ftp.") && FtpFileSize(url, size))
		return true;
	return false;
}

bool DKCurl::FtpConnect(const DKString& server, const DKString& name, const DKString& pass, const DKString port){
	DKDEBUGFUNC(server, name, pass, port);
	ftpServer.clear();
	ftpName.clear();
	ftpPass.clear();
	ftpPort.clear();
	if(!CurlInit())
		return DKERROR("curl invalid");
#ifdef DEBUG
	curl_easy_setopt(curl, CURLOPT_VERBOSE, true);
#endif
	DKString login = name+":"+pass;
	curl_easy_setopt(curl, CURLOPT_USERPWD, login.c_str() );
	curl_easy_setopt(curl, CURLOPT_URL, server.c_str());
	CURLcode res = curl_easy_perform(curl);
	if(res != CURLE_OK)
		return DKERROR("res != CURLE_OK")
	ftpServer = server;
	ftpName = name;
	ftpPass = pass;
	ftpPort = port;
	DKINFO("FTP Connected\n");
	return true;
}

bool DKCurl::FtpDownload(const DKString& url, const DKString& dest){
	DKDEBUGFUNC(url, dest);
	//if(!FtpFileExists(url))
	//	return DKERROR("url not found\n");
	FILE *fp = fopen(dest.c_str(),"wb");
	if(!fp)
		return DKERROR("DKCurl::FtpDownload() *fp invalid \n");
	DKINFO("Downloading "+url+"...\n");
	if(!CurlInit())
		return DKERROR("curl invalid");
#ifdef DEBUG
	curl_easy_setopt(curl, CURLOPT_VERBOSE, true);
#endif
	DKString login = ftpName+":"+ftpPass;
	curl_easy_setopt(curl, CURLOPT_USERPWD, login.c_str() );
	curl_easy_setopt(curl, CURLOPT_URL, url.c_str());
	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, &DKCurl::WriteToFile);
	curl_easy_setopt(curl, CURLOPT_WRITEDATA, fp);
	CURLcode res = curl_easy_perform(curl);
	fclose(fp);
	if(res != CURLE_OK)
		return DKERROR(DKString(curl_easy_strerror(res))+"\n");
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
#ifdef DEBUG
	curl_easy_setopt(curl, CURLOPT_VERBOSE, true);
#endif
	DKString login = ftpName+":"+ftpPass;
	curl_easy_setopt(curl, CURLOPT_USERPWD, login.c_str() );
	curl_easy_setopt(curl, CURLOPT_URL, url.c_str());
	curl_easy_setopt(curl, CURLOPT_NOBODY, true);
	curl_easy_setopt(curl, CURLOPT_FILETIME, true );
	//curl_easy_setopt(curl, CURLOPT_USERAGENT, "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.6 (KHTML, like Gecko) Chrome/16.0.897.0 Safari/535.6");
 	CURLcode res = curl_easy_perform(curl); //Perform the request, res will get the return code		
	if(res != CURLE_OK)
		return DKERROR("curl_easy_preform() failed\n"); 
	const time_t filetime = 0;
	res = curl_easy_getinfo(curl, CURLINFO_FILETIME, &filetime);
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
#ifdef DEBUG
	curl_easy_setopt(curl, CURLOPT_VERBOSE, true);
#endif
	DKString login = ftpName+":"+ftpPass;
	curl_easy_setopt(curl, CURLOPT_USERPWD, login.c_str() );
	curl_easy_setopt(curl, CURLOPT_URL, url.c_str());
	//curl_easy_setopt(curl, CURLOPT_HEADER, 1L);
	curl_easy_setopt(curl, CURLOPT_NOBODY, 1L);
	CURLcode res = curl_easy_perform(curl); //Perform the request, res will get the return code
	if(res != CURLE_OK)
		return DKERROR(DKString(curl_easy_strerror(res))+"\n");
	//long http_code = 0;
	//curl_easy_getinfo(curl, CURLINFO_RESPONSE_CODE, &http_code);
	//if(http_code == 200 && res != CURLE_ABORTED_BY_CALLBACK){
    //     return true;
	//}
	return true;
}

bool DKCurl::FtpFileSize(const DKString& url, long& size){
	DKDEBUGFUNC(url, size);
	//TODO
	return false;
}

bool DKCurl::FtpUpload(const DKString& file, const DKString& url){
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
#ifdef DEBUG
	curl_easy_setopt(curl, CURLOPT_VERBOSE, true);
#endif
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
	CURLcode res = curl_easy_perform(curl); //Perform the request, res will get the return code
	if(res != CURLE_OK){ 
		DKWARN(" :"+DKString(curl_easy_strerror(res))+"\n");
		DKWARN("2nd attempt.");
		res = curl_easy_perform(curl);
	}
	if(res != CURLE_OK){ 
		DKWARN(" :"+DKString(curl_easy_strerror(res))+"\n");
		DKWARN("3rd attempt.");
		res = curl_easy_perform(curl);
	}
	curl_slist_free_all(headerlist);
	fclose(hd_src); //close the local file
	if(res != CURLE_OK)
		return DKERROR(DKString(curl_easy_strerror(res))+"\n");
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
		return DKERROR("DKCurl::HttpDownload("+url+"): url not found \n");
	FILE *fp = fopen(dest.c_str(),"wb");
	if(!fp)
		return DKERROR("DKCurl::Download() *fp invalid \n");
	if(!CurlInit())
		return DKERROR("curl invalid");
#ifdef DEBUG
	curl_easy_setopt(curl, CURLOPT_VERBOSE, true);
#endif
	curl_easy_setopt(curl, CURLOPT_URL, url.c_str());
	curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1L);
    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, &DKCurl::WriteToFile);
    curl_easy_setopt(curl, CURLOPT_WRITEDATA, fp);
	curl_easy_setopt(curl, CURLOPT_NOPROGRESS, 0);
	curl_easy_setopt(curl, CURLOPT_PROGRESSFUNCTION, &DKCurl::progress_func);
	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, 0L);
	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, 0L);
	DKINFO("Downloading "+url+"...\n");
	CURLcode res = curl_easy_perform(curl); //Perform the request, res will get the return code
	fclose(fp);
	if(res != CURLE_OK)
		return DKERROR(DKString(curl_easy_strerror(res))+"\n");
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
#ifdef DEBUG
	curl_easy_setopt(curl, CURLOPT_VERBOSE, true);
#endif
	curl_easy_setopt(curl, CURLOPT_URL, url.c_str());
	curl_easy_setopt(curl, CURLOPT_NOBODY, true);
	curl_easy_setopt(curl, CURLOPT_FILETIME, true );
	curl_easy_setopt(curl, CURLOPT_USERAGENT, "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.6 (KHTML, like Gecko) Chrome/16.0.897.0 Safari/535.6");
	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, 0L);
	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, 0L);
	CURLcode res = curl_easy_perform(curl); //Perform the request, res will get the return code		
	if(res != CURLE_OK){ 
		curl_easy_cleanup(curl);
		return DKERROR("curl_easy_preform() failed \n");
	}
	const time_t filetime = 0;
	res = curl_easy_getinfo(curl, CURLINFO_FILETIME, &filetime);
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
#ifdef DEBUG
	curl_easy_setopt(curl, CURLOPT_VERBOSE, true);
#endif
	curl_easy_setopt(curl, CURLOPT_URL, _url.c_str());
	//curl_easy_setopt(curl, CURLOPT_HEADER, 1L);
	curl_easy_setopt(curl, CURLOPT_NOBODY, 1L);
	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, 0L);
	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, 0L);
	CURLcode res = curl_easy_perform(curl); //Perform the request, res will get the return code
	if(res != CURLE_OK)
		return DKERROR(DKString(curl_easy_strerror(res)) + "\n");
	long http_code = 0;
	curl_easy_getinfo(curl, CURLINFO_RESPONSE_CODE, &http_code);
	//200 = OK
	//301 = Moved Permanently
	//302 = Found
	if(http_code != 200 && http_code != 301 && http_code != 302)
		return DKERROR("CURLINFO_RESPONSE_CODE: "+toString(http_code)+"\n");
	return true;
}

bool DKCurl::HttpFileSize(const DKString& url, long& size){
	DKDEBUGFUNC(url, size);
	/*
	double length = 0.0;
	if(!curl)
		return DKERROR("curl invalid");
#ifdef DEBUG
	curl_easy_setopt(curl, CURLOPT_VERBOSE, true);
#endif
	curl_easy_setopt(curl, CURLOPT_URL, url.c_str());
	curl_easy_setopt(curl, CURLOPT_NOBODY, 1); 
	curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1);
	curl_easy_setopt(curl, CURLOPT_HEADERFUNCTION, handle_data);
	curl_easy_setopt(curl, CURLOPT_MAXREDIRS, 500);
	res = curl_easy_perform(curl);
	curl_easy_cleanup(curl);
	if(res != CURLE_OK)
		return DKERROR(DKString(curl_easy_strerror(res)) + "\n");
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
	DKString curlBuffer = "";
#ifdef DEBUG
	curl_easy_setopt(curl, CURLOPT_VERBOSE, true);
#endif
	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, false);
    curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, false);
	curl_easy_setopt(curl, CURLOPT_COOKIEFILE, /*DKApp::datapath+*/"cookies.txt");
	curl_easy_setopt(curl, CURLOPT_COOKIEJAR, /*DKApp::datapath+*/"cookies.txt");
	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, &DKCurl::WriteToBuffer);
	curl_easy_setopt(curl, CURLOPT_WRITEDATA, &curlBuffer);
	curl_easy_setopt(curl, CURLOPT_USERAGENT, "Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.6 (KHTML, like Gecko) Chrome/16.0.897.0 Safari/535.6");
	curl_easy_setopt(curl, CURLOPT_URL, _url.c_str());
	//curl_easy_setopt(curl, CURLOPT_RETURNTRANSFER, 1);
	curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, true); // example.com is redirected, so we tell libcurl to follow redirection
 	//curl_easy_setopt(curl, CURLOPT_TIMEOUT, 5000);
	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, 0L);
	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, 0L);
	CURLcode res = curl_easy_perform(curl);
	if(res != CURLE_OK)
		return DKERROR("curl_easy_preform() failed \n"); 
	output = curlBuffer;
	return true;
}

size_t DKCurl::WriteToFile(void *ptr, size_t size, size_t nmemb, FILE *stream){
	//DKDEBUGFUNC(ptr, size, nmemb, stream);
	return fwrite(ptr, size, nmemb, stream);
    //size_t written = fwrite(ptr, size, nmemb, stream);
    //return written;
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