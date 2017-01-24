#include "MyFuncs.h"

class MyClass
{
public:
	MyClass()
	{
		MyFuncs::RegisterFunc("MyClass::GetNumber",  &MyClass::GetNumber,  this);
		MyFuncs::RegisterFunc("MyClass::GetString",  &MyClass::GetString,  this);
		MyFuncs::RegisterFunc("MyClass::EditNumber", &MyClass::EditNumber, this);
		MyFuncs::RegisterFunc("MyClass::EditString", &MyClass::EditString, this);
	}

	void GetNumber(void* input, void*& output)
	{
		int var = 1234;
		output = static_cast<void*>(new int(var));             //WORKS, var eats memory
		//output = static_cast<void*>(&var);                   //ERROR, var goes out of scope
	}
	
	void GetString(void* input, void*& output)
	{
		std::string var = "Get test";
		output = static_cast<void*>(new std::string(var));     //WORKS, var eats memory
		//output = static_cast<void*>(&var);                   //ERROR, var goes out of scope
	}
	
	void EditNumber(void* input, void*& output)
	{
		int var = *static_cast<int*>(input);                   //WORKS, var gets 4321 OK
		output = static_cast<void*>(new int(var));             //WORKS, var eats memory
		//output = static_cast<void*>(&var);                   //ERROR, var goes out of scope
	}
	
	void EditString(void* input, void*& output)
	{
		std::string var = *static_cast<std::string*>(input);   //WORKS, var gets "Edit test" OK
		output = static_cast<void*>(new std::string(var));     //WORKS, var eats memory
		//output = static_cast<void*>(&var);                   //ERROR, var goes out of scope
	}
};