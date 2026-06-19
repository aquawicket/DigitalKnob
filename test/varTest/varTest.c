// shebang

#include <stdio.h>

int main(){
	char* myVar = "value";
	//printf("myVar = '%s'\n", myVar);	// w/ newline
	printf("myVar = '%s'", myVar);		// no newline
	return 0;
}