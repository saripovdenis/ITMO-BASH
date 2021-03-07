string=""
value=""

while [ "$value" != "q" ]
	do
		string+=" $value"
		read value
	done
echo $string
