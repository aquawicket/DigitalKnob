#ifdef USE_DKCef
#pragma once
#ifndef DKCurlV8_H
#define DKCurlV8_H

#include "DKCef/DKCef.h"

///////////////////////////////////////////
class DKCurlV8 : public DKObjectT<DKCurlV8>
{
public:
	bool Init();
	bool End();

	static bool Download(CefArgs args, CefReturn retval);
	static bool FileDate(CefArgs args, CefReturn retval);
	static bool FtpConnect(CefArgs args, CefReturn retval);
	static bool FtpUpload(CefArgs args, CefReturn retval);
	static bool GetExternalIP(CefArgs args, CefReturn retval);
	static bool HttpFileExists(CefArgs args, CefReturn retval);
	static bool HttpToString(CefArgs args, CefReturn retval);
};

REGISTER_OBJECT(DKCurlV8, false);

#endif //DKCurlV8_H
#endif //USE_DKCef