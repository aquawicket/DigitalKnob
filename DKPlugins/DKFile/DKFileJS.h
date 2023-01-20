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

#ifdef HAVE_DKDuktape 
#pragma once
#ifndef DKFileJS_H
#define DKFileJS_H

#include "DKDuktape/DKDuktape.h"


class DKFileJS : public DKObjectT<DKFileJS>
{
public:
	bool Init();
	
	static int ChDir(duk_context* ctx);
	static int Copy(duk_context* ctx);
	static int CopyFolder(duk_context* ctx);
	static int Delete(duk_context* ctx);
	static int DirectoryContents(duk_context* ctx);
	static int Exists(duk_context* ctx);
	static int FileToString(duk_context* ctx);
	static int GetAbsolutePath(duk_context* ctx);
	static int GetDrives(duk_context* ctx);
	static int GetExeName(duk_context* ctx);
	static int GetExePath(duk_context* ctx);
	static int GetExtention(duk_context* ctx);
	static int GetFilename(duk_context* ctx);
	static int GetLocalCreationDate(duk_context* ctx);
	static int GetLocalModifiedDate(duk_context* ctx);
	static int GetModifiedTime(duk_context* ctx);
	static int GetPath(duk_context* ctx);
	static int GetPaths(duk_context* ctx);
	static int GetRelativePath(duk_context* ctx);
	static int GetSetting(duk_context* ctx);
	static int GetShortName(duk_context* ctx);
	static int IsDirectory(duk_context* ctx);
	static int MkDir(duk_context* ctx);
	static int Rename(duk_context* ctx);
	static int SetSetting(duk_context* ctx);
	static int StringToFile(duk_context* ctx);
	static int VerifyPath(duk_context* ctx);
};

REGISTER_OBJECT(DKFileJS, true)
#endif //DKFileJS_H
#endif //HAVE_DKDuktape