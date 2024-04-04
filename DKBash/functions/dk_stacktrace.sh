#include_guard()

##################################################################################
# dk_stacktrace()
#
#	Print the stack
#
#	reference: https://gitlab.com/kyb/autorsync/-/blob/master/utils.bash#L84
#
dk_stacktrace () { 
   local i=1 line file func
   while read -r line func file < <(caller $i); do
      echo >&2 "[$i] $file:$line $func(): $(sed -n ${line}p $file)"
      ((i++))
   done
}
