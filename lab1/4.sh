#!usr/bin/bash

#if ["${PWD##/home}" != "${PWD}" ]
#then echo "What are you doing here? Go back HOME!" ; exit 1
#else echo "$HOME" ; exit 0
#fi

case $PWD in
	$HOME*)
		echo "you are in home"
		echo "$HOME"
		exit 0
		;;
	*)
		echo "you are not home"
		exit 1
		;;
esac

