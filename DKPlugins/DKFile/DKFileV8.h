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

#if HAVE_DKCef
#pragma once
#ifndef DKFileV8_H
#define DKFileV8_H

#include "DKCef/DKCef.h"


class DKFileV8 : public DKObjectT<DKFileV8>
{
public:
	bool Init();
	bool End();
	
	static bool ChDir(CefArgs args, CefReturn retval);
	static bool Copy(CefArgs args, CefReturn retval);
	static bool CopyFolder(CefArgs args, CefReturn retval);
	static bool Delete(CefArgs args, CefReturn retval);
	static bool DirectoryContents(CefArgs args, CefReturn retval);
	static bool Exists(CefArgs args, CefReturn retval);
	static bool FileToString(CefArgs args, CefReturn retval);
	static bool GetAbsolutePath(CefArgs args, CefReturn retval);
	static bool GetSetting(CefArgs args, CefReturn retval);
	static bool GetShortName(CefArgs args, CefReturn retval);
	static bool IsDirectory(CefArgs args, CefReturn retval);
	static bool MkDir(CefArgs args, CefReturn retval);
	static bool Rename(CefArgs args, CefReturn retval);
	static bool SetSetting(CefArgs args, CefReturn retval);
	static bool StringToFile(CefArgs args, CefReturn retval);
};

REGISTER_OBJECT(DKFileV8, false);

#endif //DKFileV8_H
#endif //HAVE_DKCef