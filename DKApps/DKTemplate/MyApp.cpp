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
	
	/*
	int editNum = 321;
	int editNumOut;
	MyFuncs::CallFunc("MyClass::EditNumber", static_cast<void*>(&editNum), static_cast<void*>(&editNumOut));  //atempting to change the variable
	printf("MyClass::EditNumber = %d \n", editNumOut);


	std::string editStr = "Edit Test";
	std::string editStrOut;
	MyFuncs::CallFunc("MyClass::EditNumber", static_cast<void*>(&editStr), static_cast<void*>(&editStrOut));  //atempting to change the variable
	printf("MyClass::EditString = %s \n", editStrOut);
	*/

	//wait for close
	getchar();
}
