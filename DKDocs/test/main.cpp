#include <iostream>
#include <string>

#define KLASS_NAME  "Global"


#define DKTODO() Log(std::string() + "TODO: " + __FUNCTION__ + "()")

void Log(const std::string& input){
	printf("%s", input.c_str());
}

int main(){
	DKTODO();
}