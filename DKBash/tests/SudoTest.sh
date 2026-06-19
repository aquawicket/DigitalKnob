#export MyPassword=2393

sudo_exe() {
    [ -n "${MyPassword-}" ] && { 
		echo "$MyPassword" | sudo -S -k "$@";
	} || { 
		sudo "$@";
	}
	echo $?;
	return $?;
}


sudo_exe vlah || echo no;
echo "we have passed the test"
read -p ''

