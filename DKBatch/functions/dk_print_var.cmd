::include_guard()

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: dk_print_var(variable)
::
::
:dk_print_var() {
	call dk_verbose dk_print_var(%*)
	if "" == "$1" (
		call dk_error "dk_print_var <variable> requires 1 parameter"
		echo return $false
	)
	
	set var_name=%1
	set exists=0
	
::	if [[ $(type -t $1) == function ]]; then
::		dk_debug "${blue} \$$var_name = function $1() ${clr}"
::		func=$(type $1 | sed '1,2d')
::		dk_debug "${blue} $func ${clr}"
::		exists=1;
::	fi
		
::	if ! [ -v $1 ]; then
::		if [ $exists -eq 1 ]; then
::			return $true
::		fi
::			
::		dk_warning "${red} \$$1 is not set ${clr}"
::		return $false
::	fi
::		
::	if $(declare -p $1 2> /dev/null | grep -q '^declare \-a'); then	
::		declare -n arr="$1"
::		for ((i=0; i < ${::arr[@]}; i++ )); do 
::			dk_debug "${blue} \$$var_name[$i] = ${arr[$i]} ${clr}";
::		done
::	else
		set arr=%1
		call set "value=%%%arr%%%"
		dk_debug "%blue% %arr% = %value% %clr%"
::	fi
goto:eof