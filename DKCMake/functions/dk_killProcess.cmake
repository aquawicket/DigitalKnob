include_guard()

###############################################################################
# dk_killProcess(name)
#
#	Kill a running process by name
#
#	@name		- name of the process to kill
#
function(dk_killProcess name)
	DKDEBUGFUNC(${ARGV})
	dk_executeProcess("taskkill /f /im ${name}" NOASSERT)
endfunction()