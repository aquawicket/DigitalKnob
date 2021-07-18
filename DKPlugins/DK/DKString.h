#pragma once
#ifndef DKString_H
#define DKString_H

#ifdef WIN32
#include "windows.h"
#endif

#include <cstdio>  
#include <vector>
#include <string>
#include <sstream>
#include <iomanip>  //std::setw
#include <algorithm>
#include <functional> 
#include <cctype>
#include <locale>
#include <stdio.h>
#include <stdlib.h>

#ifdef _MSC_VER
//#define strtoll _strtoi64
//#define strtoull _strtoui64
#endif

typedef std::string DKString;
typedef std::vector<DKString> DKStringArray;
typedef std::vector<DKStringArray> DKStringGrid;

bool same(const DKString& str, const DKString& str2);
bool samei(const DKString& str, const DKString& str2); //case insensitive
bool has(const DKString& str, const DKString& str2);
bool Trim(DKString& str);
DKString toString(const int& num);
DKString toString(const unsigned int& num);
DKString toString(const long& num);
DKString toString(const unsigned long int& num);
DKString toString(const unsigned long long int& num);
DKString toString(const float& num);
DKString toString(const double& num); 
DKString toString(const char* str);
DKString toString(unsigned char* str);
DKString toString(void* ptr);
DKString toString(bool _bool);
DKString toString(const DKStringArray& arry, const char* seperator);
#ifdef WIN32
	DKString toString(const HWND hwnd);
#endif

long toLong(const DKString& str);
unsigned long long int toULongLong(const DKString& str);
int toInt(const DKString& str);
bool toBool(const DKString& str);
unsigned int toUInt(const DKString& str);
float toFloat(const DKString& str);
#ifdef WIN32
	HWND toHWND(const DKString& str);
#endif
bool replace(DKString& str, const DKString& oldStr, const DKString& newStr);
bool replace_first(DKString& str, const DKString& oldStr, const DKString& newStr);
bool IsNumber(const DKString& str);
bool Pad(int num, char character, DKString& str); 

#ifdef WIN32
DKString toString(const std::wstring& ws);
std::wstring toWString(const DKString& str);
#endif

//bool ArrayToString(const DKStringArray& arry, DKString& str, const char* seperator);
bool RemoveDuplicates(DKStringArray& arry);
bool getSettingFromString(const DKString& filestring, const DKString& setting, DKString& value);
//DKStringArray getSettings(const DKString& file, const DKString& setting);
//DKStringArray getSettingsFromString(const DKString& filestring, const DKString& setting);
bool toStringArray(DKStringArray& output, const DKString& str, const DKString& seperator);
DKString toLower(const DKString& input);
#endif //DKString_H