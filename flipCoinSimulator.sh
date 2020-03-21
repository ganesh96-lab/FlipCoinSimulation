#!/bin/bash -x

#function to display  head or tail 
function  displayHeadTail(){

   randomCoin=$((RANDOM%2))
	if [[ $randomCoin -eq 1 ]]
	then
		echo "Head"
	else
		echo "Tail"
	fi
}

displayHeadTail
