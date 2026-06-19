@Set "Src=www.Dostips.com"
@Setlocal Disabledelayedexpansion
@Set "T=Echo @Set "Src=www.Dostips.com"&Echo @Setlocal Disabledelayedexpansion&Echo @Set "T=!T!"&Call Echo @Set "E=!E!E!E!!E!E!E!"&Echo @Cmd /V:On /C "!E!T!E!""
@Set "E=%%"
@Cmd /V:On /C "%T%"
