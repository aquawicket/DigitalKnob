/*
#include <stdio.h>

int main(int argc, char **argv, char **envp) {
  for (char **env = envp; *env != 0; env++)
  {
    char *thisEnv = *env;
    printf("%s\n", thisEnv);    
  }
  return 0;
}
*/

/*
#include <stdlib.h>
#include <stdio.h>

extern char **environ;

int main(int argc, char **argv) {
    for(char **current = environ; *current; current++) {
        puts(*current);
    }
    return EXIT_SUCCESS;
}
*/

#include <stdlib.h>
#include <stdio.h>

extern char **environ;

int main(int argc, char **argv, char **envp) {
	if(envp != environ){
		printf("ENVP AND ENVIRON ARE NOT THE SAME\n\n");
	}
    for(char **current = environ; *current; current++) {
        puts(*current);
    }
    return EXIT_SUCCESS;
}