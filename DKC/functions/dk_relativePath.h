#pragma once
#ifndef dk_relativePath_h
#define dk_relativePath_h

#include "DK.h"


//################################################################################
//# dk_relativePath()
//#
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>
char* dk_relativePath(const char* from, const char* to) {
    char resolved_path[2056];
    char* result;

    // Get absolute paths
    realpath(from, resolved_path);
    char* abs_from = strdup(resolved_path);
    realpath(to, resolved_path);
    char* abs_to = strdup(resolved_path);

    // Find common prefix
    char* common_prefix = abs_from;
    while (*common_prefix == *abs_to) {
        common_prefix++;
        abs_from++;
        abs_to++;
    }

    // Build relative path
    result = malloc(strlen(abs_to) + strlen(abs_from) + 2);
    strcpy(result, "");

    // Add ".." for each directory level up
    while (*abs_from != '\0') {
        if (*abs_from == '/') {
            strcat(result, "../");
        }
        abs_from++;
    }

    // Add the remaining part of the target path
    strcat(result, abs_to);

    free(abs_from - strlen(common_prefix));
    free(abs_to - strlen(common_prefix));

    return result;
}

#endif //dk_relativePath_h