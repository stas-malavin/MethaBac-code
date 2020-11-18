#!/bin/bash
# Assumes Trimmomatic binaries in the $PATH

# Pass arguments to this script as positional
BASE=$1
ADAPTER=$2
THREADS=16

# Trim the reads
#TrimmomaticPE -threads $THREADS -phred33 -basein $BASE -baseout $BASE-trimmed.fq.gz \
	#ILLUMINACLIP:$ADAPTER:2:40:15:1:true \
	#HEADCROP:10 \
	#SLIDINGWINDOW:4:15 \
	#MINLEN:230 \
#$Input Read Pairs: 3320440 Both Surviving: 2274250 (68.49%) Forward Only Surviving: 93298 (2.81%) Reverse Only Surviving: 422721 (12.73%) Dropped: 530171 (15.97%)

TrimmomaticPE -threads $THREADS -phred33 -basein $BASE -baseout $BASE-trimmed.fq.gz \
	ILLUMINACLIP:$ADAPTER:2:40:15:1:true \
	HEADCROP:10 \
	MINLEN:230
#$Input Read Pairs: 3320440 Both Surviving: 2413096 (72.67%) Forward Only Surviving: 0 (0.00%) Reverse Only Surviving: 907339 (27.33%) Dropped: 5 (0.00%)
