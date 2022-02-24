#pragma once
#ifndef GenericClass_H
#define GenericClass_H

class GenericClass
{
public:
	GenericClass();  // Constructor
	~GenericClass(); // Destructor
	
	//Member methods
	void FuncA();
	int FuncB(int num);
	char* FuncC(char* str);
	std::string FuncD(std::string* str);
	void* FuncE(void* var)
	static void FuncF();
	static int FuncG(int num);
	
	//Member variables
	int integer_var;
    char* char_pointer_var;
	std::string& reference_var;
	static std::string statis_str_var;
};


#endif //GenericClass_H