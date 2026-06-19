@echo off
STRINGS %ComSpec% | RXGREP "[\n\r]CLS[\n\r][\w\W\n\r]*COMSPEC[\n\r]" | SORT | RXGREP "([A-Z]+[\n\r]+)+" | SORT
pause