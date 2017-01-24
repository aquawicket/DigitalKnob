#include "MyClass.h"

void main()
{
	MyClass myclass;
	
	void* in;
	void* out;

	MyFuncs::CallFunc("MyClass::GetNumber", NULL, out);  //atempting to fill the variable
	int getNumOut = *static_cast<int*>(out);
	printf("MyClass::GetNumber = %d \n", getNumOut);
	
	MyFuncs::CallFunc("MyClass::GetString", NULL, out);  //atempting to fill the variable
	std::string getStrOut = *static_cast<std::string*>(out);
	printf("MyClass::GetString = %s \n", getStrOut.c_str());
	
	int editNum = 4321;
	in = static_cast<void*>(&editNum);
	MyFuncs::CallFunc("MyClass::EditNumber", in, out);  //atempting to fill the variable
	int editNumOut = *static_cast<int*>(out);
	printf("MyClass::EditNumber = %d \n", editNumOut);
	
	std::string editStr = "Edit test";
	in = static_cast<void*>(&editStr);
	MyFuncs::CallFunc("MyClass::EditString", in, out);  //atempting to fill the variable
	std::string editStrOut = *static_cast<std::string*>(out);
	printf("MyClass::EditString = %s \n", editStrOut.c_str());

	//wait for close
	getchar();
}
