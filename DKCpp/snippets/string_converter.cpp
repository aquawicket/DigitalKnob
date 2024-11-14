#include <cstdlib>
#include <iostream>
#include <string>

using namespace std;

wstring StringToWString(const string& str)
{
	wstring wstr;
	size_t size;
	wstr.resize(str.length());
	mbstowcs_s(&size,&wstr[0],wstr.size()+1,str.c_str(),str.size());
	return wstr;
}

string WStringToString(const wstring& wstr)
{
	string str;
	size_t size;
	str.resize(wstr.length());
	wcstombs_s(&size, &str[0], str.size() + 1, wstr.c_str(), wstr.size());
	return str;
}

int main()
{
	string str;
	cin >> str;
	wstring wstr;
	wstr = StringToWString(str);
	wcout << wstr << endl;
	//test
	cout << "wstring::::" << endl;
	//
	wcin >> wstr;
	str = WStringToString(wstr);
	cout << str << endl;
	cout << endl;
	return 0;
}