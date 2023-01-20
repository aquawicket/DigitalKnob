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

#ifdef HAVE_DKCef
#include "DK/DKApp.h"
#include "DK/DKFile.h"
#include "DKFile/DKFileV8.h"


bool DKFileV8::Init(){
	DKDEBUGFUNC();
	DKV8::AttachFunction("DKFile_ChDir", DKFileV8::ChDir);
	DKV8::AttachFunction("DKFile_Copy", DKFileV8::Copy);
	DKV8::AttachFunction("DKFile_CopyFolder", DKFileV8::CopyFolder);
	DKV8::AttachFunction("DKFile_Delete", DKFileV8::Delete);
	DKV8::AttachFunction("DKFile_DirectoryContents", DKFileV8::DirectoryContents);
	DKV8::AttachFunction("DKFile_Exists", DKFileV8::Exists);
	DKV8::AttachFunction("DKFile_FileToString", DKFileV8::FileToString);
	DKV8::AttachFunction("DKFile_GetAbsolutePath", DKFileV8::GetAbsolutePath);
	DKV8::AttachFunction("DKFile_GetSetting", DKFileV8::GetSetting);
	DKV8::AttachFunction("DKFile_GetShortName", DKFileV8::GetShortName);
	DKV8::AttachFunction("DKFile_IsDirectory", DKFileV8::IsDirectory);
	DKV8::AttachFunction("DKFile_MkDir", DKFileV8::MkDir);
	DKV8::AttachFunction("DKFile_Rename", DKFileV8::Rename);
	DKV8::AttachFunction("DKFile_SetSetting", DKFileV8::SetSetting);
	DKV8::AttachFunction("DKFile_StringToFile", DKFileV8::StringToFile);
	return true;
}


bool DKFileV8::End(){
	DKDEBUGFUNC();
	return true;
}

bool DKFileV8::ChDir(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	DKString path = args->GetString(0);
	DKFile::ChDir(path);
	return true;
}

bool DKFileV8::Copy(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	//DKString src = args[0]->GetStringValue();
	DKString src = args->GetString(0);
	//DKString dest = args[1]->GetStringValue();
	DKString dest = args->GetString(1);
	//bool overwrite = args[2]->GetBoolValue();
	bool overwrite = args->GetBool(2);
	if(!DKFile::Copy(src, dest, overwrite, true))
		return DKERROR("DKFile::Copy() failed! \n");
	return true;
}

bool DKFileV8::CopyFolder(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	//DKString src = args[0]->GetStringValue();
	DKString src = args->GetString(0);
	//DKString dst = args[1]->GetStringValue();
	DKString dst = args->GetString(1);
	//bool overwrite = args[2]->GetBoolValue();
	bool overwrite = args->GetBool(2);
	//bool recursive = args[3]->GetBoolValue();
	bool recursive = args->GetBool(3);
	DKINFO("CopyFolder(" + src + "," + dst + "," + toString(overwrite) + "," + toString(recursive) + ")\n");
	if (!DKFile::CopyFolder(src, dst, overwrite, recursive))
		return DKERROR("DKFile::CopyFolder(): failed. \n");
	return true;
}

bool DKFileV8::Delete(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	//DKString path = args[0]->GetStringValue();
	DKString path = args->GetString(0);
	DKFile::Delete(path);
	return true;
}

bool DKFileV8::DirectoryContents(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	//DKString path = args[0]->GetStringValue();
	DKString path = args->GetString(0);
	//DKINFO("DKFileV8::DirectoryContents("+path+",CefReturn)\n");
	DKStringArray arry;
	if(!DKFile::GetDirectoryContents(path, arry))
		return true;
	DKString string = toString(arry, ",");
	//retval = CefV8Value::CreateString(string);
	retval->SetString(0, string);
	return true;
}

bool DKFileV8::Exists(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	//DKString path = args[0]->GetStringValue();
	DKString path = args->GetString(0);
	if(!DKFile::PathExists(path)){
		//retval = CefV8Value::CreateBool(false);
		retval->SetBool(0, false);
		return true; 
	}
	//retval = CefV8Value::CreateBool(true);
	retval->SetBool(0, true);
	return true;
}

