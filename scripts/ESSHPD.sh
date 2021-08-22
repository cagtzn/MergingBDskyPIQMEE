#!/bin/bash
#
#Requires .log files in pwd
#Requires R scripts in ../rthings/
#No arguments, change sim number manually if needed (default=100)
######
#!!!!!!!!!!!!!Define Rscript path!!!!!!!!!!!!!!!!!!
######
rscriptPath='path to rscript'
######
#!!!!!!!!!!!!!Define Rscript path!!!!!!!!!!!!!!!!!!
######
mkdir HPDs
mkdir ESSs
### Initialize text files
awk 'BEGIN {print "Not Enough ESS"}' > Problems.txt
awk 'BEGIN {print "Height HPDs"}' > heightHPD.txt
awk 'BEGIN {print "Rho HPDs"}' > rhoHPD.txt
awk 'BEGIN {print "Re HPDs"}' > ReHPD.txt
for ((i=1; i<=100; i++)); do
	echo -ne "($i/100)\r"
	if test -f "$i"_*_BDSC.piqmee.tree.log; then
		ess=$("$rscriptPath" ../rthings/findESS.r $i"_*_BDSC.piqmee.tree.log" | sed "s/\[.\]//g" | tr -d "\t\n\r")
		if [[ $ess != *'"="' ]]; then
		echo $i$ess  >> Problems.txt ; fi
		"$rscriptPath" ../rthings/findHPD.r $i"_*_BDSC.piqmee.tree.log"
		(sed -n "2p" < $i'_'*'HPD.txt' ) | awk '{print $3, $4}' >> heightHPD.txt
		(sed -n "3p" < $i'_'*'HPD.txt' ) | awk '{print $2, $3}' >> rhoHPD.txt
		(sed -n "4p" < $i'_'*'HPD.txt' ) | awk '{print $2, $3}' >> ReHPD.txt
	else 
		echo "$i does not exist"
		echo "0 0" >> heightHPD.txt
		echo "0 0" >> rhoHPD.txt
		echo "0 0" >> ReHPD.txt
	fi
done
mv *_*HPD.txt HPDs/
mv *_*ESS.txt ESSs/
