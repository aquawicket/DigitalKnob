#include <stdlib.h>

int mbtowc(wchar_t *wcp, const char *p, size_t n) {
    *wcp = *p;
    return 1;
}
