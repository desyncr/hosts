# creates hosts.d directory and optionally
# copies all files at $1 to it and compiles them into /etc/hosts
install-hosts () {
	if [[ ! -d "$1" ]]; then
		echo Specify a hosts folder
	else
		sudo cp "$1" /etc/hosts.d -r
		update-hosts
	fi
}

# compiles all hosts.d files into /etc/hosts 
update-hosts () {
	echo Overwriting your /etc/hosts file with the content of /etc/hosts.d
	if [[ ! -d /etc/hosts.d ]]; then
		echo No hosts.d found. Run install-hosts
	else
		cat /etc/hosts.d/* > /tmp/hosts-compiled
		sudo mv /tmp/hosts-compiled /etc/hosts
	fi
}

# retrieves an update list of adblockers
# updates and compiles hosts.d
update-adblock () {
	curl https://someonewhocares.org/hosts/zero/hosts -o /etc/adblock-list 2> /dev/null
	sudo mv /tmp/adblock-list /etc/hosts.d/adblock-list
	update-hosts
}
