#!/bin/bash
# Assumes Trimmomatic binaries in the $PATH

BASE=$1 # The argument to the script, use the name of the forward reads

ADAPTER="/home/stas/Documents/BIOINFO/Methanobacterium/GENOMES/adapters.fa"
# adapters.fa is a combination of Nextera seqs shipped with Trimmomatic 0.39
# and an overrepresented seq in the reads

THREADS=8

# Trim the reads
#java -jar /home/stas/Programs/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
	#-threads $THREADS -phred33 -basein $BASE -baseout $BASE-trimmed.fq.gz \
	#ILLUMINACLIP:$ADAPTER:2:40:15:1:true \
	#HEADCROP:10 \
	#SLIDINGWINDOW:4:15 \
	#MINLEN:230
#Input Read Pairs: 3320440 Both Surviving: 2124804 (63.99%) Forward Only Surviving: 87266 (2.63%) Reverse Only Surviving: 36128 (1.09%) Dropped: 1072242 (32.29%)

#java -jar /home/stas/Programs/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
	#-threads $THREADS -phred33 -basein $BASE -baseout $BASE-trimmed.fq.gz \
	#ILLUMINACLIP:$ADAPTER:2:40:15:1:true \
	#SLIDINGWINDOW:4:15 \
	#MINLEN:230
#Input Read Pairs: 3320440 Both Surviving: 2239208 (67.44%) Forward Only Surviving: 78922 (2.38%) Reverse Only Surviving: 72348 (2.18%) Dropped: 929962 (28.01%)

#java -jar /home/stas/Programs/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
	#-threads $THREADS -phred33 -basein $BASE -baseout $BASE-trimmed.fq.gz \
	#ILLUMINACLIP:$ADAPTER:2:40:15:1:true \
	#HEADCROP:12 \
	#SLIDINGWINDOW:4:15 \
	#MINLEN:230
#Input Read Pairs: 3320440 Both Surviving: 2101285 (63.28%) Forward Only Surviving: 88991 (2.68%) Reverse Only Surviving: 30408 (0.92%) Dropped: 1099756 (33.12%)

#java -jar /home/stas/Programs/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
	#-threads $THREADS -phred33 -basein $BASE -baseout $BASE-trimmed.fq.gz \
	#ILLUMINACLIP:$ADAPTER:2:40:15:1:true \
	#SLIDINGWINDOW:4:15
#Input Read Pairs: 3320440 Both Surviving: 3318674 (99.95%) Forward Only Surviving: 0 (0.00%) Reverse Only Surviving: 1766 (0.05%) Dropped: 0 (0.00%)

java -jar /home/stas/Programs/Trimmomatic-0.39/trimmomatic-0.39.jar PE \
	-threads $THREADS -phred33 -basein $BASE -baseout $BASE-trimmed.fq.gz \
	ILLUMINACLIP:$ADAPTER:2:40:15:1:true \
	SLIDINGWINDOW:4:15 \
	MINLEN:240
#Input Read Pairs: 3320440 Both Surviving: 2124802 (63.99%) Forward Only Surviving: 87267 (2.63%) Reverse Only Surviving: 36129 (1.09%) Dropped: 1072242 (32.29%)
