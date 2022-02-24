#include "GenericClass.h"


std::string GenericClass::static_str_var = "initial string";


GenericClass(){
	printf("GenericClass::constructor");
}

~GenericClass(){
	printf("GenericClass::destructor");
}
	
void FuncA(){
	printf("GenericClass::FuncA");
}

int FuncB(int num){
	printf("GenericClass::FuncB");
	return 2;
}

char* FuncC(char* str){
	printf("GenericClass::FuncC");
	return "a char pointer string";
}

std::string FuncD(std::string* str){
	printf("GenericClass::FuncD");
	return "a std string";
}

void* FuncE(void* var){
	
	printf("GenericClass::FuncE");
	return nulptr;
}

static void FuncF(){
	printf("GenericClass::FuncF");
}	

static int FuncG(int num){
	printf("GenericClass::FuncG");
	return 7;
}
