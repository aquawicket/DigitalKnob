#ifdef USE_DKCef
#include "DK/DKApp.h"
#include "DKCurl/DKCurl.h"
#include "DKCurl/DKCurlV8.h"

/////////////////////
bool DKCurlV8::Init()
{
	DKLog("DKCurlV8::Init()\n", DKDEBUG);
	DKV8::AttachFunction("DKCurl_Download", DKCurlV8::Download);
	DKV8::AttachFunction("DKCurl_FileDate", DKCurlV8::FileDate);
	DKV8::AttachFunction("DKCurl_FtpConnect", DKCurlV8::FtpConnect);
	DKV8::AttachFunction("DKCurl_FtpUpload", DKCurlV8::FtpUpload);
	DKV8::AttachFunction("DKCurl_HttpFileExists", DKCurlV8::HttpFileExists);
	DKV8::AttachFunction("DKCurl_HttpToString", DKCurlV8::HttpToString);
	return true;
}

////////////////////
bool DKCurlV8::End()
{
	DKLog("DKCurlV8::End()\n", DKDEBUG);
	return true;
}

///////////////////////////////////////////////////////
bool DKCurlV8::Download(CefArgs args, CefReturn retval)
{
	DKString url = args->GetString(0);
	DKString dest = args->GetString(1);
	if(!DKCurl::Get("DKCurl0")->Download(url, dest)){
		return false;
	}
	return true;
}

///////////////////////////////////////////////////////
bool DKCurlV8::FileDate(CefArgs args, CefReturn retval)
{
	DKString url = args->GetString(0);
	DKString filedate;
	if(!DKCurl::Get("DKCurl0")->FileDate(url, filedate)){
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
	DKString server = args->GetString(0);
	DKString name = args->GetString(1);
	DKString pass = args->GetString(2);
	DKString port = args->GetString(3);

	if(!DKCurl::Get("DKCurl0")->FtpConnect(server, name, pass, port)){
		return false;
	}
	return true;
}

////////////////////////////////////////////////////////
bool DKCurlV8::FtpUpload(CefArgs args, CefReturn retval)
{
	DKString file = args->GetString(0);
	DKString url = args->GetString(1);
	if(!DKCurl::Get("DKCurl0")->FtpUpload(file, url)){
		return false;
	}
	//DKQueue("FtpUpload", boost::bind(&DKCurl::FtpUpload, DKCurl::Get("DKCurl0"), file, url));
	return true;
}

/////////////////////////////////////////////////////////////
bool DKCurlV8::HttpFileExists(CefArgs args, CefReturn retval)
{
	DKString url = args->GetString(0);
	if(!DKCurl::Get("DKCurl0")->HttpFileExists(url)){
		return false;
	}
	return true;
}

///////////////////////////////////////////////////////////
bool DKCurlV8::HttpToString(CefArgs args, CefReturn retval)
{
	DKString url = args->GetString(0);
	DKString output;
	if(!DKCurl::Get("DKCurl0")->HttpToString(url, output)){
		return 0;
	}
	if(!retval->SetString(0, output)){ return false; }
	return true;
}

/*
////////////////////////////////////////////////////////////
bool DKCurlV8::GetMidiInputs(CefArgs args, CefReturn retval)
{
	DKCurl::Instance("DKCurl");
	DKStringArray inputs;
	DKCurl::Instance("DKCurl")->GetInputs(inputs);
	DKString final = toString(inputs,",");
	if(!retval->SetString(0, final)){ return false; }
	return true;
}

/////////////////////////////////////////////////////////////
bool DKCurlV8::GetMidiOutputs(CefArgs args, CefReturn retval)
{
	DKCurl::Instance("DKCurl");
	DKStringArray outputs;
	DKCurl::Instance("DKCurl")->GetOutputs(outputs);
	DKString final = toString(outputs,",");
	if(!retval->SetString(0, final)){ return false; }
	return true;
}

///////////////////////////////////////////////////////
bool DKCurlV8::SendMidi(CefArgs args, CefReturn retval)
{
	int var1 = args->GetInt(0);
	int var2 = args->GetInt(1);
	int var3 = args->GetInt(2);

	std::vector<unsigned char> message;
	message.push_back(var1);
	message.push_back(var2);
	message.push_back(var3);
	DKCurl::Instance("DKCurl")->midiout->sendMessage(&message);
	return true;
}

//////////////////////////////////////////////////////////////
bool DKCurlV8::ToggleMidiInput(CefArgs args, CefReturn retval)
{
	DKString input = args->GetString(0);
	if(!DKCurl::Instance("DKCurl")->ToggleInput(input)){ return false; }
	return true;
}

///////////////////////////////////////////////////////////////
bool DKCurlV8::ToggleMidiOutput(CefArgs args, CefReturn retval)
{
	DKString output = args->GetString(0);
	if(!DKCurl::Instance("DKCurl")->ToggleOutput(output)){ return false; }
	return true;
}
*/

#endif //USE_DKCef