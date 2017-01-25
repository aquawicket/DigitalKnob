#include "MyClass.h"

void main()
{
	MyClass myclass;
	
	int getNum;
	MyFuncs::CallFunc("MyClass::GetNumber", NULL, &getNum);  //atempting to fill the variable
	printf("MyClass::GetNumber = %d \n", getNum);
	
	std::string getStr;
	MyFuncs::CallFunc("MyClass::GetString", NULL, &getStr);  //atempting to fill the variable
	printf("MyClass::GetString = %s \n", getStr.c_str());
	
	int editNumIn = 4321;
	int editNumOut;
	MyFuncs::CallFunc("MyClass::EditNumber", &editNumIn, &editNumOut);  //atempting to fill the variable
	printf("MyClass::EditNumber = %d \n", editNumOut);
	
	std::string editStrIn = "Edit test";
	std::string editStrOut;
	MyFuncs::CallFunc("MyClass::EditString", &editStrIn, &editStrOut);  //atempting to fill the variable
	printf("MyClass::EditString = %s \n", editStrOut.c_str());

	getchar(); //wait for close
}
