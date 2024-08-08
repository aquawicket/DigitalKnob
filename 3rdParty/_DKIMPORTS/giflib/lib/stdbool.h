#ifndef STD_BOOL_H
#define STD_BOOL_H

//#ifndef __cplusplus
//#include <stdbool.h>
//#endif

#ifndef __cplusplus
//#ifndef _BOOL
typedef unsigned char bool;
static const bool false = 0;
static const bool true = 1;
//#endif
#endif 

//old way
//#if !defined(MAC) && !defined(IOS)
//#if !defined(HAVE_DK) && !defined(OSG_LIBRARY_STATIC)
//typedef unsigned char bool;
//#endif
//#endif
//#define false 0
//#define true 1

#endif