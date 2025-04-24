//###### dk_endianness_h ######
#pragma once
#ifndef dk_endianness_h
#define dk_endianness_h

enum {
	ENDIAN_UNKNOWN,
	ENDIAN_BIG,
	ENDIAN_LITTLE,
	ENDIAN_BIG_WORD,   /* Middle-endian, Honeywell 316 style */
	ENDIAN_LITTLE_WORD /* Middle-endian, PDP-11 style */
};

int dk_endianness(void);

#endif //dk_endianness_h