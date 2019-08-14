# Functions
_robo_get_command_list () {
    robo \
    	| sed "1,/Available commands/d" \
    	| awk '/^ +[a-z:]+/ { print $1 }'
}

_robo () {
	if type "robo" > /dev/null; then
        compadd `_robo_get_command_list`
    fi
}

# Completion setup
compdef _robo robo

