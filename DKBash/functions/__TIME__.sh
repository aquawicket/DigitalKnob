#!/bin/sh
[ -z "${DKINIT}" ] && . "${DKBASH_FUNCTIONS_DIR_}DK.sh"



##################################################################################
# __TIME__()
#
#
#
#
__TIME__() {
	#dk_debugFunc 0
	
    nanoseconds="$(date +%s%N)"
    date_nanoseconds="$(( nanoseconds % 1000000000))"

#   microseconds="$(( nanoseconds / 1000))"
#   date_microseconds="$((microseconds % 1000))"
      
    milliseconds="$(( nanoseconds / 1000000))"
    date_milliseconds="$((milliseconds % 1000000))"

    seconds="$((nanoseconds / 1000000000))"
    date_seconds="$(date -d@"$((    seconds % 1000000000))" +"%S")"

#	minutes="$((seconds/60))"
	date_minutes="$(date -d@"$seconds" +"%M")"
#	t_minutes="$((seconds/60%60))"

#	#hours="$((seconds/60/60))"
#	hours="$((seconds/3600))"
    date_hours="$(date -d@"$seconds" +"%H")"
#   t_hours="$((seconds/60/60%24))"

#	#days="$((seconds/60/60/24))"
#	days="$((seconds/86400))"
#	date_days="$(date -d@"$seconds" +"%d")"
#	t_days="$((seconds/60/60%24))"

#	#weeks="$((seconds/60/60/24/7))"
#	weeks="$((seconds/604800))"
#	#date_weeks="$(date -d@"$seconds" +"%d")"
#	t_weeks="$((seconds/60/60/24/7%30))"

#	#months="$((seconds/60/60/24/30))"
#	months="$((seconds/2629746))"
#	date_months="$(date -d@"$seconds" +"%m")"
#	t_months="$((seconds/60/60/24%10))"

#	#years="$((seconds/60/60/24/365))"
#	years="$((seconds/31556952))"
#	date_years="$(date -d@"$seconds" +"%Y")"
#   t_years="$((seconds/60/60/24/7%12))" 

#	decades="$((seconds/315569520))"
#	#date_decades="$((date_years / 10))"
#	#t_decades="$((seconds/60/60/24/365%10))"

#	centuries="$((seconds/3155695200))"
#	#date_centuries="$((date_years / 100))"
#	#t_centuries="$((seconds/60/60/24/365%100))"

#	timestamp="$(date -d@"$seconds" +"%Y-%m-%d-%H:%M:%S")"

#	echo "      nanoseconds = ${nanoseconds}"
#	echo " date_nanoseconds = ${date_nanoseconds}"

#	echo "     microseconds = ${microseconds}"
#	echo "date_microseconds = ${date_microseconds}"

#	echo "     milliseconds = ${milliseconds}"
#	echo "date_milliseconds = ${date_milliseconds}"

#	echo "          seconds = ${seconds}"
#	echo "     date_seconds = ${date_seconds}"

#	echo "          minutes = ${minutes}"
#	echo "     date_minutes = ${date_minutes}"
#	echo "        t_minutes = ${t_minutes}"

#	echo "            hours = ${hours}"
#	echo "       date_hours = ${date_hours}"
#	echo "          t_hours = ${t_hours}"

#	echo "             days = ${days}"
#	echo "        date_days = ${date_days}"
#	echo "           t_days = ${t_days}"

#	echo "            weeks = ${weeks}"
#	#echo "       date_weeks = ${date_weeks}"
#	echo "          t_weeks = ${t_weeks}"

#	echo "           months = ${months}"
#	echo "      date_months = ${date_months}"
#	echo "         t_months = ${t_months}"

#	echo "            years = ${years}"
#	echo "       date_years = ${date_years}"
#	echo "          t_years = ${t_years}"

#	echo "          decades = ${decades}"
#	echo "     date_decades = ${date_decades}"
#	echo "        t_decades = ${t_decades}"

#   echo "        centuries = ${centuries}"
#	echo "   date_centuries = ${date_centuries}"
#	echo "      t_centuries = ${t_centuries}"

#	echo "        timestamp = ${timestamp}"
	dk_return "${date_hours}:${date_minutes}:${date_seconds}.${date_milliseconds}"; return
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	#dk_debugFunc
	
	echo "$(__TIME__)"
}
