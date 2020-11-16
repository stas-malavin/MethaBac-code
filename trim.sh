#!/bin/bash

# Pass arguments to this script as positional
READ1=$1
READ2=$2
ADAPTER=$3
THREADS=16

# Trim the reads
TrimmomaticPE -threads $THREADS -phred33 \ # Assumes Trimmomatic binaries in the $PATH
	$READ1 $READ2 $READ1-pair.fq.gz $READ1-unpair.fq.gz \
	$READ2-pair.fq.gz $READ2-unpair.fq.gz \
	ILLUMINACLIP:$ADAPTER:2:40:15 HEADCROP:10 MINLEN:230 # Adjust clip parameters here

