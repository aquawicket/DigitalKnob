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
	MyFuncs::CallFunc("MyClass::EditNumber", static_cast<void*>(&editNum), output);  //atempting to change the variable
	
	std::string editString = "Edit Test";
	MyFuncs::CallFunc("MyClass::EditNumber", static_cast<void*>(&editNum), output);  //atempting to change the variable
}
