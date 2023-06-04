#!/bin/bash
set -x

filename='PIN_20211012.txt'

allmunis=(
	"SAFETY HARBOR"
	DUNEDIN
	"ST PETERSBURG"
	CLEARWATER
	"KENNETH CITY"
	LARGO
	"PINELLAS PARK"
	"PALM HARBOR"
	GULFPORT
	SEMINOLE
	OLDSMAR
	"TIERRA VERDE"
	"ST PETE BEACH"
	"BELLEAIR BLUFFS"
	"REDINGTON BEACH"
	"TREASURE ISLAND"
	"TARPON SPRINGS"
	"REDINGTON SHORES"
	BELLEAIR
	"MADEIRA BEACH"
	)

munis=(
	DUNEDIN
	GULFPORT
	)


for i in "${munis[@]}"; do
   rm $i.tmp
done

for i in "${munis[@]}"; do
   grep "$i" $filename > $i.tmp
   cat $i.tmp | awk 'BEGIN { FS = "\t" } ; { print $8}' > $i.tmp2
done

<<comment
for i in "${munis[@]}"; do
    echo "Municipality: $i"
    echo
    grep "$i" $filename | grep "`awk 'BEGIN { FS = "\t" } ; { print $8}'`" $filename
    echo "-------------------------------------------------------------------------"
done
comment


#echo $line | awk 'BEGIN { FS = "\t" } ; { print $1 }'
#done < $filename


#cat $filename | awk 'BEGIN { FS = "\t" } ; { print $8 "," $10}'

#grep "6300   46TH AVE N" PIN_20211012.txt | awk 'BEGIN { FS = "\t" } ; { print $3 "," $5 "|" $20 " " $22 " - " $8 "," $10}' | sort

