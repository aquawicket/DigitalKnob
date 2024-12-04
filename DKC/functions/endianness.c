// https://sourceforge.net/p/predef/wiki/Endianness/

#include "endianness.h"
#include <stdint.h>


//##########################################################################
// int endianness()
//
//	Get the endianness of the system at run time.
//
int endianness(void) {
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
#ifdef DKTEST
#include <stdio.h>
int main() {
	switch(endianness()){
		case ENDIAN_BIG:			printf("endianness = ENDIAN_BIG\n"); 			break;
		case ENDIAN_LITTLE:			printf("endianness = ENDIAN_LITTLE\n"); 		break;
		case ENDIAN_BIG_WORD:		printf("endianness = ENDIAN_BIG_WORD\n"); 		break;
		case ENDIAN_LITTLE_WORD:	printf("endianness = ENDIAN_LITTLE_WORD\n"); 	break;
		case ENDIAN_UNKNOWN: 		printf("endianness = ENDIAN_UNKNOWN\n"); 		break;
		default:					printf("endianness = ENDIAN_UNKNOWN\n");
	}
    return 0;
}
#endif