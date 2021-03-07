
printf 'This is a text menu\n'
printf '1. Start nano.\n'
printf '2. Start vi.\n'
printf '3. Start ELinks.\n'
printf '4. Quit.\n'

read command
case $command in
	1)
	#start nano
	echo "starting nano..."
	/usr/bin/nano
	;;
	2)
	#start vi
	echo "starting vi..."
	/usr/bin/vi
	;;
	3)
	#start links
	echo "starting links"
	links
	;;
	*)
	#quit?
	echo "exit.."
	exit
	;;
esac
