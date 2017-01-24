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

	void GetNumber(void* input, void* output)
	{
		//output = 123;
	}
	
	void GetString(void* input, void* output)
	{
		//output = "Get Test";
	}
	
	void EditNumber(void* input, void* output)
	{
		//output = input
		//TODO: alter output
	}
	
	void EditString(void* input, void* output)
	{
		//output = input;
		//TODO: alter output
	}
};