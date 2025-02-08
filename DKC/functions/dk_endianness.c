// https://sourceforge.net/p/predef/wiki/Endianness/

#include "dk_endianness.h"
#include <stdint.h>


//##########################################################################
// int dk_endianness()
//
//	Get the endianness of the system at run time.
//
int dk_endianness(void) {
	union{
		uint32_t value;
		uint8_t data[sizeof(uint32_t)];
	} 	number;

	number.data[0] = 0x00;
	number.data[1] = 0x01;
	number.data[2] = 0x02;
	number.data[3] = 0x03;

	switch (number.value){
		case UINT32_C(0x00010203): return ENDIAN_BIG;
		case UINT32_C(0x03020100): return ENDIAN_LITTLE;
		case UINT32_C(0x02030001): return ENDIAN_BIG_WORD;
		case UINT32_C(0x01000302): return ENDIAN_LITTLE_WORD;
		default:                   return ENDIAN_UNKNOWN;
	}
}







//###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#ifndef DKMAIN
#define DKMAIN 1
#include <stdio.h>
#include "dk_echo.h"
int main() {
	switch(dk_endianness()){
		case ENDIAN_BIG:			dk_echo("endianness = ENDIAN_BIG\n"); 			break;
		case ENDIAN_LITTLE:			dk_echo("endianness = ENDIAN_LITTLE\n"); 		break;
		case ENDIAN_BIG_WORD:		dk_echo("endianness = ENDIAN_BIG_WORD\n"); 		break;
		case ENDIAN_LITTLE_WORD:	dk_echo("endianness = ENDIAN_LITTLE_WORD\n"); 	break;
		case ENDIAN_UNKNOWN: 		dk_echo("endianness = ENDIAN_UNKNOWN\n"); 		break;
		default:					dk_echo("endianness = ENDIAN_UNKNOWN\n");
	}
    return 0;
}
#endif