@echo off

::###### Load Function files ######
call "../functions/DK.cmd"

set "hex=48656c6c6f20776f726c6421"
call dk_hexToAscii %hex% output
echo %hex% = '%output%'



call dk_pause
