#!/bin/bash -x

#CONSTANT
HEAD=1
TAIL=0

declare -A singlet


#function 
function readValue(){
	read -p "Enter how many times flip the coin : " noOfTimesFlipCoin
}

#function to display  head or tail 
function  displayHeadTail(){

   randomFlip=$((RANDOM%2))
	if [[ $randomFlip -eq $HEAD ]]
	then
		echo "Head"
	else
		echo "Tail"
	fi
}

function singlet(){
	readValue
	countH=0
	countT=0
	for (( flip=1; flip<=$noOfTimesFlipCoin; flip++ ))
	do
		randomFlip=$((RANDOM%2))
      if [ $randomFlip -eq $HEAD ]
		then
				((countH++))
		else
				((countT++))
		fi
	done
	#calculate head and tail percent
	hPercent=`echo "scale=2; $countH *100 / $noOfTimesFlipCoin" | bc`
	tPercent=`echo "scale=2; $countT *100 / $noOfTimesFlipCoin" | bc`
	#store head and tail percentage in dictionary
	singlet[headPer]=$hPercent
	singlet[tailPer]=$tPercent
	#display head and tail percentage
	echo "headPer : " ${singlet[headPer]}
	echo "tailPer : " ${singlet[tailPer]}

	echo $singlet
}

displayHeadTail
singlet
