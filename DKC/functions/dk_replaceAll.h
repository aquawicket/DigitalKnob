#pragma once
#ifndef dk_replaceAll_h
#define dk_replaceAll_h

#include "DK.h"
#include "dk_echo.h"
#include "dk_error.h"


//################################################################################
//# dk_replaceAll(str, find, replace, output)
//#
//#		Reference: https://stackoverflow.com/a/32496721
//#
//# You must free the result if result is non-NULL.
int dk_replaceAll(char *str, char *find, char *replace, char* output) {
    char *result; // the return string
    char *ins;    // the next insert point
    char *tmp;    // varies
    int len_rep;  // length of find (the string to remove)
    int len_replace; // length of replace (the string to replace find with)
    int len_front; // distance between find and end of last find
    int count;    // number of replacements

    // sanity checks and initialization
    if (!str || !find){
        dk_error("!str || !find\n");
		return -1;
	}
    len_rep = strlen(find);
    if (len_rep == 0){
		dk_error("len_rep == 0\n");
        return -1; // empty find causes infinite loop during count
	}
    if (!replace)
        replace = "";
    len_replace = strlen(replace);

    // count the number of replacements needed
    ins = str;
    for (count = 0; (tmp = strstr(ins, find)); ++count) {
        ins = tmp + len_rep;
    }

    tmp = result = malloc(strlen(str) + (len_replace - len_rep) * count + 1);

    if (!result){
		dk_error("return -1 \n");
        return -1;
	}

    // first time through the loop, all the variable are set correctly
    // from here on,
    //    tmp points to the end of the result string
    //    ins points to the next occurrence of find in str
    //    str points to the remainder of str after "end of find"
    while (count--) {
        ins = strstr(str, find);
        len_front = ins - str;
        tmp = strncpy(tmp, str, len_front) + len_front;
        tmp = strcpy(tmp, replace) + len_replace;
        str += len_front + len_rep; // move to next "end of find"
    }
    strcpy(tmp, str);
	strcpy(output, result);
	//strcpy(str, result);
	return 0;
}


#endif //dk_replaceAll_h