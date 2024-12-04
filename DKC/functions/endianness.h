//###### endianness.h ######
#pragma once
#ifndef endianness_H
#define endianness_H

enum {
	ENDIAN_UNKNOWN,
	ENDIAN_BIG,
	ENDIAN_LITTLE,
	ENDIAN_BIG_WORD,   /* Middle-endian, Honeywell 316 style */
	ENDIAN_LITTLE_WORD /* Middle-endian, PDP-11 style */
};

int endianness(void);

#endif //endianness_H