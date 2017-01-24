#include "MyClass.h"

void main()
{
	MyClass myclass;
	
	int getNum;
	MyFuncs::CallFunc("MyClass::GetNumber", NULL, static_cast<void*>(&getNum));  //atempting to fill the variable
	printf("MyClass::GetNumber = %d \n", getNum);
	
	std::string getStr;
	MyFuncs::CallFunc("MyClass::GetNumber", NULL, static_cast<void*>(&getStr));  //atempting to fill the variable
	printf("MyClass::GetNumber = %d \n", getStr.c_str());
	

	int editNum = 321;
	int editNumOut;
	MyFuncs::CallFunc("MyClass::EditNumber", static_cast<void*>(&editNum), static_cast<void*>(&editNumOut));  //atempting to change the variable
	printf("MyClass::EditNumber = %d \n", editNumOut);

	std::string editStr = "Edit Test";
	std::string editStrOut;
	MyFuncs::CallFunc("MyClass::EditNumber", static_cast<void*>(&editStr), static_cast<void*>(&editStrOut));  //atempting to change the variable
	printf("MyClass::EditString = %s \n", editStrOut);

	//wait for close
	getchar();
}
