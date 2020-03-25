#!/bin/bash -x

#CONSTANT
HEAD=1
TAIL=0

#DICTIONARYS
declare -A singletDict
declare -A doubletDict
declare -A triplateDict

#function
function readValue(){

	read -p "Enter how many times flip the coin : " noOfTimesFlipCoin
}

function random(){

	randomVal=$((RANDOM%2))
	echo $randomVal
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

#function to find combination of singlet and store percent in  dictionary
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
	singletDict[headPer]=$hPercent
	singletDict[tailPer]=$tPercent
	#display head and tail percentage
	echo "headPer : " ${singletDict[headPer]}
	echo "tailPer : " ${singletDict[tailPer]}

	echo $singletDict
	#calling function of winning combination
	singletWinComb
}

#function to find singlet winning ombination
function singletWinComb(){

	maxPercent=0
	for percent in "${singletDict[@]}"
	do

		greater=$(echo "$percent > $maxPercent" | bc -q)
		if [ $greater -eq 1 ]
		then
			maxPercent=$percent
		fi
	done
	winCount=0
	for comb in "${!singletDict[@]}"
	do
		equal=$(echo "${singletDict[$comb]}==$maxPercent" | bc -q)
		if [ $equal -eq 1 ]
		then
			winningcomb[((winCount++))]=$comb
		fi
	done
	echo "winning combinatuion : ${winningcomb[@]}"
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

	doubletDict[perHH]=$perHH
	doubletDict[perTH]=$perTH
	doubletDict[perHT]=$perHT
	doubletDict[perTT]=$perTT

	#printing key value pairs
	for key in "${!doubletDict[@]}"
	do
		echo "$key : ${doubletDict[$key]}"
	done
	echo $doubletDict

	#calling function of winning combination
	doubletWinComb
}

# function to find winning combination in doublet 
function doubletWinComb(){

	maxPercent=0
	for percent  in "${doubletDict[@]}"
	do
		greater=$(echo "$percent > $maxPercent" | bc -q)
		if [ $greater -eq 1 ]
		then
			maxPercent=$percent
		fi
	done

	winCount=0
	for comb in "${!doubletDict[@]}"
	do
		equal=$(echo "${doubletDict[$comb]}==$maxPercent" | bc -q)
		if [ $equal -eq 1 ]
		then
			winningcombs[((winCount++))]=$comb
		fi
	done
	echo "winning Doublet Combination : ${winningcombs[@]}"
}

#function to find combination of triplate and store the percent  in dictionary
function triplate(){
	echo "............Triplate.........."
	readValue
	HHH=0
	HHT=0
	HTH=0
	THH=0
	HTT=0
	THT=0
	TTH=0
	TTT=0

	for (( flip=1; flip<=$noOfTimesFlipCoin; flip++ ))
	do

	 	randomFlip1="$( random $randomVal )"
	   randomFlip2="$( random $randomVal )"
  		randomFlip3="$( random $randomVal )"


		if [[ $randomFlip1 -eq $HEAD && $randomFlip2 -eq $HEAD && $randomFlip3 -eq $HEAD ]]
		then
			((HHH++))
		elif [[ $randomFlip1 -eq $HEAD && $randomFlip2 -eq $HEAD && $randomFlip3 -eq $TAIL ]]
		then
			((HHT++))
		elif [[ $randomFlip1 -eq $HEAD && $randomFlip2 -eq $TAIL && $randomFlip3 -eq $HEAD ]]
		then
			((HTH++))
		elif [[ $randomFlip1 -eq $TAIL && $randomFlip2 -eq $HEAD && $randomFlip3 -eq $HEAD ]]
		then
			((THH++))
		elif [[ $randomFlip1 -eq $HEAD && $randomFlip2 -eq $TAIL && $randomFlip3 -eq $TAIL ]]
		then
			((HTT++))
		elif [[ $randomFlip1 -eq $TAIL && $randomFlip2 -eq $HEAD && $randomFlip3 -eq $TAIL ]]
		then
			((THT++))
		elif [[ $randomFlip1 -eq $TAIL && $randomFlip2 -eq $TAIL && $randomFlip3 -eq $HEAD ]]
		then
			((TTH++))
	   elif [[ $randomFlip1 -eq $TAIL && $randomFlip2 -eq $TAIL && $randomFlip3 -eq $TAIL ]]
		then
			((TTT++))
		fi
	done

	#find percentage of combination
	perHHH=`echo "scale=2; $HHH*100/$noOfTimesFlipCoin" | bc`
	perHHT=`echo "scale=2; $HHT*100/$noOfTimesFlipCoin" | bc`
	perHTH=`echo "scale=2; $HTH*100/$noOfTimesFlipCoin" | bc`
	perTHH=`echo "scale=2; $THH*100/$noOfTimesFlipCoin" | bc`
	perHTT=`echo "scale=2; $HTT*100/$noOfTimesFlipCoin" | bc`
	perTHT=`echo "scale=2; $THT*100/$noOfTimesFlipCoin" | bc`
	perTTH=`echo "scale=2; $TTH*100/$noOfTimesFlipCoin" | bc`
	perTTT=`echo "scale=2; $TTT*100/$noOfTimesFlipCoin" | bc`

	#store percentage of combination in dictionary
	triplateDict[perHHH]=$perHHH
	triplateDict[perHHT]=$perHHT
	triplateDict[perHTH]=$perHTH
	triplateDict[perTHH]=$perTHH
	triplateDict[perHTT]=$perHTT
	triplateDict[perTHT]=$perTHT
	triplateDict[perTTH]=$perTTH
	triplateDict[perTTT]=$perTTT

	for key in "${!triplateDict[@]}"
	do
		echo "$key : ${triplateDict[$key]}"
	done
	#calling the  triplateWinComb function
	triplateWinComb
}

#Function to find the winning combination of triplate
function triplateWinComb(){

   maxPercent=0
   for percent  in "${triplateDict[@]}"
   do
      greater=$(echo "$percent > $maxPercent" | bc -q)
      if [ $greater -eq 1 ]
      then
         maxPercent=$percent
      fi
   done

   winCount=0
   for comb in "${!triplateDict[@]}"
   do
      equal=$(echo "${triplateDict[$comb]}==$maxPercent" | bc -q)
      if [ $equal -eq 1 ]
      then
         winningcombination[((winCount++))]=$comb
      fi
   done
   echo "winning triplate Combination : ${winningcombination[@]}"

}

displayHeadTail
singlet
doublet
triplate
