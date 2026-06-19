#	> 	– directs the output of a command to a given file.
#	< 	– directs the contents of a given file to a command.
#	>>	– directs the output of a command to a given file. Appends the output if the file exists and has content.
#	2> 	– directs error messages from a command to a given file.
#	2>> – directs an error message from a command to a given file. Appends the error message if the file exists and has content.
#	&> 	– directs standard output and error to a given file.
#	&>> – directs standard output and error to a given file. Appends to the file if it exists and has contents.

#	> 	– directs the output of a command to a given file.
echo "hello world" 2> /dev/null



exec 2> /dev/null  # Redirect stderr to /dev/null

exec 2> /dev/tty   # Redirect stderr to the terminal

exec 2>&1		   # Redirect stderr to stdout

exec 3>&2 			# Saves the original stderr in file descriptor 3
exec 2> /dev/null	# Redirect stderr to /dev/null
### do stuff where you don't want to see the stderr
exec 2>&3			# Restore stderr from file descriptor 3

command_A | command_B  # Pipe the output of command_A to the input of command_B
