#!/bin/bash

LISTPATH=/home/nikita/prog/bash/radio/radiolist
num_re='^[0-9]+$'
hotkeys=(
		"--global-key-quit alt-x"
		"--global-key-play-pause alt-p"
)

if [[ $1 =~ $num_re ]]; then
	stations_num=$(wc -l $LISTPATH | grep -Eo "[0-9]+ ")
	if [[ $1 -gt $stations_num ]] || [[ $1 -eq 0 ]]; then
			exit 0;
	fi

	url=$(head -$1 $LISTPATH| tail -1 | grep -Eo ".+  ")
	cvlc --verbose 0 ${hotkeys[*]} $url
elif [[ $1 == "list" ]]; then
		cat $LISTPATH | grep -Eon "  .+";
else
		exit 0;	
fi
