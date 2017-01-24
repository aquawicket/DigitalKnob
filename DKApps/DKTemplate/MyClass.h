#include "MyFuncs.h"

class MyClass
{
public:
	MyClass()
	{
		MyFuncs::RegisterFunc("MyClass::GetNumber", &MyClass::GetNumber, this);
		MyFuncs::RegisterFunc("MyClass::GetString", &MyClass::GetString, this);
		MyFuncs::RegisterFunc("MyClass::EditNumber", &MyClass::EditNumber, this);
		MyFuncs::RegisterFunc("MyClass::EditString", &MyClass::EditString, this);
	}

	void GetNumber(void* input, void*& output)
	{
		int val = 123;
		output = static_cast<void*>(new int(val));
	}
	
	void GetString(void* input, void*& output)
	{
		std::string val = "Get test";
		output = static_cast<void*>(new std::string(val));
	}
	
	void EditNumber(void* input, void*& output)
	{
		//output = input
		//TODO: alter output
	}
	
	void EditString(void* input, void*& output)
	{
		//output = input;
		//TODO: alter output
	}
};