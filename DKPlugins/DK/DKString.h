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

// https://www.drdobbs.com/cpp/how-non-member-functions-improve-encapsu/184401197


#pragma once
#ifndef DKString_H
#define DKString_H

#define _SILENCE_CXX17_CODECVT_HEADER_DEPRECATION_WARNING //silence <codecvt> deprecation warnings

WARNING_DISABLE
#if WIN
#include "windows.h"
#endif
#include <cstdio>  
#include <vector>
#include <string>
#include <sstream>
#include <iomanip>  //std::setw
#include <algorithm>
#include <functional> 
//#include <cctype>
#include <locale>
#include <stdio.h>
#include <stdlib.h>
WARNING_ENABLE

/*
#ifdef _MSC_VER //Visual Studio Compiler
#define strtoll _strtoi64
#define strtoull _strtoui64
#endif
*/

typedef std::string DKString;
typedef std::vector<DKString> DKStringArray;
typedef std::vector<DKStringArray> DKStringGrid;

bool same(const DKString& str, const DKString& str2);
bool samei(const DKString& str, const DKString& str2); //case insensitive
bool has(const DKString& search, const DKString& forthis);
int substr_count(const DKString& search, const DKString& forthis);

// https://www.cplusplus.com/reference/string/to_string/
DKString toString(const int& _int);
DKString toString(const long& _long);
DKString toString(const float& _float);
DKString toString(const double& _double);
DKString toString(const unsigned int& _uint);
DKString toString(const unsigned long int& _ulongint);
DKString toString(const unsigned long long int& _ulonglongint);

DKString toString(const bool _bool);
DKString toString(const char* _charptr);
DKString toString(const unsigned char* _uchar);
DKString toString(void* _voidptr);
DKString toString(const DKStringArray& arry, const char* seperator);
DKString toLower(const DKString& str);
DKString toUpper(const DKString& str);
DKString toString(const std::wstring& _wstring);
#if WIN
DKString toString(const HWND hwnd);
#endif

//https://stackoverflow.com/questions/216823/whats-the-best-way-to-trim-stdstring
DKString& rtrim(DKString& str, const char* t = " \t\n\r\f\v"); // trim from end of string (right)
DKString& ltrim(DKString& str, const char* t = " \t\n\r\f\v"); // trim from beginning of string (left)
DKString& trim(DKString& str, const char* t = " \t\n\r\f\v"); // trim from both ends of string (right then left)

bool toBool(const DKString& str);
int toInt(const DKString& str);
long toLong(const DKString& str);
float toFloat(const DKString& str);
unsigned int toUInt(const DKString& str);
unsigned long toULong(const DKString& str);
unsigned long long int toULongLong(const DKString& str);
std::wstring toWString(const DKString& str);
#if WIN
HWND toHWND(const DKString& str);
#endif

bool replace(DKString& str, const DKString& find, const DKString& replace);
bool replace_first(DKString& str, const DKString& find, const DKString& replace);
bool IsNumber(const DKString& str);
bool Pad(int num, char character, DKString& str); 

bool RemoveDuplicates(DKStringArray& arry);
bool getSettingFromString(const DKString& str, const DKString& setting, DKString& value);
bool toStringArray(DKStringArray& arry, const DKString& str, const DKString& seperator);
//bool ArrayToString(const DKStringArray& arry, DKString& str, const char* seperator);
//DKStringArray getSettingsFromString(const DKString& filestring, const DKString& setting);

#endif //DKString_H