bool DKFileV8::FileToString(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	//DKString path = args[0]->GetStringValue();
	DKString path = args->GetString(0);
	DKString string;
	if (!DKFile::FileToString(path, string))
		return DKERROR("DKFile::FileToString() failed! \n");
	//retval = CefV8Value::CreateString(string);
	retval->SetString(0, string);
	return true;
}

bool DKFileV8::GetAbsolutePath(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	//DKString path = args[0]->GetStringValue();
	DKString path = args->GetString(0);
	//DKINFO("DKFileV8::GetAbsolutePath("+path+",CefReturn)\n");
	DKString aPath;
	if(!DKFile::GetAbsolutePath(path, aPath))
		return DKERROR("DKFile::GetAbsolutePath() failed! \n");
	//retval = CefV8Value::CreateString(aPath);
	retval->SetString(0, aPath);
	return true;
}

bool DKFileV8::GetSetting(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	//DKString file = args[0]->GetStringValue();
	DKString file = args->GetString(0);
	//DKString param = args[1]->GetStringValue();
	DKString param = args->GetString(1);
	DKString value;
	if(!DKFile::GetSetting(file, param, value))
		return true;
	//retval = CefV8Value::CreateString(value);
	retval->SetString(0, value);
	return true;
}

bool DKFileV8::GetShortName(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	//DKString path = args[0]->GetStringValue();
	DKString path = args->GetString(0);
	//DKINFO("DKFileV8::GetShortName("+path+",CefReturn)\n");
#if WIN
	DKString shortname;
	if(DKFile::GetShortName(path, shortname)){
		//retval = CefV8Value::CreateString(shortname);
		retval->SetString(0, shortname);
		return true;
	}
#endif
	//retval = CefV8Value::CreateString(path);
	retval->SetString(0, path);
	return true;
}

bool DKFileV8::IsDirectory(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	//DKString path = args[0]->GetStringValue();
	DKString path = args->GetString(0);
	//DKINFO("DKFileV8::IsDirectory("+path+",CefReturn)\n");
	if(!DKFile::IsDirectory(path)){
		//retval = CefV8Value::CreateBool(false);
		retval->SetBool(0, false);
		return true;
	}
	//retval = CefV8Value::CreateBool(true);
	retval->SetBool(0, true);
	return true;
}

bool DKFileV8::MkDir(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	//DKString path = args[0]->GetStringValue();
	DKString path = args->GetString(0);
	DKFile::MakeDir(path);
	return true;
}

bool DKFileV8::Rename(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	//DKString input = args[0]->GetStringValue();
	DKString input = args->GetString(0);
	//DKString output = args[1]->GetStringValue();
	DKString output = args->GetString(1);
	//bool overwrite = args[2]->GetBoolValue();
	bool overwrite = args->GetBool(2);
	if(!DKFile::Rename(input, output, overwrite)){
		return DKERROR("DKFile::Rename() failed! \n");
	}
	return true;
}

bool DKFileV8::SetSetting(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	//DKString file = args[0]->GetStringValue();
	DKString file = args->GetString(0);
	//DKString param = args[1]->GetStringValue();
	DKString param = args->GetString(1);
	//DKString value = args[2]->GetStringValue();
	DKString value = args->GetString(2);
	if(!DKFile::SetSetting(file, param, value))
		return DKERROR("DKFile::SetSetting() failed! \n")
	return true;
}

bool DKFileV8::StringToFile(CefArgs args, CefReturn retval){
	DKDEBUGFUNC(args, retval);
	//DKString string = args[0]->GetStringValue();
	DKString string = args->GetString(0);
	//DKString file = args[1]->GetStringValue();
	DKString file = args->GetString(1);
	if(!DKFile::StringToFile(string, file))
		return DKERROR("DKFile::StringToFile() failed! \n");
	return true;
}

#endif //HAVE_DKCef
