#ifndef STD_BOOL_H
#define STD_BOOL_H

#if !defined(MAC) && !defined(IOS)
#if !defined(USE_DK) && !defined(OSG_LIBRARY_STATIC)
typedef int bool;
#endif
#endif

#define false 0
#define true 1

#endif