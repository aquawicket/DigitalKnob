#include "stdafx.h"
#include "DKString.h"
#include "DKLog.h"

////////////////////////////////////////////////////
bool same(const DKString& str, const DKString& str2)
{
	if(str.compare(str2) == 0){
		return true;
	}
	return false;
}

/////////////////////////////////////////////////////
bool samei(const DKString& str, const DKString& str2)
{
	DKString temp1 = str;
	std::transform(temp1.begin(), temp1.end(), temp1.begin(), ::tolower);
	DKString temp2 = str2;
	std::transform(temp2.begin(), temp2.end(), temp2.begin(), ::tolower);
	if(same(temp1, temp2)){
		return true;
	}
	return false;
}

///////////////////////////////////////////////////
bool has(const DKString& str, const DKString& str2)
{
	int found = str.find(str2);
	if(found!=std::string::npos){
		return true;
	}
	return false;
}

/////////////////////////////////
DKString toString(const int& num)
{
	DKString s;
	std::stringstream out;
	out << num;
	s = out.str();
	return s;
}

//////////////////////////////////////////
DKString toString(const unsigned int& num)
{
	DKString s;
	std::stringstream out;
	out << num;
	s = out.str();
	return s;
}

//////////////////////////////////
DKString toString(const long& num)
{
	DKString s;
	std::stringstream out;
	out << num;
	s = out.str();
	return s;
}

////////////////////////////////////////////////////
DKString toString(const unsigned long long int& num)
{
	DKString s;
	std::stringstream out;
	out << num;
	s = out.str();
	return s;
}

///////////////////////////////////
DKString toString(const float& num)
{
	//if(!num){return "";}
	DKString s;
	std::stringstream out;
	out << num;
	s = out.str();
	return s;
}

////////////////////////////////////
DKString toString(const double& num)
{
	DKString s;
	std::stringstream out;
	out << num;
	s = out.str();
	return s;
}

//////////////////////////////////
DKString toString(const char* str)
{
	return str;
}

/////////////////////////////////////
DKString toString(unsigned char* str) 
{
	return reinterpret_cast<char const*>(str);
}

////////////////////////////
DKString toString(void* ptr)
{
	DKString *p = static_cast<DKString*>(ptr);
	DKString string = *p;
	return string;
}

/////////////////////////////
DKString toString(bool _bool)
{
	if(_bool){
		return "true";
	}
	return "false";
}

#ifdef WIN32
/////////////////////////////////////////
DKString toString(const std::wstring& ws)
{
	int len;
    int slength = (int)ws.length();// + 1;
    len = WideCharToMultiByte(CP_ACP, 0, ws.c_str(), slength, 0, 0, 0, 0); 
    std::string s(len, '\0');
    WideCharToMultiByte(CP_ACP, 0, ws.c_str(), slength, &s[0], len, 0, 0); 
	//replace(s,"\0","");
    return s;
}
#endif // WIN32 || WIN64

///////////////////////////////////////////////////////////////////
DKString toString(const DKStringArray& arry, const char* seperator)
{
	DKString string = "";
	for(unsigned int i=0; i<arry.size(); ++i){
		string += arry[i];
		if(i < arry.size()-1){
			string += seperator;
		}
	}
	return string;
}

/*
//////////////////////////////////////////////////////////////////////////////////////
bool ArrayToString(const DKStringArray& arry, DKString& string, const char* seperator)
{
	string = "";
	for(unsigned int i=0; i<arry.size(); ++i){
		string += arry[i];
		if(i < arry.size()-1){
			string += seperator;
		}
	}
	return true;
}
*/

///////////////////////////////////////////////////////////////////////////
bool replace(DKString& str, const DKString& oldStr, const DKString& newStr)
{
  size_t pos = 0;
  while((pos = str.find(oldStr, pos)) != std::string::npos)
  {
     str.replace(pos, oldStr.length(), newStr);
     pos += newStr.length();
  }
  return true;
}

/////////////////////////////////////////////////////////////////////////////////
bool replace_first(DKString& str, const DKString& oldStr, const DKString& newStr)
{
  size_t pos = 0;
  if((pos = str.find(oldStr, pos)) != std::string::npos)
  {
     str.replace(pos, oldStr.length(), newStr);
     pos += newStr.length();
  }
  return true;
}

////////////////////////////////
long toLong(const DKString& str)
{
#if defined(WIN32) || defined(MAC)
	return atol(str.c_str());
#endif 
    DKLog("toLong() not implemented for this OS \n", DKERROR);
	return false;
}

///////////////////////////////////////////////////
unsigned long long int toULongLong(const DKString& str)
{
#if defined(WIN32) || defined(MAC)
	//return atol(str.c_str());
	return strtoull(str.c_str(), NULL, 0);
#endif 
    DKLog("toULongLong() not implemented for this OS \n", DKERROR);
	return false;
}

//////////////////////////////
int toInt(const DKString& str)
{
	int value = atoi(str.c_str());
	return value;
}

////////////////////////////////////////
unsigned int toUInt(const DKString& str)
{
	int value = atoi(str.c_str());
	return value;
}

