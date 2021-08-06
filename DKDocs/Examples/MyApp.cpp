#include "MyClass.h"

void main()
{
	MyClass myclass;
	
	///////////
	int getNum;
	MyFuncs::CallFunc("MyClass::GetNumber", NULL, &getNum);
	printf("MyClass::GetNumber = %d \n", getNum);
	
	///////////////////
	std::string getStr;
	MyFuncs::CallFunc("MyClass::GetString", NULL, &getStr);
	printf("MyClass::GetString = %s \n", getStr.c_str());

	////////////////////////////////////
	MyStruct* getPoint = new MyStruct();
	MyFuncs::CallFunc("MyClass::GetPointer", NULL, getPoint);
	printf("MyClass::GetPointer num = %d \n", getPoint->num);
	printf("MyClass::GetPointer name = %s \n", getPoint->name.c_str());
	
	/////////////////////
	int editNumIn = 4321;
	int editNumOut;
	MyFuncs::CallFunc("MyClass::EditNumber", &editNumIn, &editNumOut);
	printf("MyClass::EditNumber = %d \n", editNumOut);
	
	//////////////////////////////////////
	std::string editStrIn = "Edit String";
	std::string editStrOut;
	MyFuncs::CallFunc("MyClass::EditString", &editStrIn, &editStrOut);
	printf("MyClass::EditString = %s \n", editStrOut.c_str());
	
	//////////////////////////////
	MyStruct* in = new MyStruct();
	in->num = 1;
	in->name = "Edit Pointer";
	MyStruct* out = new MyStruct();
	MyFuncs::CallFunc("MyClass::EditPointer", in, out);
	printf("MyClass::EditPointer num = %d \n", out->num);
	printf("MyClass::EditPointer name = %s \n", out->name.c_str());

	getchar(); //wait for close
}
