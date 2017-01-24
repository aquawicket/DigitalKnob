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
		int val = 1234;
		output = static_cast<void*>(new int(val));             //WORKS, val eats memory
		//output = static_cast<void*>(&val);                   //val goes out of scope
	}
	
	void GetString(void* input, void*& output)
	{
		std::string val = "Get test";
		output = static_cast<void*>(new std::string(val));     //WORKS, val eats memory
		//output = static_cast<void*>(&val);                   //val goes out of scope
	}
	
	void EditNumber(void* input, void*& output)
	{
		int val = *static_cast<int*>(input);                   //val gets 4321 OK
		//output = static_cast<void*>(new int(val));           //WORKS, val eats memory
		output = static_cast<void*>(&val);                     //val goes out of scope
	}
	
	void EditString(void* input, void*& output)
	{
		std::string val = *static_cast<std::string*>(input);   //val gets "Edit test" OK
		//output = static_cast<void*>(new std::string(val));   //WORKS, val eats memory
		output = static_cast<void*>(&val);                     //val goes out of scope
	}
};