/////////////////////////////////////
float toFloat(const DKString& string)
{
	float value = (float)atof(string.c_str());
	return value;
}

/////////////////////////////////////
bool IsNumber(const DKString& string)
{
    std::string::const_iterator it = string.begin();
    while (it != string.end() && std::isdigit(*it)) ++it;
    return !string.empty() && it == string.end();
}

///////////////////////////////////////////////////
bool Pad(int num, char character, DKString& string)
{
	std::ostringstream ss;
	ss << std::setw(num) << std::setfill(character) << string;
	string = ss.str();
	return true;
}

//////////////////////////////////////////
bool RemoveDuplicates(DKStringArray& arry)
{
	sort( arry.begin(), arry.end() );
	arry.erase( unique( arry.begin(), arry.end() ), arry.end() );
	return true;
}

///////////////////////////////////////////////////////////////////////////////////////////////
bool getSettingFromString(const DKString& filestring, const DKString& setting, DKString& value)
{
	//If the variable looks like this: [VARIABLE]
	//then we return everything up to the next [VARIABLE] or to the end of the file.
	if(has(setting,"[") && has(setting,"]")){
		size_t temp = filestring.find(setting,0);
        if(temp == std::string::npos){return false;}
		size_t start = filestring.find("]",temp);
		size_t end = filestring.find("[",start);
		if(end == std::string::npos){end = filestring.size();}

		DKString out = filestring.substr(start+1, end-start-1);

		replace(out,"\r","");
		replace(out,"\n"," ");
		Trim(out);
		value = out;
		return true;
	}

	//If the variable looks like this:  VARIABLE 
	//then we return the rest of the line
	DKString string = setting + " ";

	size_t temp = filestring.find(string,0);
    if(temp == std::string::npos){return false;}
	size_t start = filestring.find(" ",temp);
	size_t end = filestring.find("\n",start);

	DKString out = filestring.substr(start+1, end-start-1);
	replace(out,"\r","");
	replace(out,"\n","");
	Trim(out);
	value = out;
	return true;
}

/*
////////////////////////////////////////////////////////////////////////////////////////
DKStringArray getSettingsFromString(const DKString& filestring, const DKString& setting)
{
	if(has(setting,"[") && has(setting,"]")){
		size_t temp = filestring.find(setting,0);
#ifndef ANDROID
        if(temp == std::string::npos){return DKStringArray(0);}
#else
		if(temp == std::string::npos){
			DKStringArray temp;
			return temp;
		}
#endif
		size_t start = filestring.find("]",temp);
		size_t end = filestring.find("[",start);
		if(end == std::string::npos){end = filestring.size();}

		DKString out = filestring.substr(start+1, end-start-1);
		//ok now each one into array
		DKStringArray outs;
		int begin = 1;

		while(1){
			int end = out.find("\n",begin);
			if(end==std::string::npos){return outs;}
			DKString string = out.substr(begin, end-begin);
			replace(string,"\r","");
			replace(string,"\n"," ");
			Trim(string);
			if(!same(string,"")){
				outs.push_back(string);
			}
			begin=end+1;
		}
	}
#ifndef ANDROID
        return DKStringArray(0);
#else
		DKStringArray temp;
		return temp;
#endif
}
*/

///////////////////////////
bool Trim(DKString& string)
{
	string.erase(string.begin(), std::find_if(string.begin(), string.end(), std::not1(std::ptr_fun<int, int>(std::isspace))));
	string.erase(std::find_if(string.rbegin(), string.rend(), std::not1(std::ptr_fun<int, int>(std::isspace))).base(), string.end());
	return true;
}


////////////////////////////////////////////////////////////////////////////////////////////
bool toStringArray(DKStringArray& output, const DKString& string, const DKString& seperator)
{
	//FIXME - while(1) loops are dangerous 
	DKString text = string + seperator; //add a seperator at the end, or we won't get the last variable

	int begin = 0;
	while(1){
		int end = text.find(seperator, begin);
		if(end==std::string::npos){return true;}
		DKString temp = text.substr(begin, end-begin);
		replace(temp,"\r","");
		replace(temp,"\n"," ");
		replace(temp,seperator,"");
		Trim(temp);
		output.push_back(temp);
		begin=end+1;
	}

	if(output[output.size()-1].empty()){ //if last one empty
		output.erase(output.begin()+output.size()-1);
	}
}

///////////////////////////////////////
DKString toLower(const DKString& input)
{
    DKString output = input;
    std::transform( output.begin(), output.end(), output.begin(), ::tolower );
    return output;
}

#ifdef WIN32
////////////////////////////////////////////
std::wstring toWString(const std::string& s)
{
	int len;
	int slength = (int)s.length() + 1;
	len = MultiByteToWideChar(CP_ACP, 0, s.c_str(), slength, 0, 0);
	wchar_t* buf = new wchar_t[len];
	MultiByteToWideChar(CP_ACP, 0, s.c_str(), slength, buf, len);
	std::wstring r(buf);
	delete[] buf;
	return r;
}
#endif