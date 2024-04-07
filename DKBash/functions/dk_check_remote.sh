# dk_include_guard()

##################################################################################
# dk_check_remote()
#
#
dk_check_remote () {
	dk_debug "dk_check_remote($@)"
	if [ -d .git ]; then
		git remote update > /dev/null 2> /dev/null
		branch=$(git rev-parse --abbrev-ref HEAD)
		ahead=$(git rev-list --count origin/$branch..$branch)
		behind=$(git rev-list --count $branch..origin/$branch)
		echo "$ahead commits ahead, $behind commits behind"
	fi
}