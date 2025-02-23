#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"


##################################################################################
# dk_signalHandler()
#
#
dk_signalHandler() {
	#dk_debugFunc 1
	local signal_name="${1}"
	echo "Signal $signal_name received."
	continue
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	#dk_debugFunc 0
	
	dk_signalHandler
}

# trap "" INT     					# ignore a signal
# trap - INT						# reset a signal to default

# catch a signal
set -o monitor
trap 'dk_signalHandler ERR' 	ERR
trap 'dk_signalHandler SIGABRT' SIGABRT     # SIGABRT	6	Terminate (core dump)	Process abort signal
trap 'dk_signalHandler SIGALRM' SIGALRM     # SIGALRM	14	Terminate	Alarm clock
trap 'dk_signalHandler SIGBUS' SIGBUS       # SIGBUS	—	Terminate (core dump)	Access to an undefined portion of a memory object
#trap 'dk_signalHandler SIGCHLD' SIGCHLD     # SIGCHLD	—	Ignore	  Child process terminated, stopped, or continued
trap 'dk_signalHandler SIGCONT' SIGCONT     # SIGCONT	—	Continue  Continue executing, if stopped
trap 'dk_signalHandler SIGFPE' SIGFPE       # SIGFPE	8	Terminate (core dump)	Erroneous arithmetic operation
trap 'dk_signalHandler SIGHUP' SIGHUP       # SIGHUP	1	Terminate Hangup
trap 'dk_signalHandler SIGILL' SIGILL       # SIGILL	4	Terminate (core dump)	Illegal instruction
trap 'dk_signalHandler SIGINT' SIGINT       # SIGINT	2	Terminate	Terminal interrupt signal
trap 'dk_signalHandler SIGKILL' SIGKILL     # SIGKILL	9	Terminate	Kill (cannot be caught or ignored)
trap 'dk_signalHandler SIGPIPE' SIGPIPE     # SIGPIPE	13	Terminate	Write on a pipe with no one to read it
#trap 'dk_signalHandler SIGPOLL' SIGPOLL     # SIGPOLL	—	Terminate	Pollable event
trap 'dk_signalHandler SIGPROF' SIGPROF     # SIGPROF	—	Terminate	Profiling timer expired
trap 'dk_signalHandler SIGQUIT' SIGQUIT	    # SIGQUIT   3	Terminate (core dump)	Terminal quit signal
trap 'dk_signalHandler SIGSEGV' SIGSEGV     # SIGSEGV	11	Terminate (core dump)	Invalid memory reference
trap 'dk_signalHandler SIGSTOP' SIGSTOP     # SIGSTOP	—	Stop	  Stop executing (cannot be caught or ignored)
trap 'dk_signalHandler SIGSYS' SIGSYS       # SIGSYS	—	Terminate (core dump)	Bad system call
trap 'dk_signalHandler SIGTERM' SIGTERM     # SIGTERM	15	Terminate	Termination signal
trap 'dk_signalHandler SIGTRAP' SIGTRAP     # SIGTRAP	5	Terminate (core dump)	Trace/breakpoint trap
trap 'dk_signalHandler SIGTSTP' SIGTSTP     # SIGTSTP	—	Stop      Terminal stop signal
trap 'dk_signalHandler SIGTTIN' SIGTTIN     # SIGTTIN	—	Stop	  Background process attempting read
trap 'dk_signalHandler SIGTTOU' SIGTTOU     # SIGTTOU	—	Stop	  Background process attempting write
trap 'dk_signalHandler SIGUSR1' SIGUSR1     # SIGUSR1	—	Terminate	User-defined signal 1
trap 'dk_signalHandler SIGUSR2' SIGUSR2     # SIGUSR2	—	Terminate	User-defined signal 2
trap 'dk_signalHandler SIGURG' SIGURG       # SIGURG	—	Ignore	  Out-of-band data is available at a socket
trap 'dk_signalHandler SIGVTALRM' SIGVTALRM # SIGVTALRM	—	Terminate	Virtual timer expired
trap 'dk_signalHandler SIGXCPU' SIGXCPU     # SIGXCPU	—	Terminate (core dump)	CPU time limit exceeded
trap 'dk_signalHandler SIGXFSZ' SIGXFSZ     # SIGXFSZ	—	Terminate (core dump)	File size limit exceeded
trap 'dk_signalHandler SIGWINCH' SIGWINCH   # SIGWINCH  —	Ignore	  Terminal window size changed

