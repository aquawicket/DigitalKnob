#include "MyClass.h"

void main()
{
	MyClass myclass;
	
	void* getNum;
	MyFuncs::CallFunc("MyClass::GetNumber", NULL, getNum);  //atempting to fill the variable
	int getNumOut = *static_cast<int*>(getNum);
	printf("MyClass::GetNumber = %d \n", getNumOut);
	
	void* getStr;
	MyFuncs::CallFunc("MyClass::GetString", NULL, getStr);  //atempting to fill the variable
	std::string getStrOut = *static_cast<std::string*>(getStr);
	printf("MyClass::GetString = %s \n", getStrOut.c_str());
	
	void* editNum;
	MyFuncs::CallFunc("MyClass::EditNumber", NULL, editNum);  //atempting to fill the variable
	int editNumOut = *static_cast<int*>(editNum);
	printf("MyClass::EditNumber = %d \n", editNumOut);
	
	void* editStr;
	MyFuncs::CallFunc("MyClass::EditString", NULL, editStr);  //atempting to fill the variable
	std::string editStrOut = *static_cast<std::string*>(editStr);
	printf("MyClass::EditString = %s \n", editStrOut.c_str());

	//wait for close
	getchar();
}
