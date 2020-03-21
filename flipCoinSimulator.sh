#!/bin/bash -x

#CONSTANT
HEAD=1
TAIL=0

#DICTIONARYS
declare -A singlet
declare -A doublet
declare -A triplate

#function 
function readValue(){
	read -p "Enter how many times flip the coin : " noOfTimesFlipCoin
}

#function to display  head or tail 

function  displayHeadTail(){

	echo "function1 display Head or Tail"
   randomFlip=$((RANDOM%2))
	if [[ $randomFlip -eq $HEAD ]]
	then
		echo "Head"
	else
		echo "Tail"
	fi
}


function singlet(){
	echo "........SINGLET.............."
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

#function for doublet
function doublet(){

	echo "............DOUBLET.................."
	readValue
	HH=0
	TH=0
	HT=0
	TT=0
	for (( flip=1; flip<=$noOfTimesFlipCoin; flip++ ))
	do
		randomFlip1=$((RANDOM%2))
		randomFlip2=$((RANDOM%2))

		if [[ $randomFlip1 -eq $HEAD && $randomFlip2 -eq $HEAD ]]
		then
			((HH++))
		elif [[ $randomFlip1 -eq $TAIL && $randomFlip2 -eq $HEAD ]]
		then
			((TH++))
		elif [[ $randomFlip1 -eq $HEAD && $randomFlip2 -eq $TAIL ]]
		then
			((HT++))
		elif [[ $randomFlip1 -eq $TAIL && $randomFlip2 -eq $TAIL ]]
		then
			((TT++))
		fi
	done

	perHH=`echo "scale=2; $HH * 100 / $noOfTimesFlipCoin" | bc`
	perTH=`echo "scale=2; $TH * 100 / $noOfTimesFlipCoin" | bc`
	perHT=`echo "scale=2; $HT * 100 / $noOfTimesFlipCoin" | bc`
	perTT=`echo "scale=2; $TT * 100 / $noOfTimesFlipCoin" | bc`

	doublet[perHH]=$perHH
	doublet[perTH]=$perTH
	doublet[perHT]=$perHT
	doublet[perTT]=$perTT

	#printing key value pairs
	for key in "${!doublet[@]}"
	do
		echo "$key : ${doublet[$key]}"
	done
}

displayHeadTail
singlet
doublet
