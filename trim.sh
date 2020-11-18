#!/bin/bash
# Assumes Trimmomatic binaries in the $PATH

# Pass arguments to this script as positional
BASE=$1
ADAPTER="/home/stas/Programs/Trimmomatic-0.39/adapters/NexteraPE-PE.fa"
THREADS=8

# Trim the reads
java -jar /home/stas/Programs/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
	-threads $THREADS -phred33 -basein $BASE -baseout $BASE-trimmed.fq.gz \
	ILLUMINACLIP:$ADAPTER:2:40:15:1:true \
	HEADCROP:10 \
	SLIDINGWINDOW:4:15 \
	MINLEN:230
#Input Read Pairs: 3320440 Both Surviving: 2270707 (68.39%) Forward Only Surviving: 174184 (5.25%) Reverse Only Surviving: 23857 (0.72%) Dropped: 851692 (25.65%)
