#include "MyFuncs.h"

struct MyStruct{
	int num;
	std::string name;
};

class MyClass
{
public:
	MyClass()
	{
		MyFuncs::RegisterFunc("MyClass::GetNumber",  &MyClass::GetNumber,  this);
		MyFuncs::RegisterFunc("MyClass::GetString",  &MyClass::GetString,  this);
		MyFuncs::RegisterFunc("MyClass::GetPointer", &MyClass::GetPointer, this);
		MyFuncs::RegisterFunc("MyClass::EditNumber", &MyClass::EditNumber, this);
		MyFuncs::RegisterFunc("MyClass::EditString", &MyClass::EditString, this);
		MyFuncs::RegisterFunc("MyClass::EditPointer", &MyClass::EditPointer, this);
	}

	void GetNumber(void* input, void* output)
	{
		int var = 1234;
		*(int*)output = var;
	}
	
	void GetString(void* input, void* output)
	{
		std::string var = "Get String";
		*(std::string*)output = var;
	}

	void GetPointer(void* input, void* output)
	{
		MyStruct mystruct;
		mystruct.num = 65;
		mystruct.name = "Get Pointer";
		MyStruct* mypoint = &mystruct;

	    *(MyStruct*)output = *mypoint;
	}
	
	void EditNumber(void* input, void* output)
	{
		int in = *(int*)input; //4321
		int out = in - 4320;   //result is 1;
		*(int*)output = out;
	}
	
	void EditString(void* input, void* output)
	{
		std::string in = *(std::string*)input; //"Edit Test"
		std::string out = in += " (edited)";   //result is "Edit test (edited)"
		*(std::string*)output = out;
	}

	void EditPointer(void* input, void* output)
	{
		MyStruct* in = (MyStruct*)input;
		
		MyStruct* out = in;
		out->num = out->num + 2;
		out->name = out->name += " (edited)";

		*(MyStruct*)output = *out;
	}
};